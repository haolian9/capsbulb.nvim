it shows an indicator when `caps lock` is on

![161159ee-497e-11ef-a85f-54b203702c9c](https://github.com/user-attachments/assets/244111ad-b7b4-4ffb-8284-eb5e8c26e5cd)


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
