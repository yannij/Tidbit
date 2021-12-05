Class {
	#name : #TidbitViewTaskRenderer,
	#superclass : #MAComponentRenderer,
	#category : #'Tidbit-ToDo-MaterialWeb'
}

{ #category : #rendering }
TidbitViewTaskRenderer >> renderContainer: aDescription [ 

	self renderContainerCustom: aDescription 
]

{ #category : #rendering }
TidbitViewTaskRenderer >> renderContainerCustom: aDescription [ 
	| mainDescriptions subtaskDescription |

	mainDescriptions := OrderedCollection new.
	subtaskDescription := nil.
	aDescription do: [ :eachDescription |
		eachDescription label = 'Subtasks'
			ifTrue: [ subtaskDescription := eachDescription ]
			ifFalse: [ mainDescriptions add: eachDescription ] ].

	html div mdcLayoutGrid; style: 'background: var(--mdc-theme-surface)'; with: [
		html div mdcLayoutGrid__inner; with: [
			html div mdcLayoutGrid__cell; mdcLayoutGrid__cell_span3; with: [
				self visitAll: (mainDescriptions copyFrom: 1 to: 4) ].
			html div mdcLayoutGrid__cell; mdcLayoutGrid__cell_span3; with: [
				self visitAll: (mainDescriptions copyFrom: 5 to: 8) ].
			html div mdcLayoutGrid__cell; mdcLayoutGrid__cell_span3; with: [
				self visitAll: (mainDescriptions copyFrom: 10 to: mainDescriptions size) ].
			html div mdcLayoutGrid__cell; mdcLayoutGrid__cell_span12; with: [
			html div
				style: 'overflow-x: auto';
				with: [
					self visit: subtaskDescription ] ] ] ].
]

{ #category : #rendering }
TidbitViewTaskRenderer >> renderControl: aDescription [

	super renderControl: aDescription
]

{ #category : #rendering }
TidbitViewTaskRenderer >> renderElement: aDescription [

	"html mdlCell
		style: 'margin: 0';
		size: 12;
		tabletSize: 8;
		phoneSize: 4;
		stretch;
		with: [ super renderElement: aDescription ]."

	"html div class: 'mdc-form-field'; with: [
		super renderElement: aDescription]"
	super renderElement: aDescription

]

{ #category : #rendering }
TidbitViewTaskRenderer >> renderGroup: aDescription [

	super renderGroup: aDescription.

	"group isNil ifTrue: [ ^ self ].
	html definitionTerm
		class: 'group';
		with: group"
]

{ #category : #rendering }
TidbitViewTaskRenderer >> renderLabel: aDescription [
	"Do nothing. #renderElementOn: also does the label"
]

{ #category : #visiting }
TidbitViewTaskRenderer >> visitAll: aCollection [

	"super visitAll: aCollection"
	aCollection do: [ :each | self visit: each ] separatedBy: [ self visitDivider ]
]

{ #category : #visiting }
TidbitViewTaskRenderer >> visitDivider [

	"html html: '<hr class=""mdc-list-divider"">'"
	"html div
		style: 'line-height: 8px';
		with: [html space]"
]
