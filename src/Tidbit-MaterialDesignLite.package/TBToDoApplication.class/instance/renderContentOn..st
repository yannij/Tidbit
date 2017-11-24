rendering
renderContentOn: html

	"html text: 'hello'."
	html render: (TBLayoutStructure withConfiguration: {'sideNav' -> true} asDictionary).
