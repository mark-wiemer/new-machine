# Linux Mint setup

I'm trying out Linux Mint as an alternative to Windows and NixOS because I'm new at this and willing to sacrifice customizability for convenience.

## Glossary

Windows | Linux Mint
--|--
taskbar | panel
Start Menu | home menu
Windows key, abbr. `Win` | Super key, abbr. `<Super>`
Shortcut | `.desktop` file


## Clipboard history: Diodon

1. Install from Software Manager
1. Set custom keyboard shortcut to `/usr/bin/diodon`

(Parcellite is not used because it just doesn't paste into this file in GitHub + Firefox, for instance)


## Firefox

1. Vertical tabs: `about:config` > `sidebar.verticalTabs` > `true`
2. Change default search engine
3. Firefox is probably up-to-date, but can only be updated via [Update Manager](https://forums.linuxmint.com/viewtopic.php?t=412975)
   > View current version at Menu > Help > About Firefox


## Cinnamenu

1. Install from Applets
2. Set to search with Bing
3. Disable sidebar
4. Right click panel > Panel settings > Panel edit mode > Drag Cinnamenu to the left, replacing Menu


## Flameshot (for screenshots, like Snipaste)

1. Install from Software Manager
2. Setup a keyboard shortcut that activates `flameshot gui` on `F7`
3. Use Ctrl+C to copy Flameshot selections :)

## FSearch (for file search, like Everything)

1. Install from Software Manager
2. To set it to scan everything, select Other Locations > This Computer

## Godot

1. Install from [godotengine.org](https://godotengine.org) (Software Manager only has v3)
2. Extract
3. Double click within Files app to run as a sanity check
4. Create `.desktop` file for it
   ```desktop
   [Desktop Entry]
   Encoding=UTF-8
   Version=1.0
   Type=Application
   Terminal=false
   Exec=/home/markw/myStuff/apps/Godot_v4.3-stable_linux.x86_64
   Name=Godot 4.3
   Icon=/home/markw/myStuff/apps/godot.svg
   ```
   > SVG from https://godotengine.org/assets/press/icon_color.svg, works fine without it, just nice QoL
6. Run from typing "Godot" in home menu as a sanity check
