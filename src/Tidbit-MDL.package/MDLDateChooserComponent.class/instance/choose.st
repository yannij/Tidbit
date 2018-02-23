rendering
choose
	| calendar |
	calendar := MDLCalendarWidget new.
	calendar
		"currentDate: ((self value notNil
			and: [ self magritteDescription isSatisfiedBy: self value ])
				ifFalse: [ Date current ]
				ifTrue: [ self value ]);"
		"selectBlock: [ :value | calendar answer: value ];"
		"canSelectBlock: [ :value | self magritteDescription isSatisfiedBy: value ];"
		callback: [ :value | self value: value. self answer ];
		yourself.
	self chooser: calendar