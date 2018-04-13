rendering
renderViewerOn: html
	| checkboxId |

"true ifTrue: [ ^self ]."

	checkboxId := html nextId.

	html div class: 'mdc-form-field'; with: [
		html div mdcCheckbox; with: [
		html checkbox
			id: checkboxId;
			mdcCheckbox__nativeControl;
			on: #value of: self;
			with: [
html html: '<div class="mdc-checkbox__background">
<svg class="mdc-checkbox__checkmark" viewBox="0 0 24 24">
<path class="mdc-checkbox__checkmark-path" fill="none" stroke="white" d="M1.73,12.91 8.1,19.28 22.79,4.59"></path>
</svg>
<div class="mdc-checkbox__mixedmark"></div></div>'.
					]].
		html label for: checkboxId; with: self magritteDescription checkboxLabel].
