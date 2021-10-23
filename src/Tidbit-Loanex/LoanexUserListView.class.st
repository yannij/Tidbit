Class {
	#name : #LoanexUserListView,
	#superclass : #LoanexListView,
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #accessing }
LoanexUserListView >> modelClass [

	^ LoanexUser
]

{ #category : #rendering }
LoanexUserListView >> renderInstancesOn: html [

	self renderTitle: 'Users' on: html.
	self renderAsList: self modelClass selectAll on: html
]
