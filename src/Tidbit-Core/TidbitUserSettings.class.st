Class {
	#name : #TidbitUserSettings,
	#superclass : #TidbitRootObject,
	#instVars : [
		'layoutDensity'
	],
	#category : #'Tidbit-Core'
}

{ #category : #voyage }
TidbitUserSettings class >> isVoyageRoot [

	^ false
]

{ #category : #initialization }
TidbitUserSettings >> initialize [

	super initialize.

	self layoutDensity: 'Auto'.

]

{ #category : #accessing }
TidbitUserSettings >> layoutDensity [
	^ layoutDensity
]

{ #category : #accessing }
TidbitUserSettings >> layoutDensity: anObject [
	layoutDensity := anObject
]

{ #category : #'accessing-magritte' }
TidbitUserSettings >> layoutDensityDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
		accessor: #layoutDensity;
		label: 'Layout Density';
		options: {'Auto'. 'Normal'. 'Dense'};
		priority: 10;
		yourself
]

{ #category : #printing }
TidbitUserSettings >> mdDisplaySecondaryString [

	^ 'Layout Density: ', self layoutDensity greaseString
]

{ #category : #printing }
TidbitUserSettings >> mdPrimaryString [

	^ 'User Settings for: ???'
]
