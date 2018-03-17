rendering
renderContentOn: html

	html aside
		id: self id;
		class: 'mdc-drawer'; class: self mdcDrawerType; class: 'demo-drawer'; with: [
		html navigation
			attributeAt: 'dir' put: self dir;
			class: 'mdc-drawer__drawer';
			onClick: (JSScript new add: (JSStream new
				nextPutAll: '
var activatedClass = ''mdc-list-item--selected'';
var el = event.target;
while (el && !el.classList.contains(''mdc-list-item'')) {
	el = el.parentElement;
}
if (el) {
	var activatedItem = document.querySelector(''.'' + activatedClass);
	if (activatedItem) {
		activatedItem.classList.remove(activatedClass);
	}
	event.target.classList.add(activatedClass);
}'));
			with: [
			"html div class: 'mdc-drawer__toolbar-spacer'."
			html div class: 'mdc-list-group'; with: [
				self renderList: self list selectedIndex: 1 on: html]]].
