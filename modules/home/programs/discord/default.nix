{
  config,
  inputs,
  ...
}: let
  theme = config.theme.active;
  quickCss = ''
    :root {
      --brand-500: ${theme.colors.primary};
      --brand-560: ${theme.colors.secondary};
    }

    .visual-refresh {
      --background-base-lower: ${theme.colors.background};
      --background-base-low: ${theme.colors.surface};
      --background-base-primary: ${theme.colors.background};
      --background-base-secondary: ${theme.colors.surface};
      --background-secondary-alt: ${theme.colors.surfaceVariant};
      --background-floating: ${theme.colors.surface};
      --background-mentioned: ${theme.colors.surfaceVariant};
      --channeltextarea-background: ${theme.colors.surfaceVariant};
      --text-normal: ${theme.colors.text};
      --text-muted: ${theme.colors.textMuted};
      --interactive-normal: ${theme.colors.textMuted};
      --interactive-hover: ${theme.colors.primary};
      --interactive-active: ${theme.colors.text};
      --button-danger-background: ${theme.colors.error};
      --button-positive-background: ${theme.colors.accent};
      --radius-sm: ${toString theme.ui.rounding}px;
      --radius-md: ${toString theme.ui.rounding}px;
      --radius-lg: ${toString theme.ui.rounding}px;
    }
  '';
in {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    inherit quickCss;
    config.useQuickCss = quickCss != "";
    vesktop.enable = true;
  };
}
