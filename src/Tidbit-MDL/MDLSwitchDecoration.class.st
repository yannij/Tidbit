Class {
	#name : #MDLSwitchDecoration,
	#superclass : #MASwitchDecoration,
	#category : 'Tidbit-MDL'
}

{ #category : #rendering }
MDLSwitchDecoration >> renderButtonsOn: html [

	html mdlGrid with: [
		html mdlLayoutSpacer.
		html mdlCell
			style: 'text-align: center';
			size: 8;
			with: [
				self buttons do: [ :each |
					html mdlButton
						raised; colored;
						accessKey: each value first;
						callback: [ self execute: each key ];
						text: each value ]
					separatedBy: [ html space ] ].
		html mdlLayoutSpacer].

]
