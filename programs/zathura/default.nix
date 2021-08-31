{ fontSize, pkgs, ... }:

{
  programs.zathura = {
    enable = true;
    #settings = {
      #background_opacity = 0.85;
      #color-link default "[fg color],[bg color]",
    #};
    extraConfig = ''
    	set recolor   
    	set recolor-lightcolor \#222222
   		set recolor-keephue
    	set default-bg \#222230
    	
		
		
    '';

        #set recolor   
    	#set recolor-lightcolor rgba(0,0,0,0)
   		#set recolor-keephue
    	#set default-bg rgba(0,0,0,0.7)


    
  };
}
