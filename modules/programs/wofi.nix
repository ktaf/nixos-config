#
#  System Menu
#

{ config, lib, pkgs, vars, ... }:

{
  config = lib.mkIf (config.wlwm.enable) {
    home-manager.users.${vars.user} = {
      home = {
        packages = with pkgs; [
          wofi
        ];
      };

      home.file = {
        ".config/wofi/config" = {
          text = ''
            width=100%
            lines=1
            xoffset=0
            yoffset=-28
            location=1
            prompt=Search...
            filter_rate=100
            allow_markup=false
            no_actions=true
            halign=fill
            orientation=horizontal
            content_halign=fill
            insensitive=true
            allow_images=true
            image_size=15
            hide_scroll=true
          '';
        };
        ".config/wofi/style.css" = {
          text = ''
            window {
              margin: 0px;
              background-color: #111111;
              min-height: 27px;
            }

            #input {
              all: unset;
              border: none;
              color: #999999;
              background-color: #111111;
              padding-left: 5px;
            }

            #outer-box {
              margin: 0px;
              border: none;
              border-bottom: 1px solid #005577;
            }

            #text:selected {
              color: rgba(255, 255, 255, 0.8);
            }

            #entry {
              color: #999999;
              padding-right: 10px;
            }

            #entry:selected {
              all: unset;
              border-radius: 0px;
              background-color: #005577;
              padding-right: 10px;
            }

            #img {
              padding-right: 5px;
              padding-left: 10px;
            }
          '';
        };
        ".config/wofi/power.sh" = {
          executable = true;
          text = ''
            #!/bin/sh

            entries="󰍃 Logout\n󰒲 Suspend\n Reboot\n⏻ Shutdown"

            selected=$(echo -e $entries|wofi --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

            case $selected in
              logout)
                exec hyprctl dispatch exit;;
              suspend)
                exec systemctl suspend;;
              reboot)
                exec systemctl reboot;;
              shutdown)
                exec systemctl poweroff -i;;
            esac
          '';
        };
      };
    };
  };
}
