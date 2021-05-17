{ pkgs, config, lib, ...}:

let
in
{

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
  
}
