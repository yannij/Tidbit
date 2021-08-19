Class {
	#name : #TidbitViewUsers,
	#superclass : #MCWLayoutComponent,
	#instVars : [
		'report'
	],
	#category : #'Tidbit-MaterialComponentsWeb'
}

{ #category : #rendering }
TidbitViewUsers >> buildReport [

	^ (MCWReport rows: self users description: TidbitUser magritteTemplate magritteDescription)
		showHeader: true;
		showFooter: true;
		addColumn: (DGActionColumn new
			commandBlock: (MessageSend receiver: self selector: #navTo:);
			yourself);
		yourself
]

{ #category : #rendering }
TidbitViewUsers >> dataRowFrom: aUser [
	| dataRow |

	dataRow := OrderedCollection new
		add: aUser username;
		add: aUser toDoItemsCount;
		add: aUser fullName;
		add: aUser email;
		add: aUser website;
		add: aUser dateCreated;
		yourself.

	^ dataRow
]

{ #category : #rendering }
TidbitViewUsers >> navTo: aModel [

	self mcwApplicationGet navTo: aModel
]

{ #category : #rendering }
TidbitViewUsers >> renderContentOn: html [

	html div style: 'padding: 8px'; with: [
		self renderTableOn: html ]
]

{ #category : #rendering }
TidbitViewUsers >> renderTableHeadingsOn: html [
	| dataHeadings |

	dataHeadings := #( 'Username' 'ToDo Count' 'Full Name' 'Email' 'Website' 'Date Created').
	html tableHead: [
		html tableRow "mdcDataTable__headerRow" class: 'mdc-data-table__header-row'; with: [
			dataHeadings do: [ :each |
				html tableHeading mdcDataTable__headerCell; mdcRole: 'columnHeader'; scope: 'col'; with: each ] ] ]

]

{ #category : #rendering }
TidbitViewUsers >> renderTableOn: html [

	html heading level3; mdcTypography_subtitle1; with: 'Users'.
	self report ifNil: [ self report: self buildReport ].
	html render: self report
]

{ #category : #accessing }
TidbitViewUsers >> report [
	^ report
]

{ #category : #accessing }
TidbitViewUsers >> report: anObject [
	report := anObject
]

{ #category : #rendering }
TidbitViewUsers >> users [

	^ self mcwApplicationGet repository selectAll: TidbitUser
]
