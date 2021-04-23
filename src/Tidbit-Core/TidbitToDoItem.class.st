Class {
	#name : #TidbitToDoItem,
	#superclass : #TidbitRootObject,
	#instVars : [
		'summary',
		'description',
		'done',
		'completeByDate',
		'completeByTime',
		'priority',
		'colorCode',
		'estimatedDuration',
		'importance',
		'calendars'
	],
	#category : #'Tidbit-Core'
}

{ #category : #voyage }
TidbitToDoItem class >> descriptionContainer [
	<voyageContainer>

	^ VOContainer new
		collectionName: 'TidbitToDoItem'
		yourself
]

{ #category : #voyage }
TidbitToDoItem class >> isVoyageRoot [

	^ true
]

{ #category : #voyage }
TidbitToDoItem class >> mongoCompleteByDate [
	<voyageDescription>

	^ VOToOneDescription new
		attributeName: 'completeByDate';
		accessor: (MAPluggableAccessor
			read: [ :todoItem | todoItem completeByDate ]
			write: [ :todoItem :value | todoItem completeByDate: value asDate ]);
		yourself
]

{ #category : #accessing }
TidbitToDoItem >> calendars [
	^ calendars
]

{ #category : #accessing }
TidbitToDoItem >> calendars: anObject [
	calendars := anObject
]

{ #category : #'accessing-magritte' }
TidbitToDoItem >> calendarsDescription [

	<magritteDescription>
	^ MAMultipleOptionDescription new
		accessor: #calendars;
		label: 'Calendars';
		cssClass: 'mcw-textfield';
		priority: 110;
		options: #(Home Work Vacation Secret);
		reference: MASymbolDescription new;
		yourself
]

{ #category : #accessing }
TidbitToDoItem >> colorCode [
	^ colorCode
]

{ #category : #accessing }
TidbitToDoItem >> colorCode: anObject [
	colorCode := anObject
]

{ #category : #'accessing-magritte' }
TidbitToDoItem >> colorCodeDescription [
	<magritteDescription>

	^ MAColorDescription new
		accessor: #colorCode;
		default: Color white;
		label: 'Color Code';
		cssClass: 'mcw-textfield';
		priority: 90;
		yourself
]

{ #category : #accessing }
TidbitToDoItem >> completeBy [

	^ completeByDate asDate yyyymmdd, ' ', completeByTime print24
]

{ #category : #accessing }
TidbitToDoItem >> completeByDate [
	^ completeByDate
]

{ #category : #accessing }
TidbitToDoItem >> completeByDate: anObject [
	completeByDate := anObject
]

{ #category : #'accessing-magritte' }
TidbitToDoItem >> completeByDateDescription [
	<magritteDescription>

	^ MADateDescription new
		accessor: #completeByDate;
		default: Date today;
		label: 'Complete By Date';
		cssClass: 'mcw-textfield';
		priority: 30;
		yourself

]

{ #category : #'accessing-magritte' }
TidbitToDoItem >> completeByDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #completeBy;
		label: 'Complete By';
		cssClass: 'mcw-textfield';
		priority: 200;
		beReadonly;
		yourself

]

{ #category : #accessing }
TidbitToDoItem >> completeByTime [
	^ completeByTime
]

{ #category : #accessing }
TidbitToDoItem >> completeByTime: anObject [
	completeByTime := anObject
]

{ #category : #'accessing-magritte' }
TidbitToDoItem >> completeByTimeDescription [
	<magritteDescription>

	^ MATimeDescription new
		accessor: #completeByTime;
		label: 'Complete By Time';
		cssClass: 'mcw-textfield';
		priority: 40;
		yourself
]

{ #category : #accessing }
TidbitToDoItem >> description [
	^ description
]

{ #category : #accessing }
TidbitToDoItem >> description: anObject [
	description := anObject
]

{ #category : #'accessing-magritte' }
TidbitToDoItem >> descriptionDescription [
	<magritteDescription>

	^ MAMemoDescription new
		accessor: #description;
		default: '';
		label: 'Description';
		cssClass: 'mcw-textfield';
		priority: 20;
		yourself
]

{ #category : #accessing }
TidbitToDoItem >> done [
	^ done
]

{ #category : #accessing }
TidbitToDoItem >> done: anObject [
	done := anObject
]

{ #category : #'accessing-magritte' }
TidbitToDoItem >> doneDescription [
	<magritteDescription>

	^ MABooleanDescription new
		accessor: #done;
		label: 'Done';
		cssClass: 'mcw-textfield';
		priority: 10;
		default: false;
		yourself
]

{ #category : #accessing }
TidbitToDoItem >> estimatedDuration [
	^ estimatedDuration
]

{ #category : #accessing }
TidbitToDoItem >> estimatedDuration: anObject [
	estimatedDuration := anObject
]

{ #category : #'accessing-magritte' }
TidbitToDoItem >> estimatedDurationDescription [
	<magritteDescription>

	^ MADurationDescription new
		accessor: #estimatedDuration;
		label: 'Estimated Duration';
		cssClass: 'mcw-textfield';
		priority: 50;
		yourself
]

{ #category : #accessing }
TidbitToDoItem >> importance [
	^ importance
]

{ #category : #accessing }
TidbitToDoItem >> importance: anObject [
	importance := anObject
]

{ #category : #'accessing-magritte' }
TidbitToDoItem >> importanceDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
		accessor: #importance;
		label: 'Importance';
		cssClass: 'mcw-textfield';
		options: {'High'. 'Medium'. 'Low'};
		priority: 80;
		yourself
]

{ #category : #initialization }
TidbitToDoItem >> initialize [

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
TidbitToDoItem >> isVoyageRoot [
	^ true
]

{ #category : #printing }
TidbitToDoItem >> mdDisplaySecondaryString [

	^ (self done ifTrue: [ 'DONE' ] ifFalse: [ 'NOT-DONE' ]),
		', ', 'Priority ', self priority printString,
		', ', 'Complete by  ', self completeByDate printString
]

{ #category : #printing }
TidbitToDoItem >> mdPrimaryString [

	^ self summary
]

{ #category : #printing }
TidbitToDoItem >> mdlDisplayString [

	^ self summary
]

{ #category : #accessing }
TidbitToDoItem >> priority [
	^ priority
]

{ #category : #accessing }
TidbitToDoItem >> priority: anObject [
	priority := anObject
]

{ #category : #'accessing-magritte' }
TidbitToDoItem >> priorityDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #priority;
		default: 0;
		label: 'Priority';
		cssClass: 'mcw-textfield';
		priority: 60;
		beInteger;
		mcwSliderStep: 5;
		yourself
]

{ #category : #accessing }
TidbitToDoItem >> summary [
	^ summary
]

{ #category : #accessing }
TidbitToDoItem >> summary: anObject [
	summary := anObject
]

{ #category : #'accessing-magritte' }
TidbitToDoItem >> summaryDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #summary;
		default: '';
		label: 'Summary';
		cssClass: 'mcw-textfield';
		priority: 15;
		beRequired;
		yourself
]
