Class {
	#name : #MDLExternalEditorComponent,
	#superclass : #MAExternalEditorComponent,
	#category : 'Tidbit-MDL'
}

{ #category : #rendering }
MDLExternalEditorComponent >> renderChipOn: html [

	self value ifNil: [ ^self ].

	html mdlChip
		"deleteCallback: [
					self removeBlock isNil
						ifTrue: [
							[ self parent remove: self ] ]
						ifFalse: [
							[self session presenter removeFromRecentlyViewed: self.
							[self removeBlock value: self] value]]
			];"
		with: [ 
			html anchor
				"callback: [ self parent primaryActionOn: self ];"
				with: [
					"html mdlIcon chipIcon with: self chipIconName."
					html mdlChipText with: self value conciseId ] ] 
]

{ #category : #rendering }
MDLExternalEditorComponent >> renderEditorOn: html [

	"super renderEditorOn: html."

	html mdlGrid "class: 'mdl-grid--no-spacing';" with: [ 
		html mdlCell shadow: 2; size: 12; with: [
			super renderEditorOn: html ]].

]

{ #category : #rendering }
MDLExternalEditorComponent >> renderLabelOn: html [

	html mdlCell size: 12; with: [
		html mdlTextFieldContainer floatingLabel; style: 'padding-bottom: 0px'; with: [
			html mdlTextFieldInput
				attributeAt: 'hidden' put: 'true'; style: 'height: 0px';
				id: self labelId; type: 'text'; value: ' '.
			html mdlTextFieldLabel
				for: self labelId; with: self magritteDescription label ] ].

]

{ #category : #rendering }
MDLExternalEditorComponent >> renderRelatedObjectOn: html [

	html mdlCell size: 12; with: [
		self renderChipOn: html ].

]

{ #category : #rendering }
MDLExternalEditorComponent >> renderViewerOn: html [

	html mdlGrid class: 'mdl-grid--no-spacing'; with: [ 
		self renderLabelOn: html.
		self renderRelatedObjectOn: html ]
]
