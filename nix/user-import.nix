{ users, pkgs, ... }:

with pkgs.lib;

let
   

    forEach = pkgs.lib.lists.forEach;
    mergeAttrs = pkgs.lib.trivial.mergeAttrs;	

   toPath = s: ./. + s;

   userHome = x: toPath ("/../users/${x}/home.nix");	
   
   userAttrs =  (forEach users (x:
        let
        in
        {   
            ${x} = { ... }: {
	              imports = [
                   (userHome x)
              ];
            };
        }
    ));
    
   

recursiveMerge = attrList:
  let f = attrPath:
    zipAttrsWith (n: values:
      if tail values == []
        then head values
      else if all isList values
        then unique (concatLists values)
      else if all isAttrs values
        then f (attrPath ++ [n]) values
      else last values
    );
  in f [] attrList;


in
recursiveMerge userAttrs
