Class {
	#name : #MDLInternalEditorComponent,
	#superclass : #MAInternalEditorComponent,
	#category : 'Tidbit-MDL'
}

{ #category : #rendering }
MDLInternalEditorComponent >> renderEditorOn: html [

	html mdlGrid with: [ 
		html mdlCell shadow: 2; size: 12;  with: [
			html mdlGrid class: 'mdl-grid--no-spacing'; with: [
				self renderLabelOn: html.
				self renderRelatedObjectOn: html ] ] ]
]

{ #category : #rendering }
MDLInternalEditorComponent >> renderLabelOn: html [

	html mdlCell size: 12; with: [
		html mdlTextFieldContainer floatingLabel; style: 'padding-bottom: 0px'; with: [
			html mdlTextFieldInput
				attributeAt: 'hidden' put: 'true'; style: 'height: 0px';
				id: self labelId; type: 'text'; value: ' '.
			html mdlTextFieldLabel
				for: self labelId; with: self magritteDescription label ] ].

]

{ #category : #rendering }
MDLInternalEditorComponent >> renderRelatedObjectOn: html [

	html mdlCell size: 12; with: [
		self value isNil
			ifTrue: [ self renderSelectListOn: html ]
			ifFalse: [ super renderViewerOn: html; renderButtonsOn: html ] ].

]

{ #category : #rendering }
MDLInternalEditorComponent >> renderViewerChipOn: html [

	self value ifNil: [ ^self ].

	html mdlChip
		with: [ 
			html anchor
				"callback: [ self parent primaryActionOn: self ];"
				with: [
					"html mdlIcon chipIcon with: self chipIconName."
					html mdlChipText with: self value conciseId ] ] 
]

{ #category : #rendering }
MDLInternalEditorComponent >> renderViewerOn: html [

	html mdlGrid class: 'mdl-grid--no-spacing'; with: [ 
		self renderLabelOn: html.

		html mdlCell with: [
			self renderViewerChipOn: html ] ]
]

{ #category : #patch }
MDLInternalEditorComponent >> requiresMultipartForm [
	"Answer true if the receiving component or one of its children requires a multipart form."

	^ self children anySatisfy: [ :each | each notNil and: [ each requiresMultipartForm ] ]
]
