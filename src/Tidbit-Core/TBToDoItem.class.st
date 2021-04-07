Class {
	#name : #TBToDoItem,
	#superclass : #TBRootObject,
	#instVars : [
		'description',
		'done',
		'completeByDate',
		'priority',
		'colorCode',
		'bestTimeOfDayToStart',
		'actualDateStarted',
		'estimatedDuration',
		'importance',
		'calendars'
	],
	#category : 'Tidbit-Core'
}

{ #category : #voyage }
TBToDoItem class >> isVoyageRoot [

	^ true
]

{ #category : #accessing }
TBToDoItem >> actualDateStarted [
	^ actualDateStarted
]

{ #category : #accessing }
TBToDoItem >> actualDateStarted: anObject [
	actualDateStarted := anObject
]

{ #category : #'accessing-magritte' }
TBToDoItem >> actualDateStartedDescription [
	<magritteDescription>

	^MADateDescription new
		accessor: #actualDateStarted;
		label: 'Actual Date Started';
		priority: 70;
		yourself
]

{ #category : #accessing }
TBToDoItem >> bestTimeOfDayToStart [
	^ bestTimeOfDayToStart
]

{ #category : #accessing }
TBToDoItem >> bestTimeOfDayToStart: anObject [
	bestTimeOfDayToStart := anObject
]

{ #category : #'accessing-magritte' }
TBToDoItem >> bestTimeOfDayToStartDescription [
	<magritteDescription>

	^MATimeDescription new
		accessor: #bestTimeOfDayToStart;
		label: 'Best Time Of Day To Start';
		priority: 60;
		yourself
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
		priority: 110;
		yourself
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

	^MADateAndTimeDescription new
		"accessor: #completeByDate;"
		accessor: (MAPluggableAccessor 
			read: [ :item | item completeByDate "yyyymmdd" ]
			write: [ :item :value |
				value ifNotNil: [ 
					item 
						instVarNamed: 'completeByDate' 
						put: "(Date fromString: value)" value ] ]);
		default: DateAndTime now printString;
		label: 'Complete By Date';
		priority: 30;
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

{ #category : #'accessing-magritte' }
TBToDoItem >> descriptionDone [
	<magritteDescription>

	^MABooleanDescription new
		accessor: #done;
		label: 'Done';
		priority: 10;
		default: false;
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
		priority: 90;
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
		priority: 100;
		yourself
]

{ #category : #initalize }
TBToDoItem >> initialize [

	super initialize.

	self done: false.
	self description: String new.
	self completeByDate: DateAndTime now.
	self priority: 0.
	self bestTimeOfDayToStart: Time now.
	self actualDateStarted: Date today.
	self estimatedDuration: 1 hour.
	self importance: 'Medium'.
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

	^self description
]

{ #category : #printing }
TBToDoItem >> mdlDisplayString [

	^self description
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
		priority: 40;
		beInteger;
		yourself
]
