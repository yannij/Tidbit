actions
primaryActionOn: aModel

	self session presenter addToRecent: aModel

	"| component modelDescription |

	modelDescription := aModel magritteDescription.
	component := (modelDescription select: [:each | each viewStructure not]) asComponentOn: aModel.

	self detailComponent: component"