rendering
renderCell: anObject index: anInteger on: html

"self halt."

	html mdlTableCell
		class: self tableDataClass;
		with: [ self renderer valueWithEnoughArguments: (Array with: anObject with: html with: anInteger) ]