rendering
updateRoot: anHtmlRoot

	super updateRoot: anHtmlRoot.
	anHtmlRoot title: self browserTabTitle.
