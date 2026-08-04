{
	wayland.windowManager.hyprland.settings = {
		config.animations.enabled = true;
		curve = [
			{_args = [ "easeOutQuint"   { type = "bezier"; points = [[ 0.23 1    ] [ 0.32 1]]; }];}
			{_args = [ "easeInOutCubic" { type = "bezier"; points = [[ 0.65 0.05 ] [ 0.36 1]]; }];}
			{_args = [ "linear" 	    { type = "bezier"; points = [[ 0    0    ] [ 1    1]]; }];}
			{_args = [ "almostLinear"	{ type = "bezier"; points = [[ 0.5  0.5  ] [ 0.75 1]]; }];}
			{_args = [ "quick" 		    { type = "bezier"; points = [[ 0.15 0    ] [ 0.1  1]]; }];}
			{_args = [ "easy" 		 	{ type = "spring"; mass = 1; stiffness = 71; dampening = 15;} ];}
		];

		animation = [
			{ enabled = true; leaf = "global"; speed = 10; bezier = "default"; }
			
			{ enabled = true; leaf = "workspaces"   ; speed = 1.94; bezier = "easeInOutCubic"; style = "slidefadevert"; }
			{ enabled = true; leaf = "workspacesIn" ; speed = 1.21; bezier = "easeInOutCubic"; style = "slidefadevert"; }
			{ enabled = true; leaf = "workspacesOut"; speed = 1.94; bezier = "easeInOutCubic"; style = "slidefadevert"; }
			{ enabled = true; leaf = "border" 		; speed = 5.39; bezier = "easeOutQuint"	 ; }
			{ enabled = true; leaf = "windows"		; speed = 4.79; spring = "easy" 		 ; }
			{ enabled = true; leaf = "windowsIn"	; speed = 4.1 ; spring = "easy"		 	 ; style = "popin 87%"; }
			{ enabled = true; leaf = "windowsOut"	; speed = 1.49; bezier = "linear"	  	 ; style = "popin 87%"; }
			{ enabled = true; leaf = "fadeIn"		; speed = 1.73; bezier = "almostLinear"	 ; }
			{ enabled = true; leaf = "fadeOut"		; speed = 1.46; bezier = "almostLinear"	 ; }
			{ enabled = true; leaf = "fade"			; speed = 3.03; bezier = "quick"		 ; }
			{ enabled = true; leaf = "layers"		; speed = 3.81; bezier = "easeOutQuint"	 ; }
			{ enabled = true; leaf = "layersIn"		; speed = 4   ; bezier = "easeOutQuint"	 ; style = "fade"; }
			{ enabled = true; leaf = "layersOut"	; speed = 1.5 ; bezier = "linear"		 ; style = "fade"; }
			{ enabled = true; leaf = "fadeLayersIn"	; speed = 1.79; bezier = "almostLinear"  ; }
			{ enabled = true; leaf = "fadeLayersOut"; speed = 1.39; bezier = "almostLinear"  ; }
			{ enabled = true; leaf = "zoomFactor"	; speed = 7   ; bezier = "quick"		 ; }
		];
	};
}
