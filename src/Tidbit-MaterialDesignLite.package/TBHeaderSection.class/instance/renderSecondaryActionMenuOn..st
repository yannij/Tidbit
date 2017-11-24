rendering
renderSecondaryActionMenuOn: html

	"html div class: 'menu-bar mdl-color--primary mdl-color-text--primary-contrast'; style: 'text-align: left;'; with: [ "
		html mdlButton icon
			id: #appbarMenu;
			with: [ html mdlIcon: #more_vert ].
		html mdlMenu
			bottomLeft;
			for: #appbarMenu;
			with: [
				html mdlMenuItem
					"onClick: ((html jQuery ajax)
						callback: [];
						onComplete: html javascript refresh);"
					with: 'Action 1'.
				html mdlMenuItem
					"onClick: ((html jQuery ajax)
						callback: [];
						onComplete: html javascript refresh);"
					with: 'Action 2'.
			]
		"]"