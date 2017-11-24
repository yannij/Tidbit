rendering
renderContentOn: html

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
