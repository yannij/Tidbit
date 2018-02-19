sorting
sortAtRow: aRowIndex using: aSelector
	| attributeDescription |

	header do: [ :each | 
		(header at: aRowIndex) = each ifFalse: [ each unsort ] ].

	attributeDescription := self attributeDescriptions at: aRowIndex.
	rows := self rows
		sorted: [ :cell :anotherCell | | a b |
			a := cell readUsing: attributeDescription.
			b := anotherCell readUsing: attributeDescription.
			[ a perform: aSelector with: b ]
				on: MessageNotUnderstood "If the element does not implements the comparators then I should not sort them."
				do: [ true ]	 ]