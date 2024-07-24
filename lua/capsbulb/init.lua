local M = {}

local buflines = require("infra.buflines")
local Ephemeral = require("infra.Ephemeral")
local highlighter = require("infra.highlighter")
local iuv = require("infra.iuv")
local ni = require("infra.ni")
local prefer = require("infra.prefer")
local rifts = require("infra.rifts")

local unsafe = require("capsbulb.unsafe")

local facts = {}
do
  do
    local ns = ni.create_namespace("capsbulb://floatwin")
    local hi = highlighter(ns)
    if vim.go.background == "light" then
      hi("NormalFloat", { fg = 1, bold = true })
      hi("WinSeparator", { fg = 1 })
    else
      hi("NormalFloat", { fg = 1, bold = true })
      hi("WinSeparator", { fg = 1 })
    end
    facts.floatwin_ns = ns
  end
end

do
  local toggle = false
  local timer = iuv.new_timer() ---@type uv_timer_t
  local winid, bufnr = -1, -1

  local function deactivate()
    timer:stop()
    if ni.win_is_valid(winid) then ni.win_close(winid, false) end
    if ni.buf_is_valid(bufnr) then ni.buf_delete(bufnr, { force = false }) end
  end

  local function activate() --
    if not ni.buf_is_valid(bufnr) then bufnr = Ephemeral({ bufhidden = "hide", namepat = "capsbulb://{bufnr}" }) end

    if not ni.win_is_valid(winid) then
      winid = rifts.open.fragment( --
        bufnr,
        false,
        { relative = "editor", focusable = false, hide = true },
        { width = #"Caps OFF", height = 1, horizontal = "mid", vertical = "mid", ns = facts.floatwin_ns }
      )
      prefer.wo(winid, "winfixbuf", true)
    end

    local function update()
      if not ni.win_is_valid(winid) then
        ni.win_set_config(winid, { hide = true })
        timer:stop()
        return
      end

      assert(ni.buf_is_valid(bufnr))
      local on = unsafe.is_capslock_on()
      if not on then return ni.win_set_config(winid, { hide = true }) end

      local text = string.format("Caps %s", on and "ON" or "OFF")
      buflines.replaces_all(bufnr, { text })
      ni.win_set_config(winid, { hide = false })
    end

    timer:stop()
    assert(timer:start(0, 500, vim.schedule_wrap(update)))
  end

  function M.toggle_warn()
    toggle = not toggle
    if toggle then
      activate()
    else
      deactivate()
    end
  end
end

return M
