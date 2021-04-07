Class {
	#name : #MDLCheckboxComponent,
	#superclass : #MACheckboxComponent,
	#category : 'Tidbit-MDL'
}

{ #category : #rendering }
MDLCheckboxComponent >> renderEditorOn: html [

	html mdlCheckboxContainer with: [
		html mdlCheckbox
			id: self labelId;
			on: #value of: self.
		html mdlCheckboxLabel: self magritteDescription checkboxLabel ]
]

{ #category : #rendering }
MDLCheckboxComponent >> renderViewerOn: html [

	"html text: self magritteDescription label, ':'; space.
	super renderViewerOn: html."

	html mdlCheckboxContainer with: [
		html mdlCheckbox
			id: self labelId;
			disabled: true;
			on: #value of: self.
		html mdlCheckboxLabel
			with: self magritteDescription checkboxLabel ]
]
