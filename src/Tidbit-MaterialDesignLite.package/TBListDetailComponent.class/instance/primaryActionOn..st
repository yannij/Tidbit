actions
primaryActionOn: aModel

	"self session presenter addToRecent: aModel"
	self root show: (aModel asComponent addValidatedForm; yourself)

	"| component modelDescription |

	modelDescription := aModel magritteDescription.
	component := (modelDescription select: [:each | each viewStructure not]) asComponentOn: aModel.

	self detailComponent: component"