{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.tools.micro;
in {
  options.modules.tools.micro = {
    enable = mkEnableOption "micro";
  };
  config = mkIf cfg.enable {
    xdg.configFile = {
    	microEditorColorschemes = {
    		source = ./colorschemes/dark.micro;
    		target = "./micro/colorschemes/dark.micro";
    	};
    	microEditorSettings = {
    		source = ./settings.json;
    		target = "./micro/settings.json";
    	};  	
    	microEditorBindings = {
    		source = ./bindings.json;
    		target = "./micro/bindings.json";
    	}; 
    };
    home.activation = {
    	installMicroPlugins = ''
  		  micro -plugin install filemanager
    	'';
    };
  };
}
