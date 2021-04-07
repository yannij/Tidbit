Class {
	#name : #MDLTextAreaComponent,
	#superclass : #MATextAreaComponent,
	#category : 'Tidbit-MDL'
}

{ #category : #rendering }
MDLTextAreaComponent >> renderEditorOn: html [

	self renderElement: false on: html

]

{ #category : #rendering }
MDLTextAreaComponent >> renderElement: flag on: html [

	html mdlTextFieldContainer
		beFloatingLabelIf: true;
		beExpandableIf: true;
		with: [
		html mdlTextArea
			id: self labelId;
			rows: self magritteDescription lineCount;
			columns: 80;
			readonly: flag;
			on: #string of: self.

		html mdlTextFieldLabel
			for: self labelId; with: self magritteDescription label.
	].

]

{ #category : #rendering }
MDLTextAreaComponent >> renderViewerOn: html [

	"html text: self magritteDescription label, ':'; space."
	"super renderViewerOn: html."

	self renderElement: true on: html

]
