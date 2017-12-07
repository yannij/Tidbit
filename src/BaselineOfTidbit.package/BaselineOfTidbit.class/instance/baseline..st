baselines
baseline: spec
	<baseline>

	spec for: #common do: [
		spec 
			package: 'Tidbit-MaterialDesignLite';
			package: 'Tidbit-Core' with: [ spec requires: #('Tidbit-MaterialDesignLite' 'MagritteSeaside') ];
			package: 'Tidbit-Core-Tests' with: [ spec requires: #('Tidbit-Core') ].

		spec
			baseline: 'MaterialDesignLite'
			with: [ spec repository: 'github://DuneSt/RMaterialDesignLite:v1.1.0' ].

		spec
         project: 'MagritteSeaside'
         with: [ 
            spec
               className: 'ConfigurationOfMagritteSeaside';
               version: 'stable';
               repository:
                  'http://smalltalkhub.com/mc/Magritte/Magritte3/main' ].

		spec 
			group: 'default' with: #('core' 'tests');
			group: 'core' with: #('Tidbit-Core');
			group: 'tests' with: #('Tidbit-Core-Tests') ]