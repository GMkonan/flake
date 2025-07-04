{
  programs.walker = {
    enable = true;
    runAsService = true;

    # All options from the config.json can be used here.
    config = {
      search.placeholder = "Example 2";
      ui.fullscreen = true;
      list = {
        height = 200;
      };
      websearch.prefix = "?";
      switcher.prefix = "/";
    };

    theme = {
      # The 'layout' attribute will be written to ~/.config/walker/themes/nixos.toml
      # Refer to Walker's Theming Wiki for all available layout options:
      # https://github.com/abenz1267/walker/wiki/Theming
      layout = {
        # General styling
        width = 600;
        height = 400;
        spacing = 10;
        padding = 10;
        # For example, if you want a top bar for categories or filtering
        # The structure here needs to match Walker's TOML theme layout
        # This is just an example, actual keys depend on Walker's implementation
        components = {
          entry = {
            # Maybe define how entry rows look
            iconSize = 32;
            fontSize = 1.2;
          };
          window = {
            # Window properties
            borderRadius = 8;
          };
          searchEntry = {
            # Search input properties
            padding = 8;
            placeholderText = "Search applications...";
          };
        };
        # You'll need to consult Walker's theming documentation for the exact TOML structure.
        # This is just a hypothetical example based on common launcher themes.
        # Here are some common layout properties you might find:
        # resultBox = { maxItems = 10; };
        # hotKeys = {
        #   next = "Down";
        #   prev = "Up";
        #   select = "Return";
        # };
      };

      # The 'style' attribute will be written to ~/.config/walker/themes/nixos.css
      # This is standard GTK CSS.
      style = ''
        /* Catppuccin Mocha Palette */
        @define-color base   #1e1e2e;
        @define-color mantle #181825;
        @define-color crust  #11111b;
        @define-color text   #cdd6f4;
        @define-color subtext0 #a6adc8;
        @define-color surface0 #313244;
        @define-color surface1 #45475a;
        @define-color surface2 #585b70;
        @define-color overlay0 #6c7086;
        @define-color overlay1 #7f849c;
        @define-color overlay2 #9399b2;
        @define-color rosewater #f5e0dc;
        @define-color flamingo #f2cdcd;
        @define-color pink   #f5c2e7;
        @define-color mauve  #cba6f7;
        @define-color red    #f38ba8;
        @define-color maroon #eba0ac;
        @define-color peach  #fab387;
        @define-color yellow #f9e2af;
        @define-color green  #a6e3a1;
        @define-color teal   #94e2d5;
        @define-color sky    #89dceb;
        @define-color sapphire #74c7ec;
        @define-color blue   #89b4fa;
        @define-color lavender #b4befe;

        /* General window styling */
        .window {
          background-color: @base; /* Base background */
          border: 2px solid @mauve; /* Mauve border for accent */
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3); /* Subtle shadow */
        }

        /* Search entry styling */
        .search-entry {
          background-color: @mantle; /* Slightly darker than base for contrast */
          color: @text; /* Main text color */
          border: 1px solid @surface1; /* Subtle border */
        }

        .search-entry:focus {
          border-color: @blue; /* Blue accent when focused */
        }

        /* Result list items */
        /* .result-item {
        } */

        .result-item:hover {
          background-color: @surface0; /* Light background on hover */
        }

        /* Selected result item */
        .result-item:selected {
          background-color: @lavender; /* Lavender for selected item */
          color: @base; /* Text color should contrast with lavender, so base */
        }

        /* Application name */
        .app-name {
          color: @text; /* Main text color for app names */
        }

        /* Application description/comment */
        .app-comment {
          color: @subtext0; /* Softer text for descriptions */
        }

        /* Icon styling (if applicable) */
        /* .app-icon {
        } */

      '';
    };
  };
}
