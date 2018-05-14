accessing-magritte
descriptionDateCreated
	"<magritteDescription>"

	^MADateAndTimeDescription new
		"accessor: #dateCreated;"
		accessor: (MAPluggableAccessor 
			read: [ :item | item dateCreated ]
			write: [ :item :value |
				value ifNotNil: [ 
					item 
						instVarNamed: 'dateCreated' 
						put: "(Date fromString: value)" value ] ]);
		default: DateAndTime now printString;
		label: 'Date Created';
		priority: 17;
		yourself