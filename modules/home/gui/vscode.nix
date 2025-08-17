{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.vscode = {
    enable = true;
    # Unfortunately can't use vscodium because its not compatible with devcontainers
    # which is the only reason I use vscode
    package = pkgs.vscode;

    mutableExtensionsDir = false;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # AI tools
        continue.continue

        # Themes
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons

        # Dev tools
        ms-vscode-remote.remote-containers
        bradlc.vscode-tailwindcss
        biomejs.biome
        yoavbls.pretty-ts-errors
        eamodio.gitlens

        # Vim keybindings
        vscodevim.vim
      ];

      userSettings = {
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";
        "window.titleBarStyle" = "custom";
        "workbench.sideBar.location" = "right";
        "workbench.startupEditor" = "none";
        "breadcrumbs.enabled" = false;

        # Force our font setting to override defaults
        "editor.fontFamily" = lib.mkForce "JetBrainsMono Nerd Font Mono";

        "editor.fontSize" = lib.mkForce 13;
        "editor.fontLigatures" = true;
        "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font Mono";
        "terminal.integrated.fontLigatures.enabled" = true;
        "editor.formatOnSave" = true;
        "editor.linkedEditing" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.smoothScrolling" = true;
        "editor.cursorBlinking" = "smooth";
        "editor.minimap.enabled" = false;
        "editor.renderWhitespace" = "boundary";
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "editor.lineNumbers" = "relative";

        "[typescriptreact]" = {"editor.defaultFormatter" = "biomejs.biome";};
        "[typescript]" = {"editor.defaultFormatter" = "biomejs.biome";};
        "[jsonc]" = {"editor.defaultFormatter" = "biomejs.biome";};
        "[python]" = {"editor.formatOnType" = true;};

        "explorer.compactFolders" = false;
        "files.exclude" = {
          "**/.trunk/*actions/" = true;
          "**/.trunk/*logs/" = true;
          "**/.trunk/*notifications/" = true;
          "**/.trunk/*out/" = true;
          "**/.trunk/*plugins/" = true;
        };
        "files.watcherExclude" = {
          "**/.trunk/*actions/" = true;
          "**/.trunk/*logs/" = true;
          "**/.trunk/*notifications/" = true;
          "**/.trunk/*out/" = true;
          "**/.trunk/*plugins/" = true;
        };
        "workbench.editor.customLabels.patterns" = {
          "**/dashboard/src/pages/**/index.tsx" = "\${filename}.\${extname} - \${dirname}";
          "**/dashboard/src/app/**/page.tsx" = "\${filename}.\${extname} - \${dirname}";
        };
        # "terminal.integrated.env.linux" = {
        #   "GITHUB_TOKEN" = "";
        # };
        "dev.containers.defaultExtensions" = [
          "eamodio.gitlens"
          "bradlc.vscode-tailwindcss"
        ];
        "extensions.ignoreRecommendations" = true;
        "css.lint.unknownAtRules" = "ignore";
        "settingsSync.ignoredSettings" = [
          "-dotfiles.installCommand"
          "-dotfiles.repository"
        ];

        # Vim settings
        "vim.highlightedyank.enable" = true;
        "vim.useSystemClipboard" = true;
        "telemetry.telemetryLevel" = "off";
        "vim.useCtrlKeys" = true;
        "vim.hlsearch" = true;
        "vim.easymotion" = true;
        "vim.incsearch" = true;
        "vim.leader" = "<space>";
        "vim.insertModeKeyBindings" = [
          {
            "before" = ["j" "k"];
            "after" = ["<Esc>"];
          }
        ];
        "vim.normalModeKeyBindings" = [
          {
            "before" = ["<leader>" "s" "a"];
            "commands" = ["editor.action.selectAll"];
          }
          {
            "before" = ["<leader>" "w"];
            "commands" = ["workbench.action.files.save"];
          }
          {
            "before" = ["<leader>" "e"];
            "commands" = ["workbench.action.toggleSidebarVisibility"];
          }
          {
            "before" = ["<leader>" "q"];
            "commands" = ["workbench.action.closeActiveEditor"];
          }
          {
            "before" = ["<leader>" "h"];
            "commands" = [":nohl"];
          }
          {
            "before" = ["<leader>" "s" "v"];
            "commands" = ["workbench.action.splitEditor"];
          }
          {
            "before" = ["<leader>" "s" "h"];
            "commands" = ["workbench.action.splitEditorDown"];
          }
          {
            "before" = ["<leader>" "t" "o"];
            "commands" = [":tabnew"];
          }
          {
            "before" = ["<leader>" "t" "x"];
            "commands" = [":tabclose"];
          }
          {
            "before" = ["<S-h>"];
            "commands" = [":tabp"];
          }
          {
            "before" = ["<S-l>"];
            "commands" = [":tabnext"];
          }
          {
            "before" = ["<leader>" "f" "f"];
            "commands" = ["workbench.action.quickOpen"];
          }
          {
            "before" = ["<leader>" "<leader>"];
            "commands" = ["workbench.action.showAllEditors"];
          }
          {
            "before" = ["<leader>" "f" "s"];
            "commands" = ["workbench.action.findInFiles"];
          }
          {
            "before" = ["<leader>" "r" "n"];
            "commands" = ["editor.action.rename"];
          }
          {
            "before" = ["<leader>" "a" "f"];
            "commands" = ["editor.action.autoFix"];
          }
          {
            "before" = ["<leader>" "r" "a"];
            "commands" = ["editor.action.rename"];
          }
          {
            "before" = ["<leader>" "f" "m"];
            "commands" = ["editor.action.format"];
          }
          {
            "before" = ["<leader>" "c" "a"];
            "commands" = ["editor.action.quickFix"];
          }
          {
            "before" = ["<S-k>"];
            "commands" = ["editor.action.showHover"];
          }
        ];
        "vim.visualModeKeyBindings" = [
          {
            "before" = [">"];
            "commands" = ["editor.action.indentLines"];
          }
          {
            "before" = ["<"];
            "commands" = ["editor.action.outdentLines"];
          }
          {
            "before" = ["<S-j>"];
            "commands" = ["editor.action.moveLinesDownAction"];
          }
          {
            "before" = ["<S-k>"];
            "commands" = ["editor.action.moveLinesUpAction"];
          }
        ];
      };

      keybindings = [
        {
          "key" = "ctrl+alt+j";
          "command" = "editor.action.copyLinesDownAction";
          "when" = "editorTextFocus && !editorReadonly";
        }
        {
          "key" = "ctrl+shift+alt+down";
          "command" = "-editor.action.copyLinesDownAction";
          "when" = "editorTextFocus && !editorReadonly";
        }
        {
          "key" = "ctrl+alt+k";
          "command" = "editor.action.copyLinesUpAction";
          "when" = "editorTextFocus && !editorReadonly";
        }
        {
          "key" = "ctrl+shift+alt+up";
          "command" = "-editor.action.copyLinesUpAction";
          "when" = "editorTextFocus && !editorReadonly";
        }
        {
          "key" = "ctrl+f f";
          "command" = "prettier.forceFormatDocument";
        }
        {
          "key" = "ctrl+f r";
          "command" = "editor.action.startFindReplaceAction";
          "when" = "editorFocus || editorIsOpen";
        }
        {
          "key" = "ctrl+h";
          "command" = "-editor.action.startFindReplaceAction";
          "when" = "editorFocus || editorIsOpen";
        }
        {
          "key" = "ctrl+alt+e";
          "command" = "workbench.view.explorer";
          "when" = "viewContainer.workbench.view.explorer.enabled";
        }
        {
          "key" = "ctrl+shift+e";
          "command" = "-workbench.view.explorer";
          "when" = "viewContainer.workbench.view.explorer.enabled";
        }
        {
          "key" = "ctrl+k ctrl+o";
          "command" = "-workbench.action.files.openFolder";
          "when" = "openFolderWorkspaceSupport";
        }
        {
          "key" = "ctrl+s p";
          "command" = "workbench.action.showCommands";
        }
        {
          "key" = "ctrl+shift+p";
          "command" = "-workbench.action.showCommands";
        }
        {
          "key" = "ctrl+s k";
          "command" = "workbench.action.openGlobalKeybindings";
        }
        {
          "key" = "ctrl+k ctrl+s";
          "command" = "-workbench.action.openGlobalKeybindings";
        }
        {
          "key" = "a";
          "command" = "explorer.newFile";
          "when" = "filesExplorerFocus && !inputFocus";
        }
        {
          "key" = "f";
          "command" = "explorer.newFolder";
          "when" = "filesExplorerFocus && !inputFocus";
        }
        {
          "key" = "d";
          "command" = "deleteFile";
          "when" = "filesExplorerFocus && !inputFocus";
        }
        {
          "key" = "y";
          "command" = "filesExplorer.copy";
          "when" = "filesExplorerFocus && !inputFocus";
        }
        {
          "key" = "p";
          "command" = "filesExplorer.paste";
          "when" = "filesExplorerFocus && !inputFocus";
        }
        {
          "key" = "x";
          "command" = "filesExplorer.cut";
          "when" = "filesExplorerFocus && !inputFocus";
        }
        {
          "key" = "r";
          "command" = "renameFile";
          "when" = "filesExplorerFocus && !inputFocus";
        }
        {
          "key" = "ctrl+h";
          "command" = "workbench.action.focusActiveEditorGroup";
          "when" = "workbench.explorer.openEditorsView.active || filesExplorerFocus && vim.active && vim.mode!='Insert'";
        }
        {
          "key" = "ctrl+k";
          "command" = "workbench.action.navigateUp";
          "when" = "vim.active && vim.mode!='Insert'";
        }
        {
          "key" = "ctrl+k";
          "command" = "workbench.files.action.focusOpenEditorsView";
          "when" = "filesExplorerFocus && vim.active && vim.mode!='Insert'";
        }
        {
          "key" = "ctrl+l";
          "command" = "workbench.action.navigateRight";
          "when" = "vim.active && vim.mode!='Insert'";
        }
        {
          "key" = "ctrl+j";
          "command" = "workbench.action.navigateDown";
          "when" = "vim.active && vim.mode!='Insert'";
        }
        {
          "key" = "ctrl+j";
          "command" = "workbench.files.action.focusFilesExplorer";
          "when" = "!editorFocus && workbench.explorer.openEditorsView.active && vim.active && vim.mode!='Insert'";
        }
        {
          "key" = "ctrl+h";
          "command" = "workbench.action.navigateLeft";
          "when" = "vim.active && vim.mode!='Insert'";
        }
        {
          "key" = "ctrl+c";
          "command" = "vim.remap";
          "when" = "inputFocus && vim.mode == 'Normal'";
          "args" = {"after" = ["y" "y"];};
        }
        {
          "key" = "ctrl+v";
          "command" = "-editor.action.clipboardPasteAction";
        }
        {
          "key" = "ctrl+s h";
          "command" = "editor.action.showHover";
          "when" = "editorTextFocus";
        }
        {
          "key" = "ctrl+k ctrl+i";
          "command" = "-editor.action.showHover";
          "when" = "editorTextFocus";
        }
        {
          "key" = "space o";
          "command" = "filesExplorer.openFilePreserveFocus";
          "when" = "filesExplorerFocus && foldersViewVisible && !explorerResourceIsFolder && !inputFocus";
        }
        # {
        #   "key" = "g c c";
        #   "command" = "editor.action.commentLine";
        #   "when" = "editor.TextFocus && !editorReadonly";
        # }
        # {
        #   "key" = "g d";
        #   "command" = "editor.action.revealDefinition";
        #   "when" = "vim.mode == 'Normal' && editorHasDefinitionProvider && editorTextFocus && !isEmbeddedEditor";
        # }
        {
          "key" = "ctrl+shift+p";
          "command" = "workbench.action.quickOpen";
          "when" = "filesExplorerFocus || editorFocus";
        }
        {
          "key" = "] d";
          "command" = "editor.action.marker.next";
          "when" = "editorFocus && vim.mode == 'Normal'";
        }
        {
          "key" = "alt+f8";
          "command" = "-editor.action.marker.next";
          "when" = "editorFocus";
        }
        {
          "key" = "[ d";
          "command" = "editor.action.marker.prev";
          "when" = "editorFocus && vim.mode == 'Normal'";
        }
        {
          "key" = "ctrl+alt+s";
          "command" = "workbench.files.action.focusFilesExplorer";
        }
      ];
    };
  };
}
