private
buildReport

	"self viewStyle = #list ifTrue: [^self buildMdlListReport]."
	self viewStyle = #table ifTrue: [^self buildMdlTableReport].
	self viewStyle = #grid ifTrue: [^self buildGridView].
	self viewStyle = #chip ifTrue: [^self buildChipView].

	^self buildMdlListReport
