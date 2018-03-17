accessing
style
	^ '
/* Ensure layout covers the entire screen. */
html {
  height: 60%;
}

/* Place drawer and content side by side. */
.body-tablet {
  display: flex;
  flex-direction: row;
  padding: 0;
  margin: 0;
  box-sizing: border-box;
  min-height: 100%;
  width: 100%;
}
/* Place drawer and content side by side. */
.body-desktop {
  display: flex;
  flex-flow: row nowrap;
  padding: 0;
  margin: 0;
  box-sizing: border-box;
  min-height: 100%;
  width: 100%;
}
'