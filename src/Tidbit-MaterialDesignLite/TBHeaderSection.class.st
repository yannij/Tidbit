Class {
	#name : #TBHeaderSection,
	#superclass : #MDLAbstractHeaderSection,
	#category : 'Tidbit-MaterialDesignLite'
}

{ #category : #rendering }
TBHeaderSection >> renderActionButtonssOn: html [

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

]

{ #category : #rendering }
TBHeaderSection >> renderContentOn: html [

	(html brush: brush)
		waterfall;
		with: [ 
			html mdlLayoutHeaderRow: [
				html mdlLayoutTitle: self session presenter headerTitle.
				html mdlLayoutSpacer.
				self renderToolNavOn: html.
				self renderActionButtonssOn: html.
				self renderSecondaryActionMenuOn: html
			].
		]
	"self renderTabBarOn: html"

]

{ #category : #rendering }
TBHeaderSection >> renderSecondaryActionMenuOn: html [

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
]

{ #category : #rendering }
TBHeaderSection >> renderToolNavOn: html [

	html mdlDiv
		class: 'mdl-layout--large-screen-only';
		with: [ html render: (TBToolNav new) ].

]
