rendering
renderNavigationOn: html

	html mdlNavigation: [ 
		self actions do: [ :each |
			html mdlNavigationLink
				onClick: ((html jQuery ajax)
						callback: each value;
						onComplete: html javascript refresh;
						yourself);
					yourself;
				with: each key ] ]
