accessing-magritte
descriptionUserSettings
	<magritteDescription>

	^MAToOneRelationDescription new
		accessor: #userSettings;
		label: 'User Settings';
		classes: {TBUserSettings};
		priority: 35;
		beRequired;
		yourself