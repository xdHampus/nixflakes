{ targets, ... }:

let

    userHome = x: "./../users/${x}/home.nix";

    lib = import <nixpkgs/lib>;
    forEach = lib.lists.forEach;
    zipAttrs = lib.attrsets.zipAttrs;    

    
    userList = forEach targets (x:
        let
        in
        {
            importedUsers.${x} = { ... }: {
              imports = [
                userHome x
              ];
            };
        }
    );
    
    users = zipAttrs (zipAttrs (userList)).importedUsers;


in
users


