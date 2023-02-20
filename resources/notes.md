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
