accessing
style
	^ '      /* Ensure layout covers the entire screen. */
      html {
        height: 100%;
      }

      /* Place drawer and content side by side. */
      .demo-body {
        display: flex;
        flex-direction: row;
        padding: 0;
        margin: 0;
        box-sizing: border-box;
        min-height: 100%;
        width: 100%;
      }

      /* Stack toolbar and main on top of each other. */
      .demo-content {
        display: inline-flex;
        flex-direction: column;
        flex-grow: 1;
        height: 100%;
        box-sizing: border-box;
      }

      /* Place drawer above toolbar shadow. */
      .mdc-drawer--permanent {
        z-index: 2;
      }

      .demo-main {
        padding-left: 16px;
        padding-right: 16px;
      }

      #extra-wide-content {
        width: 200vw;
      }

      #extra-tall-content {
        height: 50vh;
      }
'