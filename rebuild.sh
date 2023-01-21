#!/bin/sh
flake=""

if [ -n "$1" ]; then
  flake=$1
else
  echo "Flake not selected, assuming current system is target."
  flake=$HOSTNAME
fi

nixos-rebuild switch $2  --flake .#$flake
