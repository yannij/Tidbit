Class {
	#name : #TBListView,
	#superclass : #TBCollectionView,
	#category : 'Tidbit-MaterialDesignLite'
}

{ #category : #rendering }
TBListView >> renderListItem: anItem on: html [

	html mdlListItem
		threeLine;
		with: [
			html mdlListPrimaryContent
					onClick: ((html jQuery ajax)
						callback: [ self parent primaryActionOn: anItem ];
						onComplete: html javascript refresh);
					with: [
						html mdlIcon listItemIcon; with: anItem chipIconName.
						"html mdlIcon listItemAvatar; with: anItem chipIconName."
						anItem hasDataBadge
							ifTrue: [ html mdlBadge dataBadge: anItem dataBadgeValue; with: anItem mdlDisplayString ]
							ifFalse: [ html text: anItem mdlDisplayString ].
						html mdlListItemTextBody: anItem mdlDisplaySummaryString ].
			html mdlListItemSecondaryAction
				callback: (
					self removeBlock isNil
						ifTrue: [
							[self session presenter removeFromRecentlyViewed: anItem.
							"self session presenter activeScreen objectInstance removeInstance: anItem"] ]
						ifFalse: [
							[self session presenter removeFromRecentlyViewed: anItem.
							[self removeBlock value: anItem] value]]
					);
				with: [ html mdlIcon: #clear ].
			].

]

{ #category : #rendering }
TBListView >> renderListOn: html [
	| list |

	list := html mdlList.
	self flushTop
		ifTrue: [ list style: 'margin-top: 0px' ].

	list
		style: 'width: 360px';
		with: [
			self visible do: [ :each | 
				self renderListItem: each on: html ] ].

]
