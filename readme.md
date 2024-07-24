a toy project that shows an indicator when `caps lock` is on

![557a3692-49b9-11ef-aac0-54b203702c9c](https://github.com/user-attachments/assets/601e92c0-480c-447e-8de3-0a6cb9fdbbcb)


## status
* it just works
* the use of ffi may crash nvim
* it uses a timer to poll the state of capslock in every 500ms, so it wont cause too much overhead

## rerequisites
* linux
* libx11 1.8.9
* zig 0.12
* nvim 0.10.*
* haolian9/infra.nvim

## build
* `zig build -Doptimize=ReleaseSafe`

## usage
* `:lua require'capsbulb'.toggle_warn()`

# credits
* https://stackoverflow.com/a/49562685
