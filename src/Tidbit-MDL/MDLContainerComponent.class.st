Class {
	#name : #MDLContainerComponent,
	#superclass : #MAContainerComponent,
	#category : 'Tidbit-MDL'
}

{ #category : #decorating }
MDLContainerComponent >> addForm: aCollection [
	self addDecoration: (MDLFormDecoration buttons: aCollection)
]

{ #category : #decorating }
MDLContainerComponent >> addSwitch [
	self addDecoration: MDLSwitchDecoration new.
	self readonly: true
]

{ #category : #private }
MDLContainerComponent >> buildChildren [

	self magritteDescription
		componentClass: MDLContainerComponent;
		do: [:eachChild | eachChild componentClass: eachChild mdlComponentClass].

	^ self magritteDescription
		inject: Dictionary new
		into: [ :result :each |
			each isVisible ifTrue: [
				result at: each put: (each componentClass
					memento: self memento description: each parent: self) ].
			result ]
]

{ #category : #rendering }
MDLContainerComponent >> renderContentOn: html [

	"html mdlCell
		style: 'margin: 0';
		phoneSize: 12;
		size: 12;
		stretch;
		with: [ 
			self magritteDescription componentRenderer component: self on: html ]"

	super renderContentOn: html.

]
