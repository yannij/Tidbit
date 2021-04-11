Class {
	#name : #TBContentGrid,
	#superclass : #MCWWebComponent,
	#instVars : [
		'contents',
		'view'
	],
	#category : #'Tidbit-MaterialComponentsWeb'
}

{ #category : #accessing }
TBContentGrid >> content1: aComponent [

	self contents at: 1 put: aComponent
]

{ #category : #accessing }
TBContentGrid >> content2: aComponent [

	self contents at: 2 put: aComponent
]

{ #category : #accessing }
TBContentGrid >> contents [
	^ contents
]

{ #category : #accessing }
TBContentGrid >> contents: anObject [
	contents := anObject
]

{ #category : #initialization }
TBContentGrid >> initialize [

	super initialize.

	self contents: (OrderedCollection with: nil with: nil)
]

{ #category : #rendering }
TBContentGrid >> renderContentOn: html [

	self view notNil
		ifTrue: [^self renderViewOn: html].

	html div mdcLayoutGrid;
		style: '--mdc-layout-grid-margin-desktop: 16px';
		style: '--mdc-layout-grid-gutter-desktop: 16px';
		with: [
		html div mdcLayoutGrid__inner; with: [
			self contents do: [:each |
				html div mdcLayoutGrid__cell_span6; with: [
					html render: each]]]]

]

{ #category : #rendering }
TBContentGrid >> renderViewOn: html [ 

	html div mdcLayoutGrid;
		style: '--mdc-layout-grid-margin-desktop: 16px';
		style: '--mdc-layout-grid-gutter-desktop: 16px';
		with: [
		html div mdcLayoutGrid__inner; with: [
			html div mdcLayoutGrid__cell_span: self view layoutCellSpan; with: [
				html render: self view]]]

]

{ #category : #accessing }
TBContentGrid >> view [
	^ view
]

{ #category : #accessing }
TBContentGrid >> view: anObject [
	view := anObject
]
