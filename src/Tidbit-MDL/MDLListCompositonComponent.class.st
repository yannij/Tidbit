Class {
	#name : #MDLListCompositonComponent,
	#superclass : #MAListCompositonComponent,
	#category : 'Tidbit-MDL'
}

{ #category : #rendering }
MDLListCompositonComponent >> renderEditorOn: html [

	html text: self magritteDescription label, ':'; space.
	super renderEditorOn: html.

]

{ #category : #rendering }
MDLListCompositonComponent >> renderViewerOn: html [

	html text: self magritteDescription label, ':'; space.
	super renderViewerOn: html.

]
