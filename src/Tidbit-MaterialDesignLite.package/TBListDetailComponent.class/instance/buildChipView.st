private
buildChipView

	^(TBChipView rows: self value description: self reference)
		parent: self;
		removeBlock: [:arg | self remove: arg ];
		sortEnabled: self magritteDescription isOrdered not;
		flushTop: true;
		yourself