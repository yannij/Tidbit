private
attributeDescriptions

	^self reference children select: [:each | each isVisible]
