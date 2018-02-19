accessing
viewStyle

	viewStyle isNil ifTrue: [ self viewStyle: self class defaultViewStyle ].

	^ viewStyle