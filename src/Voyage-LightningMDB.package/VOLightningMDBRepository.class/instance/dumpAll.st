enumerating
dumpAll
	"Answer all key/value pairs"
	"
	(VOLightningMDBRepository on: 'TidbitExample') dumpAll; close.
	"
	| cursor values assoc |

	values := OrderedCollection new.
	self database beginTransaction.
	cursor := self database transaction openCursor: self database database.
	[(assoc := cursor next) notNil] whileTrue: [
		| key data map |
		key := assoc key dataAsByteString.
		data := assoc value dataAsByteString.
		map := STON fromString: data.
		map at: VOLightningMDBJSONMaterializer fieldId put: key.
		values add: map ].
	self database transaction abort.
	^values inspect