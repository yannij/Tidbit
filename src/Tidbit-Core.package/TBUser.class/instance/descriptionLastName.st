accessing-magritte
descriptionLastName
	<magritteDescription>
	^ MAStringDescription new
		accessor: #lastName;
		default: '';
		label: 'Last Name';
		priority: 30;
		yourself