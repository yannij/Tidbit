Class {
	#name : #LoanexToyFilterView,
	#superclass : #LoanexFilterView,
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #rendering }
LoanexToyFilterView >> renderContentOn: html [

	self renderRefreshOn: html.
	self renderFilterRadioButtonsOn: html.
	self renderFilterOwnerOn: html
]

{ #category : #rendering }
LoanexToyFilterView >> renderFilterOwnerOn: html [

	self renderFieldLabel: 'Owner' on: html.

	html textInput
		onBlur: ((html jQuery ajax) callback: [ :value | self toyOwner: value ] value: (html jQuery this value));
		with: self toyOwner
]

{ #category : #rendering }
LoanexToyFilterView >> renderFilterRadioButtonsOn: html [
	| formId group |

	self renderFieldLabel: 'Availability' on: html.

	formId := html nextId.
	html form id: formId; with: [
	group := html radioGroup.
	{#both->'Both'. #availableOnly->'Available Only'. #notAvailableOnly->'Not Available Only'}
		do: [ :each | | optionId |
			optionId := html nextId.
			html div mdcFormField; style: 'width: 200px'; mdcAutoInit: 'MDCFormField'; with: [
				html div mdcRadio; mdcAutoInit: 'MDCRadio'; with: [
					html radioButton mdcRadio__nativeControl; id: optionId; group: group;
						selected: self toyAvailable = each key;
						callback: [ self toyAvailable: each key ];
						onChange: (html jQuery ajax script: [ :s | s << (s jQuery id: formId) call: 'submit' ]);
						yourself.
					html div mdcRadio__background; with: [
						html div mdcRadio__outerCircle.
						html div mdcRadio__innerCircle ].
					html div mdcRadio__ripple ].
				html label for: optionId; with: each value ] ]
		separatedBy: [ html break ] ]
]

{ #category : #accessing }
LoanexToyFilterView >> toyAvailable [

	^ self mdqApplicationGet filterValues toyAvailable
]

{ #category : #accessing }
LoanexToyFilterView >> toyAvailable: anObject [

	self mdqApplicationGet filterValues toyAvailable: anObject
]

{ #category : #accessing }
LoanexToyFilterView >> toyOwner [

	^ self mdqApplicationGet filterValues toyOwner
]

{ #category : #accessing }
LoanexToyFilterView >> toyOwner: anObject [

	self mdqApplicationGet filterValues toyOwner: anObject
]
