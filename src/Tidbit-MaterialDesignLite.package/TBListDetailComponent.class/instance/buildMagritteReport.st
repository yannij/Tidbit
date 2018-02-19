private
buildMagritteReport

	^ (TBTableView
		rows: self value
		description: self reference)
		sortEnabled: self magritteDescription isOrdered not;
		addColumn: (MACommandColumn new
			addCommandOn: self selector: #edit: text: 'edit';
			addCommandOn: self selector: #remove: text: 'remove';
			yourself);
		yourself