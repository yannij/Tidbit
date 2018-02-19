persistence
count: aClass
	"TODO: Find faster way"
	^(self selectAll: aClass) size
	"^ (self collectionAt: aClass) size "