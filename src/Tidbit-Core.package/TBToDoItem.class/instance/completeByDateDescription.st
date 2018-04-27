accessing-magritte
completeByDateDescription
	<magritteDescription>
	^ MADateAndTimeDescription new
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

"	<magritteDescription>
	^VOToOneDescription new
		attributeName: 'completeByDate';
		accessor: (MAPluggableAccessor 
			read: [ :item | item completeByDate yyyymmdd ]
			write: [ :item :value |
				value ifNotNil: [ 
					item 
						instVarNamed: 'completeByDate' 
						put: (Date fromString: value) ] ]);
		beLazy;
		yourself.
"