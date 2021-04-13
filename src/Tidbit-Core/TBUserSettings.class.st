Class {
	#name : #TBUserSettings,
	#superclass : #TBRootObject,
	#instVars : [
		'layoutDensity'
	],
	#category : #'Tidbit-Core'
}

{ #category : #voyage }
TBUserSettings class >> isVoyageRoot [

	^ false
]

{ #category : #initialization }
TBUserSettings >> initialize [

	super initialize.

	self layoutDensity: 'Auto'.

]

{ #category : #accessing }
TBUserSettings >> layoutDensity [
	^ layoutDensity
]

{ #category : #accessing }
TBUserSettings >> layoutDensity: anObject [
	layoutDensity := anObject
]

{ #category : #'accessing-magritte' }
TBUserSettings >> layoutDensityDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
		accessor: #layoutDensity;
		label: 'Layout Density';
		options: {'Auto'. 'Normal'. 'Dense'};
		priority: 10;
		yourself
]

{ #category : #printing }
TBUserSettings >> mdDisplaySecondaryString [

	^ 'Layout Density: ', self layoutDensity greaseString
]

{ #category : #printing }
TBUserSettings >> mdPrimaryString [

	^ 'User Settings for: ???'
]
