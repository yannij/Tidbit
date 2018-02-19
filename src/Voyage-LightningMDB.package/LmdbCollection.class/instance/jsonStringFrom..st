private
jsonStringFrom: anObject
	| stream |

	stream := String new writeStream.

	(NeoJSONWriter on: stream)
		for: DateAndTime customDo: [ :mapping |
			mapping encoder: [ :dateAndTime | dateAndTime printString ] ];
		for: Date customDo: [ :mapping |
			mapping encoder: [ :date | date yyyymmdd ] ];
		for: VOLightningMDBFutureID customDo: [ :mapping |
			mapping encoder: [ :futureID | futureID future repository idOf: futureID future realObject ] ];
		nextPut: anObject;
		yourself.

	^stream contents
