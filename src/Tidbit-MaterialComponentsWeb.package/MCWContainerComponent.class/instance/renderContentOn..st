rendering
renderContentOn: html

	| width |

	width := self magritteDescription propertyAt: #cardWidth ifAbsent: [300].

	html div
		mdcCard;
		style: 'padding: 16px';
		style: 'width: ', width printString, 'px';
		with: [
			super renderContentOn: html]
