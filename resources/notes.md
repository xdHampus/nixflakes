# Assorted notes

## clear gpg
- ```pkill -f gpg-agent; pkill -f pinentry```
- ```systemctl --user restart gpg-agent{.socket,-extra.socket,-ssh.socket}```
