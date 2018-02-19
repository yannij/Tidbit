actions
add

	self root 
		show: (self validatedFormOn: (self selected new))
		onAnswer: [ :result |
			result isNil
				ifFalse: [
					self value: (self value copyWith: result).
					self parent save.
					self session presenter saveObject: self parent model.
					self refresh ] ]
