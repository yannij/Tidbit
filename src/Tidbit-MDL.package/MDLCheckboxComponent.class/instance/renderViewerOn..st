rendering
renderViewerOn: html

	"html text: self magritteDescription label, ':'; space.
	super renderViewerOn: html."

	html mdlCheckboxContainer with: [
		html mdlCheckbox
			id: self labelId;
			disabled: true;
			on: #value of: self.
		html mdlCheckboxLabel
			with: self magritteDescription checkboxLabel ]