accessing
descriptionContainerClass
	"
	self descriptionContainerClass: MCWPriorityContainer.
	self descriptionContainerClass: MDLPriorityContainer.
	"

	DescriptionContainerClass isNil
		ifTrue: [DescriptionContainerClass := MCWPriorityContainer].
	^DescriptionContainerClass
