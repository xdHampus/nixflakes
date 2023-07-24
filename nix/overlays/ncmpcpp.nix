#{ config, lib, pkgs, stdenv, ... }:
self: super:
{
  ncmpcpp = super.ncmpcpp.override { 
  	visualizerSupport = true;
  	taglibSupport = true;
  }; 
}
