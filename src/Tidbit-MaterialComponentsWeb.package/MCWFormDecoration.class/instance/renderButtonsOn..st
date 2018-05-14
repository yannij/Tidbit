rendering
renderButtonsOn: html

'
mdc-ripple-surface mdc-ripple-upgraded--unbounded mdc-ripple-upgraded" tabindex="0" 
role="button" 
data-mdc-ripple-is-unbounded="" 
title="Share" 
style="--mdc-ripple-fg-size:28.8px; --mdc-ripple-fg-scale:1.66667; --mdc-ripple-left:10px; --mdc-ripple-top:10px;"
'.
	html div mdcCard__actions; with: [
		html html: '<div class="mdc-card__action-buttons">
              <button class="mdc-button mdc-card__action mdc-card__action--button mdc-ripple-upgraded" style="--mdc-ripple-fg-size:39.6938px; --mdc-ripple-fg-scale:2.14938; --mdc-ripple-fg-translate-start:25.4301px, -1.61689px; --mdc-ripple-fg-translate-end:13.2312px, -1.84688px;">Read</button>
              <button class="mdc-button mdc-card__action mdc-card__action--button mdc-ripple-upgraded">Bookmark</button>
            </div>'.
		"html div mdcCard__actionButtons; with: [
			html button
				mdcCard__action;
				mdcCard__action_button;
				callback: [self execute: #save];
				with: 'done']."
		html div mdcCard__actionIcons; with: [
			html span
				mdcMaterialIcons;
				mdcCard__action;
				mdcCard__actionIcon;
				"callback: [self execute: #save];"
				onClick: ((html jQuery ajax)
					callback: [self execute: #save];
					onComplete: html javascript refresh);
				with: 'done'.
			html anchor
				mdcMaterialIcons;
				mdcCard__action;
				mdcCard__actionIcon;
				"onClick: ((html jQuery ajax)
					callback: [self cancel];
					onComplete: html javascript refresh);"
				callback: [self execute: #cancel];
				with: 'cancel'.
			]]
