accessing
sizeOf: aBlock
	"Answer all documents that matches aBlock"

	^(self selectAll select: aBlock) size