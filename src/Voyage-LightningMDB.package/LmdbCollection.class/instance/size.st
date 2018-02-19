accessing
size
	"Answer the size of current collection (# of records)"
	| count |

	count := nil.
	self database beginTransaction.
	count := (self database transaction stat: self database database) entries.
	self database transaction abort.
	^count