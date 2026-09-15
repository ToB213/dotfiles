{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    casks = [
      "battery"
      "bitwarden"
      "discord"
      "docker"
      "font-fira-code-nerd-font"
      "font-hack-nerd-font"
      "font-meslo-lg-nerd-font"
      "rectangle"
      "slack"
      "tad"
      "zed"
      "super-productivity"
      "softmaker-freeoffice"
      "firefox"
    ];
  };
}
