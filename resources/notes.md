# Assorted notes

## templates

```console
nix flake init --template github:xdHampus/nixflakes#standard
```

```console
nix flake new --template github:xdHampus/nixflakes#standard ./new-project
```


## clear gpg
```console
pkill -f gpg-agent; pkill -f pinentry \
systemctl --user restart gpg-agent{.socket,-extra.socket,-ssh.socket}
```

## clear boot (sudo)
```console
nix-env -p /nix/var/nix/profiles/system --delete-generations +2
nix-collect-garbage --delete-older-than 5d
```

## fix audio
```console
# Enable Audio codec power management in Tunables
nix-shell -p powertop
sudo powertop
# OR
sudo micro /sys/module/snd_hda_intel/parameters/power_save
sudo micro /sys/module/snd_hda_intel/parameters/power_save_controller

# Then
systemctl --user restart wireplumber pipewire pipewire-pulse && systemctl suspend && systemctl --user restart wireplumber pipewire pipewire-pulse
```

## fix router dns / bridge problems
```console
ip -br a
# delete the bridge with to router IP
```


## openconnect-sso fix
```console
nix run github:ThinkChaos/openconnect-sso/fix/nix-flake 
```
