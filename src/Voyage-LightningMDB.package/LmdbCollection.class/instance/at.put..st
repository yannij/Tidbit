accessing
at: anId put: jsonDictionary
	"Replaces the contents of document id 'anId' with new contents"
	| dataValue |

	jsonDictionary
		at: VOLightningMDBJSONSerializer fieldId put: anId;
		yourself.
	dataValue := self jsonStringFrom: jsonDictionary.
	Transcript cr; show: 'K: ', anId, ' V: ', dataValue.
	(self database transaction
		put: anId
		data: dataValue
		database: self database database)
