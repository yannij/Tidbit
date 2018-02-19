accessing
at: anId
	"retrieves a documents with id or nil if not found"

	^(self select: [:each | (each at: VOLightningMDBJSONSerializer fieldId) = anId ]) 
		ifNotEmpty: [ :result | result first ]
		ifEmpty: [ nil ]
