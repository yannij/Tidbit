opening
path: aNameString

	| ref |

	ref := (FileSystem disk referenceTo: aNameString) asAbsolute.
	ref isDirectory
		ifFalse: [ ref createDirectory ].
		
	^ref pathString