initalize
buildTestDatabase
	"
	self repositoryClear.
	self buildTestDatabase.
	"
	| userModel |

	userModel := TBUser new
		userId: 'testuser';
		firstName: 'Test';
		lastName: 'User';
		yourself.

	userModel toDoItems
		addAll: {
			TBToDoItem new description: 'todo-1'; priority: 1; yourself.
			TBToDoItem new description: 'todo-2'; priority: 2; yourself.
			TBToDoItem new description: 'todo-3'; priority: 3; yourself.
			TBToDoItem new description: 'todo-4'; priority: 4; yourself.
			}.

	self repository save: userModel.

	^userModel
