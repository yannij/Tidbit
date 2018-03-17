initialization
buildAppBar

	^MCWToolbar new
		title: 'App bar / primary toolbar';
		startSection: {
			#('Menu' 'menu').
		};
		endSection: {
			#('Download' 'file_download').
			#('Print this page' 'print').
			"#('Bookmark this page' 'bookmark')."
			#('Right Nav' 'more_horiz').
		};
		yourself.
