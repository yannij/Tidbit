# Tidbit
Web framework using Seaside, Material Components Web, Magritte and LMDB
### WARNING ! ! !
This code is under development. Stuff may not work.

### Prerequisites
Pharo 6.1 - 64-bit VM & image
LMDB installed in Pharo VM Plugins (on MacOSX build liblmdb.a, rename to liblmdb.dylib, and copy to Pharo.app/Contents/MacOS/Plugins)

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
1. Go to URL: http://localhost:8080/tidbit/todo
