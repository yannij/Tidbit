rendering
renderLinksOn: html

	self links do: [ :eachLinkGroup | 
		html mdlNavigation: [ 
			eachLinkGroup do: [ :each | | label callback |
				label := each key.
				callback := each value.
				html mdlNavigationLink callback: callback; with: label ] ].
		"html mdlLayoutSpacer" ].
