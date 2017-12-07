# Tidbit
Web framework using Seaside, MDL, Magritte and LMDB

### Use a fresh Pharo image (6.1 64-bit), and load the code using:
```
Metacello new
    githubUser: 'yannij' project: 'Tidbit' commitish: 'master' path: 'src';
    baseline: 'Tidbit';
    onWarningLog;
    load.
```
### Start Seaside
1. Open Seaside Control Panel from the Tools menu
1. Add a ZnZincServerAdaptor from the control panel
1. Select the adapter, click on Start button

### Open in a web browser
1. Use a web browser (Chrome, ...)
1. Go to URL: http://localhost:8080/tidbit-todo
