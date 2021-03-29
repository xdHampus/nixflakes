{ pkgs, ... }:

{
  programs.fish.enable = true;

  programs.fish.shellAbbrs = {
    "c" = "clear";
    "s" = "lsd";
    "sa" = "lsd -aF";
    "ss" = "lsd -alF";
    "suv" = "sudoedit";
    "cat" = "bat";
    "diff" = "diff-so-fancy";
    "untar" = "tar -xvzf";
    "uefi" = "systemctl reboot --firmware-setup";
    "lg" = "lazygit";
    "sshgit" = "ssh-add ~/.ssh/githubkey";
    "g" = "git";
    "ga" = "git add";
    "gall" = "git add --all";
    "gc" = "git clone";
    "gmc" = "gitmoji -c";
    "gco" = "git commit";
    "gp" = "git push";
    "gb" = "git branch";
    "gd" = "git diff";
    "gdst" = "git diff --staged";
    "gst" = "git status";
    "gch" = "git checkout";
    "gf" = "git fetch";
    "gmv" = "git mv";
    "gl" = "git log --graph --color=always";
    "glo" = "git log --graph --color=always --oneline";
    "scrotclipsel" = "scrot -s ~/tmp.png && xclip -selection clipboard -t image/png -i ~/tmp.png && rm ~/tmp.png";
    "scrotclip" = "scrot ~/tmp.png && xclip -selection clipboard -t image/png -i ~/tmp.png && rm ~/tmp.png";
    "v" = "nvim";
    "emn" = "emacsclient -c -nw";
    "em" = "devour emacsclient -c";
    "mpv" = "devour mpv";
    "sxiv" = "devour sxiv";
    "zathura" = "devour zathura";
    "top" = "btm";
    "vf" = "vifm";
    "ncpa" = "ncpamixer";
    "mpvm" = "mpv --no-video";
    "nixre" = "doas nixos-rebuild switch --flake";
    "nixrt" = "doas nixos-rebuild test --flake";
    "dnixtrash" = "doas nix-collect-garbage -d";
    "nixtrash" = "nix-collect-garbage -d";
    "tty-clock" = "tty-clock -C 1 -c";
    "rickroll" = "curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash";
  };

  programs.fish.plugins =
    [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
          sha256 = "0c5i7sdrsp0q3vbziqzdyqn4fmp235ax4mn4zslrswvn8g3fvdyh";
        };
      }
      {
        name = "fish-ssh-agent";
        src = pkgs.fetchFromGitHub {
          owner = "danhper";
          repo = "fish-ssh-agent";
          rev = "ce90d80aa9549c626f9c5fc5a964536de015a192";
          sha256 = "03zj5g7dxkhqpp9lijxxlnyx4cc7nqpapj5iqfv7swavyximicyi";
        };
      }
    ];

  programs.fish.interactiveShellInit = ''
      fish_vi_key_bindings
      set fish_greeting
      set -U fish_escape_delay_ms 10
      if test "$TERM" != "linux"
          set -U fish_color_autosuggestion 676e95
          set -U fish_color_cancel -r
          set -U fish_color_command green #white
          set -U fish_color_comment 32374D
          set -U fish_color_cwd green
          set -U fish_color_cwd_root red
          set -U fish_color_end brblack #blue
          set -U fish_color_error red
          set -U fish_color_escape yellow #green
          set -U fish_color_history_current --bold
          set -U fish_color_host normal
          set -U fish_color_match --background=brblue
          set -U fish_color_normal normal
          set -U fish_color_operator blue #green
          set -U fish_color_param 8796B0
          set -U fish_color_quote yellow #brblack
          set -U fish_color_redirection cyan
          set -U fish_color_search_match bryellow --background=32374D
          set -U fish_color_selection white --bold --background=32374D
          set -U fish_color_status red
          set -U fish_color_user brgreen
          set -U fish_color_valid_path --underline
          set -U fish_pager_color_completion normal
          set -U fish_pager_color_description yellow --dim
          set -U fish_pager_color_prefix white --bold #--underline
          set -U fish_pager_color_progress brwhite --background=cyan
      end
      # Open lazygit commit window inside neovim
      if [ -n "$NVIM_LISTEN_ADDRESS" ];
          alias nvim="nvr -cc split --remote-wait +'set bufhidden=wipe'"
      end
      
      if [ -n "$NVIM_LISTEN_ADDRESS" ];
          export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
          export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
      else
          export VISUAL="nvim"
          export EDITOR="nvim"
      end
      eval (direnv hook fish)
      # Some of the most useful features in emacs-libvterm require shell-side
      # configurations. The main goal of these additional functions is to enable the
      # shell to send information to `vterm` via properly escaped sequences. A
      # function that helps in this task, `vterm_printf`, is defined below.
      
      function vterm_printf;
          if [ -n "$TMUX" ]
              # tell tmux to pass the escape sequences through
              # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
              printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
          else if string match -q -- "screen*" "$TERM"
              # GNU screen (screen, screen-256color, screen-256color-bce)
              printf "\eP\e]%s\007\e\\" "$argv"
          else
              printf "\e]%s\e\\" "$argv"
          end
      end
      
      # Completely clear the buffer. With this, everything that is not on screen
      # is erased.
      if [ "$INSIDE_EMACS" = 'vterm' ]
          function clear
              vterm_printf "51;Evterm-clear-scrollback";
              tput clear;
          end
      end
      
      # This is to change the title of the buffer based on information provided by the
      # shell. See, http://tldp.org/HOWTO/Xterm-Title-4.html, for the meaning of the
      # various symbols.
      function fish_title
          hostname
          echo ":"
          pwd
      end
      # vifm image preview
      alias vifm="bash -c 'vifmrun'"

    '';
}
