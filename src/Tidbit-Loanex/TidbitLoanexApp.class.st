"
I am an example loan/borrow exchange app, built using Material Design Seaside, Magritte, and Voyage/Mongo. The functionality was inspired by a question raised on the Pharo database Discord channel (approx mid-October 2021).
"
Class {
	#name : #TidbitLoanexApp,
	#superclass : #MDSResponsiveApp,
	#instVars : [
		'loginComponent',
		'currentUser',
		'settingsView',
		'viewMap',
		'viewUser',
		'viewUsers',
		'viewTask',
		'viewTaskFilter',
		'appSettings'
	],
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #'class initialization' }
TidbitLoanexApp class >> applicationPath [

	^ 'tidbit/loanex'
]

{ #category : #'class initialization' }
TidbitLoanexApp class >> dockerDeployPostLoad [
	<dockerDeployPostLoad>

	WAComponent mcwPublicServerUrlInstallDockerConfig
]

{ #category : #'class initialization' }
TidbitLoanexApp class >> dockerDeployPreLoad [
	<dockerDeployPreLoad>

	DockerDeploy current configNamesAdd: DockerDeploy defaultConfigName
]

{ #category : #'class initialization' }
TidbitLoanexApp class >> initialize [
	"Register path with Seaside.
	WAAdmin unregister: self applicationPath.
	"

	^ self mcwRegisterDeployment: self applicationPath
]

{ #category : #testing }
TidbitLoanexApp >> anonymousLoginAllowed [

	^ false
]

{ #category : #accessing }
TidbitLoanexApp >> appSettings [

	^ appSettings
]

{ #category : #accessing }
TidbitLoanexApp >> appSettings: anObject [

	appSettings := anObject
]

{ #category : #accessing }
TidbitLoanexApp >> applicationTitle [

	^ 'LoanEx'
]

{ #category : #'utility - login' }
TidbitLoanexApp >> authenticateUsername: aUsername password: aPassword [
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
TidbitLoanexApp >> buildApplicationSettings [

	^ MDMApplicationSettings new
]

{ #category : #initialization }
TidbitLoanexApp >> buildBodyRegion [

	^ MDSBodyRegion new
]

{ #category : #initialization }
TidbitLoanexApp >> buildLayout [

	^ (MDSLayoutAutoResponsive on: self)
		initializeComplete;
		yourself
]

{ #category : #initialization }
TidbitLoanexApp >> buildLoginComponent [

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
TidbitLoanexApp >> buildPopupMenuSettings [
	| list |

	list := (MDSMenuList id: 'settingsPopup')
		itemsAdd: (MDSListItem iconName: 'view_sidebar' itemText: 'Side Sheet' callback: [ self layout sideSheetHiddenToggle ]);
		"itemsAdd: (MDSListItem iconName: 'waves' itemText: 'Responsive' callback: [ self toggleAutoResponsive ]);"
		itemsAdd: (MDSListItem iconName: 'minimize' itemText: 'Collapse' callback: [ self layout topAappBarCollapsedToggle ]);
		itemsAdd: (MDSListItem iconName: 'all_out' itemText: 'Dense' callback: [ self layout denseViewToggle ]);
		itemsAdd: (MDSListItem iconName: 'color_lens' itemText: 'Style' callback: [ self configureStyle ]);
		itemsAdd: (MDSListItem iconName: 'login' itemText: 'Login' callback: [ self login ]);
		itemsAdd: (MDSListItem iconName: 'logout' itemText: 'Logout' callback: [ self logout ]);
		yourself.

	^ list
]

{ #category : #initialization }
TidbitLoanexApp >> buildSideNav [

	^ (MDSDrawer content: self buildSideNavList)
		yourself
]

{ #category : #initialization }
TidbitLoanexApp >> buildSideNavList [

	^ MDSList new
		itemsAdd: (MDSListItem itemText: 'Home' iconName: 'home' callback: [ self dismissMenuIfModalDrawer. self viewUserGo ]);
		itemsAdd: (MDSListItem itemText: 'Tasks' iconName: 'checklist' callback: [ self dismissMenuIfModalDrawer. self viewTaskGo ]);
		itemsAdd: (MDSListItem itemText: 'Users' iconName: 'perm_identity' callback: [ self dismissMenuIfModalDrawer. self viewUsersGo ]);
		itemsAdd: (MDSListItem itemText: 'Tools' iconName: 'build_circle' callback: [ self dismissMenuIfModalDrawer. self viewToolsGo ]);
		yourself
]

{ #category : #initialization }
TidbitLoanexApp >> buildSideSheet [

	^ MDSSideSheet new
]

{ #category : #initialization }
TidbitLoanexApp >> buildTopAppBar [
	| settingsPopup |

	settingsPopup := self buildPopupMenuSettings.

	^ (MDSTopAppBar title: self applicationTitle)
		startSectionAdd: self buildNavigationIcon;
		endSectionAdd: (MDSTopAppBarActionItem materialIcon: 'settings' onClickScript: settingsPopup openScript);
		endSectionAdd: settingsPopup;
		yourself
]

{ #category : #actions }
TidbitLoanexApp >> configureStyle [
	| tmp |

	tmp := self bodyRegion component.
	self bodyRegion component: self settingsView.
	self settingsView: tmp
]

{ #category : #accessing }
TidbitLoanexApp >> currentUser [

	^ currentUser
]

{ #category : #accessing }
TidbitLoanexApp >> currentUser: anObject [

	currentUser := anObject
]

{ #category : #'utility - login' }
TidbitLoanexApp >> findUser: aUsername [
	"Answer the user having username matching aUsername, or nil if not found"

	^ (self repository selectAll: LoanexUser)
		ifEmpty: [ nil ]
		ifNotEmpty: [ :value | value detect: [ :eachUser | eachUser username = aUsername ] ifNone: [ nil ] ]
]

{ #category : #initialization }
TidbitLoanexApp >> initialize [

	super initialize.

	self initializeLayout
]

{ #category : #initialization }
TidbitLoanexApp >> initializeLayout [

	self materialVersionDefault.

	self loginComponent: self buildLoginComponent.
	self viewMap: IdentityDictionary new.
	self viewMapAt: #Tools put: TidbitViewTools new.
	self viewUsers: TidbitViewUsers new.
	self viewTask: TidbitViewTask new.
	self viewTaskFilter: TidbitViewTaskSideSheet new.

	self appSettings: self buildApplicationSettings.
	self settingsView: MDMApplicationSettingsView new.
	self topAppBar: self buildTopAppBar.
	self sideNav: self buildSideNav.
	self bodyRegion: self buildBodyRegion.
	self sideSheet: self buildSideSheet.
	self sideSheet beHidden.

	self layout: self buildLayout.

	self sideSheet component: self viewTaskFilter.
	self bodyRegion component: self viewUser
]

{ #category : #accessing }
TidbitLoanexApp >> loginComponent [

	^ loginComponent
]

{ #category : #accessing }
TidbitLoanexApp >> loginComponent: anObject [

	loginComponent := anObject
]

{ #category : #navigation }
TidbitLoanexApp >> navTo: aModel [

	self navTo: aModel aspect: nil
]

{ #category : #navigation }
TidbitLoanexApp >> navTo: aModel  aspect: anAspect [
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
TidbitLoanexApp >> newUsername: aUsername password: aPassword [
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
TidbitLoanexApp >> registerUsername: aUsername password: aPassword [
	"Answer a new user instance built from the userId/password,
	or answer nil user already exists"

	^ (self findUser: aUsername)
		ifNil: [ self newUsername: aUsername password: aPassword ]
		ifNotNil: [ :value | "User already exists" nil ]
]

{ #category : #rendering }
TidbitLoanexApp >> renderLayoutOn: html [

	self renderSetColorTheme: self themeColors on: html.
	self renderSetTypographyFont: self themeFontFamily on: html.

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
TidbitLoanexApp >> repository [

	"^ TidbitExampleDatabase memory1"
	^ VORepository current
]

{ #category : #'utility - repository' }
TidbitLoanexApp >> repositoryRecreateTestData [

	LoanexDatabase repositorySetUpMemorySingleton
]

{ #category : #'utility - repository' }
TidbitLoanexApp >> repositoryResetConnection [
	"Do nothing for memory repository"
]

{ #category : #'accessing - model' }
TidbitLoanexApp >> saveObject: anObject [

	self repository save: anObject
]

{ #category : #accessing }
TidbitLoanexApp >> settingsView [

	^ settingsView
]

{ #category : #accessing }
TidbitLoanexApp >> settingsView: anObject [

	settingsView := anObject
]

{ #category : #rendering }
TidbitLoanexApp >> themeColors [
	| result |

	result := OrderedDictionary new.

	self appSettings mdcTheme themeItems keysAndValuesDo: [ :eachKey :eachValue |
		result at: eachKey put: eachValue asHexString ].

	^ result
]

{ #category : #rendering }
TidbitLoanexApp >> themeFontFamily [

	^ self appSettings mdcTypography fontFamily
]

{ #category : #updating }
TidbitLoanexApp >> updateRootFonts: anHtmlRoot [
	| bugString |

	super updateRootFonts: anHtmlRoot.

	"fontNames := 'Roboto|Roboto+Condensed|Bree+Serif|Fontdiner+Swanky|Open+Sans|Oxygen+Mono|Pacifico'."
	"fontNames := '|' join: (self fonts collect: [:eachChoice | eachChoice googleFontsFamily])."

	"Patch for: https://github.com/material-components/material-components-web/issues/7264
	[MDC-Data-Table] thead > tr > th values are not bold as shown in the example"
	bugString := ':ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap'.

	anHtmlRoot stylesheet url: (WAUrl absolute: 'https://fonts.googleapis.com/css?family=', self appSettings mdcTypography fontFamily, bugString).
	self appSettings mdcTypography fontFamilies do: [ :eachFontFamily |
		anHtmlRoot stylesheet url: (WAUrl absolute: 'https://fonts.googleapis.com/css?family=', eachFontFamily, bugString) ]
]

{ #category : #accessing }
TidbitLoanexApp >> viewMap [
	^ viewMap
]

{ #category : #accessing }
TidbitLoanexApp >> viewMap: anObject [
	viewMap := anObject
]

{ #category : #accessing }
TidbitLoanexApp >> viewMapAt: aKey [

	self viewMapAt: aKey ifAbsent: [ nil ]
]

{ #category : #accessing }
TidbitLoanexApp >> viewMapAt: aKey ifAbsent: aBlock [

	self viewMap at: aKey ifAbsent: aBlock
]

{ #category : #accessing }
TidbitLoanexApp >> viewMapAt: aKey put: aContentArea [

	self viewMap at: aKey put: aContentArea
]

{ #category : #accessing }
TidbitLoanexApp >> viewTask [
	^ viewTask
]

{ #category : #accessing }
TidbitLoanexApp >> viewTask: anObject [
	viewTask := anObject
]

{ #category : #accessing }
TidbitLoanexApp >> viewTaskFilter [
	^ viewTaskFilter
]

{ #category : #accessing }
TidbitLoanexApp >> viewTaskFilter: anObject [
	viewTaskFilter := anObject
]

{ #category : #navigation }
TidbitLoanexApp >> viewTaskGo [

	self bodyRegion component: self viewTask.
	self sideSheet beUnHidden
]

{ #category : #navigation }
TidbitLoanexApp >> viewToolsGo [

	self bodyRegion component: (self viewMap at: #Tools).
	self sideSheet beHidden
]

{ #category : #accessing }
TidbitLoanexApp >> viewUser [
	^ viewUser
]

{ #category : #accessing }
TidbitLoanexApp >> viewUser: anObject [
	viewUser := anObject
]

{ #category : #navigation }
TidbitLoanexApp >> viewUserGo [

	self bodyRegion component: self viewUser.
	self sideSheet beHidden
]

{ #category : #navigation }
TidbitLoanexApp >> viewUserSetTo: aModel [
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
TidbitLoanexApp >> viewUsers [
	^ viewUsers
]

{ #category : #accessing }
TidbitLoanexApp >> viewUsers: anObject [
	viewUsers := anObject
]

{ #category : #navigation }
TidbitLoanexApp >> viewUsersGo [

	self bodyRegion component: self viewUsers.
	self sideSheet beHidden
]
