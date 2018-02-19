enumerating
detect: aBlock
	"Answer first document that matches aBlock."

	^(self select: aBlock) 
		ifNotEmpty: [ :result | result first ]
		ifEmpty: [ nil ]