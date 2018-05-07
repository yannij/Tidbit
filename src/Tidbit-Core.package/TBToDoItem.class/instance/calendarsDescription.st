accessing-magritte
calendarsDescription

	<magritteDescription>
	^ MAMultipleOptionDescription new
		accessor: #calendars;
		label: 'Calendars';
		priority: 110;
		options: #(Home Work Vacation Secret);
		reference: MASymbolDescription new;
		yourself