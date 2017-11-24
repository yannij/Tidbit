rendering
renderRightNavDivOn: html
	| divId |

	divId := html nextId.
	html div
		style: 'text-align: left; display:flex;height: 600px; background-color: #CFD8DC;';
		shadow: 2;
		with: [ 
			html render:
				((MDLNestedList
					elements: self rightNavLinks
					children: [:ignored |  #() ])
					format: #key;
					actionBlock: [:element | element value value ]
					yourself).
			html div id: divId ]