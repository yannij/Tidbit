private
buildChildren

	self magritteDescription
		componentClass: MDLContainerComponent;
		do: [:eachChild | eachChild componentClass: eachChild mdlComponentClass].

	^ self magritteDescription
		inject: Dictionary new
		into: [ :result :each |
			each isVisible ifTrue: [
				result at: each put: (each componentClass
					memento: self memento description: each parent: self) ].
			result ]