{
	wayland.windowManager.hyprland.settings = {
		layer_rule = [
			{
				name = "menu-rule";
				match = { namespace = "menu";};
				no_anim = true;
			}
		];
		window_rule = [
			{
				name = "tlgrm-rule";
				match = { initial_class = "com.ayugram.desktop";};
				workspace = "5";
			}
			{
				name = "browser-rule";
				match = { initial_class = "firefox";};
				workspace = "4";
			}

		];
	};
}
