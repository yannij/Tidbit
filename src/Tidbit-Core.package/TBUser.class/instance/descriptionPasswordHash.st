accessing-magritte
descriptionPasswordHash
	<magritteDescription>
	^ MAPasswordDescription new
		accessor: #passwordHash;
		default: '';
		label: 'Password';
		priority: 15;
		yourself