rendering-buttons
renderSelectButtonOn: html
	"Do nothing - add button is rendered by table widget"
	"super renderSelectButtonOn: html"

	"html mdlButton
		raised; colored;
		value: 'Add';
		onClick: ((html jQuery ajax)
			callback: [ self add ];
			onComplete: html javascript refresh);
		yourself."
