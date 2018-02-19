accessing-magritte
descriptionToDoItems
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #toDoItems;
		classes: {TBToDoItem};
		default: OrderedCollection new;
		label: 'ToDo Items';
		priority: 40;
		"beOrdered;"
		yourself