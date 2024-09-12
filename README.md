# Neovim Config

This is my neovim config that im making from scratch using lazy.nvim as my package manager

## Todo list
In order from most priority to least priority

None so far!

## New Feature Conditions
As to keep the config clean and concise, I will not add new languages unless its absolutely necessary.
If a new language is in my todo list it means I am testing it out, it doesn't mean that it will go into my config.

## Features Implemented
Finished items in the todo list will be added to this list

1. Python Support
2. Rust Support
3. C/C++ Support
4. Zig Support
5. Typescript Support
6. Tmux integration

## Tmux integration
When using tmux I have made it, so you can run a command. <M-c> opens up a harpoon list with the current commands, with the top most recent command being run.
To add a command use the `:CompileModeCommand` command with your command as the argument. adding `$CURRENT_FILE` will replace that with the current file if you so need it

Assuming you have neovim in your first tab of tmux and your second tab is running your code, <M-r> will run that command in your second tab.
Some examples of how I use this is adding build commands and run commands like `make && ./executable`.
