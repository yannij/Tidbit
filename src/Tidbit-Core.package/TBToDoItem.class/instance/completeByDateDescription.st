accessing-magritte
completeByDateDescription
	<xmagritteDescription>
	^ MADateDescription new
		accessor: #completeByDate;
		default: Date today;
		label: 'Complete By Date';
		priority: 30;
		yourself