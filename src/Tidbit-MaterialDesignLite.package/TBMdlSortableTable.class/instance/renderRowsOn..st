rendering
renderRowsOn: html
	| instanceSubset |

	instanceSubset := (position to: (self rows size min: position + elementsToShow)) collect: [ :rowIndex | self rows at: rowIndex ].

	instanceSubset
		do: [ :each | | cells |
			cells := self attributeDescriptions collect: [:eachAttribute | eachAttribute displayStringFor: (each readUsing: eachAttribute) ].
			html tableRow
				onClick: ((html jQuery ajax)
						callback: [ self parent primaryActionOn: each ];
						onComplete: html javascript refresh);
				with: [ self renderRowContentFor: cells on: html ] ]