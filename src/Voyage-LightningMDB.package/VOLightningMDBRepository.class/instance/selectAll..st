persistence
selectAll: aClass 
	| selectedValues |

	selectedValues := (self collectionAt: aClass) selectAll.

	^ self 
		materializeSelection: (
			selectedValues select: [:each | | type retrievedClass |
				type := each at: VOLightningMDBJSONMaterializer fieldType.
				retrievedClass := Smalltalk globals at: type asSymbol.
				retrievedClass = aClass or: [ retrievedClass inheritsFrom: aClass persistentClass ]])
		of: aClass