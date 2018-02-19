rendering
renderSelectListOn: html
	| selectTag selectId |

	self parent classes size > 1 ifTrue: [
		selectTag := html select.
		selectTag
			id: (selectId := html nextId);
			list: self parent classes;
			selected: self parent selected;
			"callback: [ :value | self parent selected: value ];"
			callback: [ :value | "values map is not built unless there is a callback"];
			onChange: (html jQuery ajax
				callback: [ :value |
					self parent selected: ((selectTag instVarNamed: 'values') at: value greaseInteger) ]
					value: (html jQuery id: selectId) value;
				yourself
				"script: [ :s | s alert: 'The submitted value is: ' , self parent selected printString, '.' ]");
			labels: [ :value | value label ] ].
	self parent classes notEmpty
		ifTrue: [ self renderAddButtonOn: html ]
