# NOTE: Code moved to Seaside-Quasar, where work will continue

# Tidbit
Web framework using Seaside, Material Components Web, Voyage/Magritte and MongoDB

## License

- The code is licensed under [MIT](LICENSE).
- The documentation is licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).

## Installation

Download the latest [Pharo 32](https://get.pharo.org/) or [64 bits VM](https://get.pharo.org/64/).

Load the code using:
```
Metacello new 
	repository: 'github://yannij/Tidbit/src';
	baseline: 'Tidbit';
	onConflictUseLoaded;
	load.
```
### Start Seaside
1. Open Seaside Control Panel from the Tools menu
1. Add a ZnZincServerAdaptor from the control panel
1. Select the adapter, click on Start button

### Open in a web browser
1. Use a web browser (Chrome, ...)
1. Go to URL: http://localhost:8080/tidbit/todo
