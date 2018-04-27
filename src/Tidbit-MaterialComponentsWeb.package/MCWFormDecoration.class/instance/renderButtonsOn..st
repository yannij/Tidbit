rendering
renderButtonsOn: html

	html div mdcLayoutGrid; mdcLayoutGrid__alignLeft; with: [
		html div mdcLayoutGrid__inner; with: [
			html div mdcLayoutGrid__cell; mdcLayoutGrid__cell__span4; with: [
				self buttons do: [ :each | | iconName |
					iconName := each key.
					iconName = 'save' ifTrue: [iconName := 'done'].
					html button mdcButton; mdcButton__raised;
						callback: [ self execute: each key ];
						with: [
							html span mdcMaterialIcons; mdcButton__icon; with: iconName.
							html text: each value]]
					separatedBy: [html space; space]]]].

				"self buttons do: [ :each |
					html mdlButton
						raised; colored;
						accessKey: each value first;
						callback: [ self execute: each key ];
						text: each value ]
					separatedBy: [ html space ]"