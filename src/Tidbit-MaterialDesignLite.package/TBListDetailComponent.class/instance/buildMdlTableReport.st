private
buildMdlTableReport

	^TBMdlSortableTable new
		parent: self;
		attributeDescriptions: self attributeDescriptions;
		"title: self magritteDescription label;"
		title: self memento model mdlDisplayString;
		"selectable: true;"
		header: (self attributeDescriptions collect: [:each | each label]);
		rows: self value;
		rowsPerPagePossibilities: #(6 25 50 100 200).
