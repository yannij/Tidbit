Class {
	#name : #MDLVerifiedPasswordComponent,
	#superclass : #MAVerifiedPasswordComponent,
	#category : 'Tidbit-MDL'
}

{ #category : #rendering }
MDLVerifiedPasswordComponent >> renderEditorOn: html [

	html mdlTextFieldContainer floatingLabel; with: [
		html mdlTextFieldInput
			id: self labelId; type: 'password'; on: #string of: self.
		html mdlTextFieldLabel
			for: self labelId; with: self magritteDescription label.
	].
	html mdlTextFieldContainer floatingLabel; with: [
		html mdlTextFieldInput
			id: self labelId, '-verify'; type: 'password'; on: #verificationString of: self.
		html mdlTextFieldLabel
			for: self labelId, '-verify'; with: '*', self magritteDescription label.
	].

]

{ #category : #rendering }
MDLVerifiedPasswordComponent >> renderViewerOn: html [

	html mdlTextFieldContainer floatingLabel; with: [
		html mdlTextFieldInput
			readonly: true;
			id: self labelId; type: 'password'; on: #string of: self.
		html mdlTextFieldLabel
			for: self labelId; with: self magritteDescription label.
	].

]
