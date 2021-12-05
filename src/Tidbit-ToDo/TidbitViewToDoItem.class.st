Class {
	#name : #TidbitViewToDoItem,
	#superclass : #MDSComponent,
	#instVars : [
		'model',
		'itemComponent',
		'subtasksComponent'
	],
	#category : #'Tidbit-ToDo-MaterialWeb'
}

{ #category : #'instance creation' }
TidbitViewToDoItem class >> on: aModel [

	^ self new
		initializeOn: aModel;
		yourself
]

{ #category : #initialization }
TidbitViewToDoItem >> initializeOn: aModel [
	| theDescription newComponent |

	self model: aModel.
	theDescription := aModel magritteDescription.
	theDescription componentRenderer: TidbitViewTaskRenderer.
	newComponent := theDescription componentClass memento: (aModel mementoClass model: aModel description: theDescription).
	self itemComponent: newComponent
]

{ #category : #accessing }
TidbitViewToDoItem >> itemComponent [

	^ itemComponent
]

{ #category : #accessing }
TidbitViewToDoItem >> itemComponent: anObject [

	itemComponent := anObject
]

{ #category : #accessing }
TidbitViewToDoItem >> model [

	^ model
]

{ #category : #accessing }
TidbitViewToDoItem >> model: anObject [

	model := anObject
]

{ #category : #rendering }
TidbitViewToDoItem >> renderContentOn: html [

	html text: self model mdPrimaryString.
	html render: self itemComponent
]

{ #category : #accessing }
TidbitViewToDoItem >> subtasksComponent [

	^ subtasksComponent
]

{ #category : #accessing }
TidbitViewToDoItem >> subtasksComponent: anObject [

	subtasksComponent := anObject
]
