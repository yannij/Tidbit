rendering
renderAppBarOn: html
	| toolbar |

	toolbar := MCWToolbar new
		title: 'App bar / primary toolbar';
		startSection: {
			#('Menu' 'menu').
		};
		endSection: {
			#('Download' 'file_download').
			#('Print this page' 'print').
			#('Bookmark this page' 'bookmark')
		};
		yourself.

	html render: toolbar.
