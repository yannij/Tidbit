Class {
	#name : #TidbitViewUsers,
	#superclass : #MCWLayoutComponent,
	#category : #'Tidbit-MaterialComponentsWeb'
}

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
TidbitViewUsers >> renderContentOn: html [


	html div style: 'padding: 8px'; with: [
		self renderUsersOn: html ]
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
TidbitViewUsers >> renderTablePagination: aUserList on: html [

	html div mdcDataTable__pagination with: [
		html div mdcDataTable__paginationTrailing; with: [
			"html div mdcDataTable__paginationRowsPerPage; with: [
				html div mdcDataTable__paginationRowsPerPageLabel; with: [
					html text: 'Rows per page' ] ].
				html div x; with: []".
			html div mdcDataTable__paginationNavigation; with: [
				html div mdcDataTable__paginationTotal; with: [ html text: '1-', aUserList size printString, ' of ', aUserList size printString ].
				html button mdcIconButton; mdcMaterialIcons; mdcDataTable__paginationButton; attributeAt: 'data-first-page' put: 'true'; disabled;
					with: [ html div mdcButton__icon; with: 'first_page' ].
				html button mdcIconButton; mdcMaterialIcons; mdcDataTable__paginationButton; attributeAt: 'data-prev-page' put: 'true'; disabled;
					with: [ html div mdcButton__icon; with: 'chevron_left' ].
				html button mdcIconButton; mdcMaterialIcons; mdcDataTable__paginationButton; attributeAt: 'data-next-page' put: 'true';
					with: [ html div mdcButton__icon; with: 'chevron_right' ].
				html button mdcIconButton; mdcMaterialIcons; mdcDataTable__paginationButton; attributeAt: 'data-last-page' put: 'true';
					with: [ html div mdcButton__icon; with: 'last_page' ] ] ] ]
]

{ #category : #rendering }
TidbitViewUsers >> renderTableRows: aUserList on: html [

	html tableBody mdcDataTable__content; with: [
		aUserList do: [ :eachUser |
			html tableRow mdcDataTable__row; with: [
				(self dataRowFrom: eachUser) doWithIndex: [ :eachCell :index |
					html tableData mdcDataTable__cell; scope: 'row'; with: [
						index = 1
							ifTrue: [
								html div mdcChip; mdcRippleUpgraded; with: [
									html anchor mdcChip__text; callback: [ self mcwApplicationGet viewUserSetTo: eachUser ]; with: eachCell ] ]
							ifFalse: [ html text: eachCell ] ] ] ] ] ]
]

{ #category : #rendering }
TidbitViewUsers >> renderUsersOn: html [
	| userList |

	userList := self users.

	html heading level3; mdcTypography_subtitle1; with: 'Users'.

	html div mdcDataTable with: [
		html div mdcDataTable__tableContainer; with: [
			html table mdcDataTable__table;  with: [
				self renderTableHeadingsOn: html.
				self renderTableRows: userList on: html ].
			self renderTablePagination: userList on: html ] ]
]

{ #category : #rendering }
TidbitViewUsers >> users [

	^ self mcwApplicationGet repository selectAll: TidbitUser
]
