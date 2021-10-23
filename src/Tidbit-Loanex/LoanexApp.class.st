"
I am an example loan/borrow exchange app, built using Material Design Seaside, Magritte, and Voyage/Mongo. The functionality was inspired by a question raised on the Pharo database Discord channel (approx mid-October 2021).
"
Class {
	#name : #LoanexApp,
	#superclass : #MDSResponsiveApp,
	#instVars : [
		'loginComponent',
		'currentUser',
		'viewUser',
		'viewUsers',
		'viewTask',
		'filterValues'
	],
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #'class initialization' }
LoanexApp class >> applicationPath [

	^ 'tidbit/loanex'
]

{ #category : #'class initialization' }
LoanexApp class >> dockerDeployPostLoad [
	<dockerDeployPostLoad>

	WAComponent mcwPublicServerUrlInstallDockerConfig
]

{ #category : #'class initialization' }
LoanexApp class >> dockerDeployPreLoad [
	<dockerDeployPreLoad>

	DockerDeploy current configNamesAdd: DockerDeploy defaultConfigName
]

{ #category : #'class initialization' }
LoanexApp class >> initialize [
	"Register path with Seaside.
	WAAdmin unregister: self applicationPath.
	"

	^ self mcwRegisterDeployment: self applicationPath
]

{ #category : #testing }
LoanexApp >> anonymousLoginAllowed [

	^ false
]

{ #category : #accessing }
LoanexApp >> applicationTitle [

	^ 'LoanEx'
]

{ #category : #'utility - login' }
LoanexApp >> authenticateUsername: aUsername password: aPassword [
	"Answer a user instance if hashed pssword matches saved passwrodHass,
	or answer nil is does not match, or user not found"

	^ (self findUser: aUsername)
		ifNil: [ nil ]
		ifNotNil: [ :value |
			value passwordHash = (MDSLogin passwordHashFor: (aPassword ifNil: [ '' ] ifNotNil: [ :arg | arg ]))
				ifTrue: [ value ]
				ifFalse: [ nil ] ]
]

{ #category : #initialization }
LoanexApp >> buildBodyRegion [

	^ MDSBodyRegion new
]

{ #category : #initialization }
LoanexApp >> buildLayout [

	^ (MDSLayoutAutoResponsive on: self)
		initializeComplete;
		yourself
]

{ #category : #initialization }
LoanexApp >> buildLoginComponent [

	^ MDSLogin new
		loginTitle: self applicationTitle;
		authenticationBlock: [ :username :password |
			| userOrNil |
			userOrNil := self authenticateUsername: username password: password.
			self viewUserSetTo: userOrNil.
			userOrNil ];
		recoverBlock: [ :username :tokenTyped :tokenSent |
			| userOrNil |
			self logFormat: 'Recovering: tokenTyped="{1}", tokenSent="{2}"' with: tokenTyped with: tokenSent.
			userOrNil := nil.
			tokenTyped = tokenSent ifTrue: [
				userOrNil := self findUser: username ].
			self viewUserSetTo: userOrNil.
			userOrNil ];
		registerBlock: [ :username :password |
			| userOrNil |
			self logFormat: 'Registering username="{1}"' with: username.
			userOrNil := self registerUsername: username password: password.
			self viewUserSetTo: userOrNil.
			userOrNil ];
		sendTokenBlock: [ :username |
			self logFormat: 'Sending token to username="{1}"' with: username.
			'1234' ];
		yourself
]

{ #category : #initialization }
LoanexApp >> buildPopupMenuSettings [
	| list |

	list := (MDSMenuList id: 'settingsPopup')
		itemsAdd: (MDSListItem iconName: 'view_sidebar' itemText: 'Side Sheet' callback: [ self layout sideSheetHiddenToggle ]);
		itemsAdd: (MDSListItem iconName: 'minimize' itemText: 'Collapse' callback: [ self layout topAappBarCollapsedToggle ]);
		itemsAdd: (MDSListItem iconName: 'all_out' itemText: 'Dense' callback: [ self layout denseViewToggle ]);
		"itemsAdd: (MDSListItem iconName: 'color_lens' itemText: 'Style' callback: [ self configureStyle ]);"
		itemsAdd: (MDSListItem iconName: 'login' itemText: 'Login' callback: [ self login ]);
		itemsAdd: (MDSListItem iconName: 'logout' itemText: 'Logout' callback: [ self logout ]);
		yourself.

	^ list
]

{ #category : #initialization }
LoanexApp >> buildSideNav [

	^ (MDSDrawer content: self buildSideNavList)
		yourself
]

{ #category : #initialization }
LoanexApp >> buildSideNavList [

	^ MDSList new
		itemsAdd: (MDSListItem itemText: 'Home' iconName: 'home' callback: [ self dismissMenuIfModalDrawer. self viewUserGo ]);
		itemsAdd: (MDSListItem itemText: 'Loans' iconName: 'thumb_up' callback: [ self dismissMenuIfModalDrawer. self viewToyLoansGo ]);
		itemsAdd: (MDSListItem itemText: 'Toys' iconName: 'widgets' callback: [ self dismissMenuIfModalDrawer. self viewTaskGo ]);
		itemsAdd: (MDSListItem itemText: 'Users' iconName: 'perm_identity' callback: [ self dismissMenuIfModalDrawer. self viewUsersGo ]);
		yourself
]

{ #category : #initialization }
LoanexApp >> buildSideSheet [

	^ MDSSideSheet new
]

{ #category : #initialization }
LoanexApp >> buildTopAppBar [
	| settingsPopup |

	settingsPopup := self buildPopupMenuSettings.

	^ (MDSTopAppBar title: self applicationTitle)
		startSectionAdd: self buildNavigationIcon;
		endSectionAdd: (MDSTopAppBarActionItem materialIcon: 'settings' onClickScript: settingsPopup openScript);
		endSectionAdd: settingsPopup;
		yourself
]

{ #category : #accessing }
LoanexApp >> colorTheme [

	^ {
#'primary' -> '1EB980'.
"#'on-primary' -> '000000'.
#'secondary' -> 'FF6859'.
#'on-secondary' -> '000000'.
#'surface' -> '121212'.
#'on-surface' -> 'FFFFFF'.
#'background' -> '121212'"
} asOrderedDictionary
]

{ #category : #accessing }
LoanexApp >> currentUser [

	^ currentUser
]

{ #category : #accessing }
LoanexApp >> currentUser: anObject [

	currentUser := anObject
]

{ #category : #accessing }
LoanexApp >> filterValues [

	^ filterValues
]

{ #category : #accessing }
LoanexApp >> filterValues: anObject [

	filterValues := anObject
]

{ #category : #'utility - login' }
LoanexApp >> findUser: aUsername [
	"Answer the user having username matching aUsername, or nil if not found"

	^ (self repository selectAll: LoanexUser)
		ifEmpty: [ nil ]
		ifNotEmpty: [ :value | value detect: [ :eachUser | eachUser username = aUsername ] ifNone: [ nil ] ]
]

{ #category : #initialization }
LoanexApp >> initialize [

	super initialize.

	self filterValues: LoanexFilterValues new.
	self filterValues toyAvailable: #both.
	self initializeLayout
]

{ #category : #initialization }
LoanexApp >> initializeLayout [

	self materialVersionDefault.

	self loginComponent: self buildLoginComponent.
	self viewUsers: LoanexUserListView new.
	self viewTask: (LoanexToyListView new filterView: LoanexToyFilterView new).

	self topAppBar: self buildTopAppBar.
	self sideNav: self buildSideNav.
	self bodyRegion: self buildBodyRegion.
	self sideSheet: self buildSideSheet.
	self sideSheet beHidden.

	self layout: self buildLayout.

	self bodyRegion component: self viewUser
]

{ #category : #accessing }
LoanexApp >> loginComponent [

	^ loginComponent
]

{ #category : #accessing }
LoanexApp >> loginComponent: anObject [

	loginComponent := anObject
]

{ #category : #navigation }
LoanexApp >> navTo: aModel [

	self navTo: aModel aspect: nil
]

{ #category : #navigation }
LoanexApp >> navTo: aModel  aspect: anAspect [
	| newView |

	aModel ifNil: [ ^ self ].

	newView := aModel asComponent
					addValidatedForm;
					"addMessage: 'hello';"
					yourself.

	self bodyRegion component: newView.
	self sideSheet beHidden
]

{ #category : #'utility - login' }
LoanexApp >> newUsername: aUsername password: aPassword [
	| userModel |

	userModel := LoanexUser new
		username: aUsername;
		fullName: aUsername;
		passwordHash: (MDSLogin passwordHashFor: aPassword);
		yourself.

	self repository save: userModel.

	^ userModel

]

{ #category : #'utility - login' }
LoanexApp >> registerUsername: aUsername password: aPassword [
	"Answer a new user instance built from the userId/password,
	or answer nil user already exists"

	^ (self findUser: aUsername)
		ifNil: [ self newUsername: aUsername password: aPassword ]
		ifNotNil: [ :value | "User already exists" nil ]
]

{ #category : #rendering }
LoanexApp >> renderLayoutOn: html [

	self renderSetColorTheme: self colorTheme on: html.
	self renderSetTypographyFont: 'Roboto Condensed' on: html.

	self isLoggedIn
		ifTrue: [ html render: self layout ]
		ifFalse: [
			self loginComponent
				ifNotNil: [ :value | html render: value  ]
				ifNil: [
					self anonymousLoginAllowed
						ifTrue: [ html render: self layout ]
						ifFalse: [
							self loginComponent ifNil: [ self loginComponent: self buildLoginComponent ].
							html render: self loginComponent ] ] ]
]

{ #category : #'utility - repository' }
LoanexApp >> repository [

	"^ TidbitExampleDatabase memory1"
	^ VORepository current
]

{ #category : #'utility - repository' }
LoanexApp >> repositoryRecreateTestData [

	LoanexDatabase repositorySetUpMemorySingleton
]

{ #category : #'utility - repository' }
LoanexApp >> repositoryResetConnection [
	"Do nothing for memory repository"
]

{ #category : #'accessing - model' }
LoanexApp >> saveObject: anObject [

	self repository save: anObject
]

{ #category : #updating }
LoanexApp >> updateRootFonts: anHtmlRoot [

	super updateRootFonts: anHtmlRoot.

	anHtmlRoot stylesheet url: (WAUrl absolute: 'https://fonts.googleapis.com/css?family=Roboto Condensed')
]

{ #category : #accessing }
LoanexApp >> viewTask [
	^ viewTask
]

{ #category : #accessing }
LoanexApp >> viewTask: anObject [
	viewTask := anObject
]

{ #category : #navigation }
LoanexApp >> viewTaskGo [

	self bodyRegion component: self viewTask.
	self sideSheet component: self viewTask filterView.
	self viewTask filterView
		ifNil: [ self sideSheet beHidden ]
		ifNotNil: [ :value | self sideSheet beUnHidden ]
]

{ #category : #navigation }
LoanexApp >> viewToyLoansGo [
	| newView |

	newView := LoanexToyLoanListView new filterView: LoanexToyLoadFilterView new; yourself.
	self bodyRegion component: newView.
	self sideSheet component: newView filterView.
	newView filterView
		ifNil: [ self sideSheet beHidden ]
		ifNotNil: [ :value | self sideSheet beUnHidden ]
]

{ #category : #accessing }
LoanexApp >> viewUser [
	^ viewUser
]

{ #category : #accessing }
LoanexApp >> viewUser: anObject [
	viewUser := anObject
]

{ #category : #navigation }
LoanexApp >> viewUserGo [

	self bodyRegion component: self viewUser.
	self sideSheet beHidden
]

{ #category : #navigation }
LoanexApp >> viewUserSetTo: aModel [
	| newView |

	self currentUser: aModel.

	aModel ifNil: [
		self viewUser: nil.
		^ self ].

	newView := aModel asComponent addValidatedForm; yourself.
	self viewUser: newView.
	self viewUserGo
]

{ #category : #accessing }
LoanexApp >> viewUsers [
	^ viewUsers
]

{ #category : #accessing }
LoanexApp >> viewUsers: anObject [
	viewUsers := anObject
]

{ #category : #navigation }
LoanexApp >> viewUsersGo [

	self bodyRegion component: self viewUsers.
	self sideSheet beHidden
]
