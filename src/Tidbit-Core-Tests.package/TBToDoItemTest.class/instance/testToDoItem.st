tests
testToDoItem
	| item |

	item := TBToDoItem new
		description: 'abcd';
		yourself.

	self repository save: item.
