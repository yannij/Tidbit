Class {
	#name : #TidbitViewUsers,
	#superclass : #MCWWebComponent,
	#category : #'Tidbit-MaterialComponentsWeb'
}

{ #category : #rendering }
TidbitViewUsers >> dataRows [
	| users |

	users := self mcwApplicationGet repository selectAll: TidbitUser.

	^ users asOrderedCollection collect: [ :eachUser |
		| dataRow |
		dataRow := OrderedCollection new.
		dataRow add: eachUser username.
		dataRow add: eachUser fullName.
		dataRow add: eachUser email.
		dataRow add: eachUser website.
		dataRow add: eachUser dateCreated.
		dataRow ]
]

{ #category : #rendering }
TidbitViewUsers >> renderContentOn: html [

	self renderTableOn: html
]

{ #category : #rendering }
TidbitViewUsers >> renderTableHeadingsOn: html [
	| dataHeadings |

	dataHeadings := #( 'Username' 'Full Name' 'Email' 'Website' 'Date Created').
	html tableHead: [
		html tableRow "mdcDataTable__headerRow" class: 'mdc-data-table__header-row'; with: [
			dataHeadings do: [ :each |
				html tableHeading mdcDataTable__headerCell; mdcRole: 'columnHeader'; scope: 'col'; with: each ] ] ]

]

{ #category : #rendering }
TidbitViewUsers >> renderTableOn: html [

	html heading level6; mdcTypography_headline6; with: 'Users'.
	html div mdcDataTable with: [
		html div mdcDataTable__tableContainer; with: [
			| dataRows |
			dataRows := self dataRows.
			html table mdcDataTable__table;  with: [
				self renderTableHeadingsOn: html.
				self renderTableRows: dataRows on: html ].
		self renderTableRows: dataRows paginationOn: html ] ]
]

{ #category : #rendering }
TidbitViewUsers >> renderTableRows: dataRows on: html [

	html tableBody mdcDataTable__content; with: [
		dataRows do: [ :eachRow |
			html tableRow mdcDataTable__row; with: [
				eachRow keysAndValuesDo: [ :index :each |
					html tableData mdcDataTable__cell; scope: 'row'; with: each ] ] ] ]
]

{ #category : #rendering }
TidbitViewUsers >> renderTableRows: dataRows paginationOn: html [

	html div mdcDataTable__pagination with: [
		html div mdcDataTable__paginationTrailing; with: [
			"html div mdcDataTable__paginationRowsPerPage; with: [
				html div mdcDataTable__paginationRowsPerPageLabel; with: [
					html text: 'Rows per page' ] ].
				html div x; with: []".
			html div mdcDataTable__paginationNavigation; with: [
				html div mdcDataTable__paginationTotal; with: [ html text: '1-', dataRows size printString, ' of ', dataRows size printString ].
				html button mdcIconButton; mdcMaterialIcons; mdcDataTable__paginationButton; attributeAt: 'data-first-page' put: 'true'; disabled;
					with: [ html div mdcButton__icon; with: 'first_page' ].
				html button mdcIconButton; mdcMaterialIcons; mdcDataTable__paginationButton; attributeAt: 'data-prev-page' put: 'true'; disabled;
					with: [ html div mdcButton__icon; with: 'chevron_left' ].
				html button mdcIconButton; mdcMaterialIcons; mdcDataTable__paginationButton; attributeAt: 'data-next-page' put: 'true';
					with: [ html div mdcButton__icon; with: 'chevron_right' ].
				html button mdcIconButton; mdcMaterialIcons; mdcDataTable__paginationButton; attributeAt: 'data-last-page' put: 'true';
					with: [ html div mdcButton__icon; with: 'last_page' ] ] ] ]
]
