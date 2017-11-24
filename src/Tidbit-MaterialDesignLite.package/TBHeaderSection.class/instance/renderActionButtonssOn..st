rendering
renderActionButtonssOn: html

	"self renderSearchOn: html."

	html mdlButton icon;
		onClick: ((html jQuery ajax)
			callback: [ "self session presenter switchToRecent" ];
			onComplete: html javascript refresh);
		with: [ html mdlIcon: 'search' ].

	html mdlButton icon;
		onClick: ((html jQuery ajax)
			callback: [ self session presenter favCurrentObject ];
			onComplete: html javascript refresh);
		with: [ html mdlIcon: 'favorite' ].
