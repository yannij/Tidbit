Class {
	#name : #TidbitViewTools,
	#superclass : #MCWWebComponent,
	#category : #'Tidbit-MaterialComponentsWeb'
}

{ #category : #rendering }
TidbitViewTools >> renderButton: aButtonText caption: aCaptionText callback: aBlock on: html [

	html anchor mdcButton; mdcButton_raised; mdcAutoInit: 'MDCRipple';
		callback: aBlock;
		with: aButtonText.
	html space; space.
	html span mdcTypography_caption; with: aCaptionText
]

{ #category : #rendering }
TidbitViewTools >> renderContentOn: html [

	html div with: [
		html heading level3; mdcTypography_subtitle1; with: 'Tools'.
		self
			renderButton: 'Reset connection'
			caption: 'Clear the repository connection which is cached in a class variable'
			callback: [ self mcwApplicationGet repositoryClear ]
			on: html.
		html break; break.
		self
			renderButton: 'Reset database'
			caption: 'Delete current database content, and recreate original demo content. Will logout'
			callback: [ self mcwApplicationGet repositoryReset; logout ]
			on: html.
		 ].

]
