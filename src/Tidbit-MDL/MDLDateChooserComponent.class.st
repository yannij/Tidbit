Class {
	#name : #MDLDateChooserComponent,
	#superclass : #MADateInputComponent,
	#category : 'Tidbit-MDL'
}

{ #category : #rendering }
MDLDateChooserComponent >> choose [
	| calendar |
	calendar := MDLCalendarWidget new.
	calendar
		"currentDate: ((self value notNil
			and: [ self magritteDescription isSatisfiedBy: self value ])
				ifFalse: [ Date current ]
				ifTrue: [ self value ]);"
		"selectBlock: [ :value | calendar answer: value ];"
		"canSelectBlock: [ :value | self magritteDescription isSatisfiedBy: value ];"
		callback: [ :value | self value: value. self answer ];
		yourself.
	self chooser: calendar
]

{ #category : #rendering }
MDLDateChooserComponent >> renderEditorOn: html [

	html text: self magritteDescription label, ':'; space.
	super renderEditorOn: html.

]

{ #category : #rendering }
MDLDateChooserComponent >> renderViewerOn: html [

	html text: self magritteDescription label, ':'; space.
	super renderViewerOn: html.

]
