accessing
descriptionContainer
	"Return the default description container."
	<magritteContainer>
	^ MDLPriorityContainer new
		label: self class label;
		yourself