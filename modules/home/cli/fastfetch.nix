{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = ./test.txt;
        color = {
          "1" = "#f5c2e7";
        };
        padding = {
          right = 1;
        };
      };

      display = {
        size = {
          binaryPrefix = "si";
        };
        color = "#f5c2e7";
        separator = "  ";
      };
      modules = [
        {
          type = "datetime";
          key = "Date";
          format = "{1}-{3}-{11}";
        }
        {
          type = "datetime";
          key = "Time";
          format = "{14}:{17}:{20}";
        }
        "break"
        "title"
        "os"
        "terminal"
        "cpu"
        "gpu"
        "media"
      ];
    };
  };
}
