rendering
renderViewerOn: html
	| switchId listId |

	switchId := html nextId.
	listId := html nextId.

	html div style: 'display: inline-block; padding-left: 16px'; with: [
	html div
		mdcSwitch;
		with: [
			html checkbox
				mdcSwitch__nativeControl;
				id: switchId;
				value: false;
				onChange: (html jQuery ajax
					callback: [ :value | self expanded: value = 'true' ] value: (JSStream on: 'event.target.checked');
					onComplete: ((html jQuery id: listId) load html: [:renderer | self renderListAjaxOn: renderer]));
				yourself.
			html div mdcSwitch__background; with: [html div mdcSwitch__knob]].
			html space; space; space.
			html label for: switchId; mdcSwitchLabel; with: self magritteDescription label.
			self renderAddButtonOn: html.
	].

	html div id: listId; with: [self renderListAjaxOn: html]