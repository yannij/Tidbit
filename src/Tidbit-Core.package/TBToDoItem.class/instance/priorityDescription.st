accessing-magritte
priorityDescription
	<magritteDescription>
	^ MANumberDescription new
		accessor: #priority;
		default: 0;
		label: 'Priority';
		priority: 40;
		beInteger;
		yourself