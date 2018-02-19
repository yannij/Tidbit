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
			package: 'Tidbit-Core' with: [ spec requires: #('MaterialDesignLite' 'MagritteSeaside') ];
			package: 'Tidbit-Core-Tests' with: [ spec requires: #('Tidbit-Core') ];
			package: 'Tidbit-MaterialDesignLite' with: [ spec requires: #('Tidbit-Core' 'Voyage-LightningMDB' 'MaterialDesignLite') ].

		spec 
			group: 'default' with: #('core' 'tests');
			group: 'core' with: #('Tidbit-MaterialDesignLite');
			group: 'tests' with: #('Tidbit-Core-Tests') ]