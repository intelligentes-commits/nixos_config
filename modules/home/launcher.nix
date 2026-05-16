{ ... }:

let
  theme = import ./theme.nix;
  c = theme.colors;
in

{
  xdg.configFile."tofi/config".text = ''
    width = 100%
    height = 100%
    anchor = center
    exclusive-zone = -1

    font = JetBrainsMono Nerd Font
    font-size = 18
    prompt-text = "apps: "
    placeholder-text = "Type to search"
    text-cursor = true
    fuzzy-match = true
    history = true
    terminal = kitty

    background-color = ${c.bgAlpha}
    text-color = ${c.text}
    prompt-color = ${c.accent}
    input-color = ${c.text}
    placeholder-color = ${c.muted}
    default-result-color = ${c.text}
    alternate-result-color = ${c.accentDark}
    selection-color = ${c.panel}
    selection-background = ${c.accent}
    selection-match-color = ${c.panel}

    outline-width = 0
    border-width = 0
    corner-radius = 0
    padding-top = 18%
    padding-bottom = 12%
    padding-left = 18%
    padding-right = 18%
    result-spacing = 8
    num-results = 12
    selection-background-padding = 8, 12
    selection-background-corner-radius = 7
  '';
}
