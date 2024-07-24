a toy project that shows an indicator when `caps lock` is on

![12ef1864-49c4-11ef-bad8-54b203702c9c](https://github.com/user-attachments/assets/ccd57117-7bac-42ad-adf1-b79f3474a44f)


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
