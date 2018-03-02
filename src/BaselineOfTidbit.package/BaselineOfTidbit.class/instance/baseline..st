baselines
baseline: spec
	<baseline>

	spec for: #common do: [

		self neoJSON: spec.
		self voyage: spec.
		self materialDesignLite: spec.
		self magritteSeaside: spec.

		self lightningMDB: spec.

		spec 
			package: 'Voyage-LightningMDB' with: [ spec requires: #('NeoJSON' 'LightningMDB-Core' 'Voyage') ];
			package: 'Voyage-LightningMDB-Tests' with: [ spec requires: #('Voyage-LightningMDB') ];
			package: 'Tidbit-Core' with: [ spec requires: #('MaterialDesignLite' 'MagritteSeaside') ];
			package: 'Tidbit-Core-Tests' with: [ spec requires: #('Tidbit-Core') ];
			package: 'Tidbit-MDL' with: [ spec requires: #('MaterialDesignLite') ];
			package: 'Tidbit-MaterialDesignLite' with: [ spec requires: #('Tidbit-Core' 'Voyage-LightningMDB' 'Tidbit-MDL') ].

		spec 
			group: 'default' with: #('app' 'tests');
			group: 'app' with: #('Tidbit-MaterialDesignLite');
			group: 'tests' with: #('Tidbit-Core-Tests' 'Voyage-LightningMDB-Tests' 'LightningMDB-Tests-Core') ]