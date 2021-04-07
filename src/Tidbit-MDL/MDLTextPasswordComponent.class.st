Class {
	#name : #MDLTextPasswordComponent,
	#superclass : #MATextPasswordComponent,
	#category : 'Tidbit-MDL'
}

{ #category : #rendering }
MDLTextPasswordComponent >> renderEditorOn: html [

	self renderElementOn: html readonly: false

]

{ #category : #rendering }
MDLTextPasswordComponent >> renderElementOn: html readonly: flag [

	html mdlTextFieldContainer floatingLabel; with: [
		html mdlTextFieldInput
			readonly: flag;
			id: self labelId; type: 'password'; on: #string of: self.
		html mdlTextFieldLabel
			for: self labelId; with: self magritteDescription label.
	].

]

{ #category : #rendering }
MDLTextPasswordComponent >> renderViewerOn: html [

	self renderElementOn: html readonly: true


]
