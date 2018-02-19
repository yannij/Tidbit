rendering
renderListOn: html

	self visible
		do: [ :each | self renderChip: each on: html ]
		separatedBy: [ html space ].
