# My nvim config

### Plugins
- nvim-cmp (autocompletion)
- conform (autoformat)
- catppuccin (colorscheme)
- telescope (fuzzy finder)
- treesitter (highlight/edit/nav)
- lspconfig + lazydev.nvim (lsp, completions/annotations etc)
- mini (various small independent plugins/modules)
- which-key (show you pending keybinds)
- gitsigns (add git related signs to gutter)

### Plugins I may try
- flash
- https://github.com/nguyenvukhang/nvim-toggler
- https://github.com/code-biscuits/nvim-biscuits
- https://github.com/sitiom/nvim-numbertoggle

### Refs
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [kickstart nvim modular](https://github.com/dam9000/kickstart-modular.nvim)
- [blog nvim kickstart](https://blog.epheme.re/software/nvim-kickstart.html)
- [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
- [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)
- [lazy.nvim uninstall](https://github.com/folke/lazy.nvim#-uninstalling)
- Can I keep my existing configuration in parallel to kickstart?
  - Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install the kickstart
    configuration in `~/.config/nvim-kickstart` and create an alias:
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    When you run Neovim using `nvim-kickstart` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim
    distribution that you would like to try out.
