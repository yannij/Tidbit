running
setUp
	| env tx dbi |

	repository := VOLightningMDBRepository on: 'FOO1'.

	"env := MDBEnvironment create."
	env := self repository database environment.
	"env open: self path."
	
	tx := env beginTransaction.
	dbi := tx openDatabase: nil.
	tx empty: dbi.
	tx commit.
