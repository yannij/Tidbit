tests
testSaveSimple
	| pilot pilots |

	pilot := VOTestPilot new
		name: 'Esteban';
		"pet: (VOTestDog new name: 'Doggie');"
		yourself.
	self repository save: pilot.
	self waitForWriteOperation.

	pilots := self repository selectAll: VOTestPilot.
	self assert: pilots size equals: 1.
	self assert: pilots anyOne name equals: 'Esteban'.
