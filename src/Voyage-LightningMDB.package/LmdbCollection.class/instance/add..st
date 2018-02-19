adding
add: jsonDictionary
	"Adds a JSON dictionary to collection. 
	 Answers the id of the record inserted"

	| newId dataValue |
	newId := UUIDGenerator next printString.
	jsonDictionary
		at: VOLightningMDBJSONSerializer fieldId put: newId;
		yourself.
	dataValue := self jsonStringFrom: jsonDictionary.
	Transcript cr; show: 'K: ', newId, ' V: ', dataValue.
	(self database transaction
		put: "self name," newId
		data: (self jsonStringFrom: jsonDictionary)
		database: self database database)
			"commit".
	^newId