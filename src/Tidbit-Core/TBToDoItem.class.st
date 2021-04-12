Class {
	#name : #TBToDoItem,
	#superclass : #TBRootObject,
	#instVars : [
		'summary',
		'description',
		'done',
		'completeByDate',
		'completeByTime',
		'priority',
		'colorCode',
		'bestTimeOfDayToStart',
		'actualDateStarted',
		'estimatedDuration',
		'importance',
		'calendars'
	],
	#category : #'Tidbit-Core'
}

{ #category : #voyage }
TBToDoItem class >> isVoyageRoot [

	^ true
]

{ #category : #accessing }
TBToDoItem >> calendars [
	^ calendars
]

{ #category : #accessing }
TBToDoItem >> calendars: anObject [
	calendars := anObject
]

{ #category : #'accessing-magritte' }
TBToDoItem >> calendarsDescription [

	<magritteDescription>
	^ MAMultipleOptionDescription new
		accessor: #calendars;
		label: 'Calendars';
		priority: 110;
		options: #(Home Work Vacation Secret);
		reference: MASymbolDescription new;
		yourself
]

{ #category : #accessing }
TBToDoItem >> colorCode [
	^ colorCode
]

{ #category : #accessing }
TBToDoItem >> colorCode: anObject [
	colorCode := anObject
]

{ #category : #'accessing-magritte' }
TBToDoItem >> colorCodeDescription [
	<magritteDescription>

	^MAColorDescription new
		accessor: #colorCode;
		default: Color white;
		label: 'Color Code';
		priority: 90;
		yourself
]

{ #category : #accessing }
TBToDoItem >> completeBy [

	^ completeByDate yyyymmdd, ' ', completeByTime print24
]

{ #category : #accessing }
TBToDoItem >> completeByDate [
	^ completeByDate
]

{ #category : #accessing }
TBToDoItem >> completeByDate: anObject [
	completeByDate := anObject
]

{ #category : #'accessing-magritte' }
TBToDoItem >> completeByDateDescription [
	<magritteDescription>

	^ MADateDescription new
		accessor: #completeByDate;
		default: Date today;
		label: 'Complete By Date';
		priority: 30;
		yourself

]

{ #category : #'accessing-magritte' }
TBToDoItem >> completeByDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #completeBy;
		label: 'Complete By';
		priority: 200;
		beReadonly;
		yourself

]

{ #category : #accessing }
TBToDoItem >> completeByTime [
	^ completeByTime
]

{ #category : #accessing }
TBToDoItem >> completeByTime: anObject [
	completeByTime := anObject
]

{ #category : #'accessing-magritte' }
TBToDoItem >> completeByTimeDescription [
	<magritteDescription>

	^MATimeDescription new
		accessor: #completeByTime;
		label: 'Complete By Time';
		priority: 40;
		yourself
]

{ #category : #accessing }
TBToDoItem >> description [
	^ description
]

{ #category : #accessing }
TBToDoItem >> description: anObject [
	description := anObject
]

{ #category : #'accessing-magritte' }
TBToDoItem >> descriptionDescription [
	<magritteDescription>

	^MAMemoDescription new
		accessor: #description;
		default: '';
		label: 'Description';
		priority: 20;
		yourself
]

{ #category : #accessing }
TBToDoItem >> done [
	^ done
]

{ #category : #accessing }
TBToDoItem >> done: anObject [
	done := anObject
]

{ #category : #'accessing-magritte' }
TBToDoItem >> doneDescription [
	<magritteDescription>

	^MABooleanDescription new
		accessor: #done;
		label: 'Done';
		priority: 10;
		default: false;
		yourself
]

{ #category : #accessing }
TBToDoItem >> estimatedDuration [
	^ estimatedDuration
]

{ #category : #accessing }
TBToDoItem >> estimatedDuration: anObject [
	estimatedDuration := anObject
]

{ #category : #'accessing-magritte' }
TBToDoItem >> estimatedDurationDescription [
	<magritteDescription>

	^MADurationDescription new
		accessor: #estimatedDuration;
		label: 'Estimated Duration';
		priority: 50;
		yourself
]

{ #category : #accessing }
TBToDoItem >> importance [
	^ importance
]

{ #category : #accessing }
TBToDoItem >> importance: anObject [
	importance := anObject
]

{ #category : #'accessing-magritte' }
TBToDoItem >> importanceDescription [
	<magritteDescription>

	^MASingleOptionDescription new
		accessor: #importance;
		label: 'Importance';
		options: {'High'. 'Medium'. 'Low'};
		priority: 80;
		yourself
]

{ #category : #initalize }
TBToDoItem >> initialize [

	super initialize.

	self done: false.
	self summary: String new.
	self description: String new.
	self completeByDate: Date today.
	self completeByTime: Time now.
	self estimatedDuration: 1 hour.
	self priority: 0.
	self importance: 'Medium'.
	self colorCode: Color new.
	self calendars: OrderedCollection new.

]

{ #category : #'accessing-magritte' }
TBToDoItem >> isVoyageRoot [
	^true
]

{ #category : #printing }
TBToDoItem >> mdDisplaySecondaryString [

	^(self done ifTrue: ['DONE'] ifFalse: ['NOT-DONE']),
		', ', 'Priority ', self priority printString,
		', ', 'Complete by  ', self completeByDate printString
]

{ #category : #printing }
TBToDoItem >> mdPrimaryString [

	^self summary
]

{ #category : #printing }
TBToDoItem >> mdlDisplayString [

	^self summary
]

{ #category : #accessing }
TBToDoItem >> priority [
	^ priority
]

{ #category : #accessing }
TBToDoItem >> priority: anObject [
	priority := anObject
]

{ #category : #'accessing-magritte' }
TBToDoItem >> priorityDescription [
	<magritteDescription>

	^MANumberDescription new
		accessor: #priority;
		default: 0;
		label: 'Priority';
		priority: 60;
		beInteger;
		yourself
]

{ #category : #accessing }
TBToDoItem >> summary [
	^ summary
]

{ #category : #accessing }
TBToDoItem >> summary: anObject [
	summary := anObject
]

{ #category : #'accessing-magritte' }
TBToDoItem >> summaryDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #summary;
		default: '';
		label: 'Summary';
		priority: 15;
		beRequired;
		yourself
]
