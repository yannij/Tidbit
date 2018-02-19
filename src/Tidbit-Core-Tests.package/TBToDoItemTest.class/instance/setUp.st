running
setUp
	| env tx dbi |

	repository := VOLightningMDBRepository on: 'TidbitTest'.
	env := self repository database environment.
	
	tx := env beginTransaction.
	dbi := tx openDatabase: nil.
	tx empty: dbi.
	tx commit.
