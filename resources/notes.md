# Assorted notes

## clear gpg
pkill -f gpg-agent; pkill -f pinentry \
systemctl --user restart gpg-agent{.socket,-extra.socket,-ssh.socket}

## clear boot (sudo)
nix-env -p /nix/var/nix/profiles/system --delete-generations +2
nix-collect-garbage --delete-older-than 5d
