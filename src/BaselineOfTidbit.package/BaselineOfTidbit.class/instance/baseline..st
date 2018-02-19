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
			package: 'Tidbit-Core' with: [ spec requires: #('NeoJSON' 'LightningMDB-Core' "'Voyage'" 'MaterialDesignLite' 'MagritteSeaside') ];
			package: 'Tidbit-Core-Tests' with: [ spec requires: #('Tidbit-Core') ];
			package: 'Tidbit-MaterialDesignLite' with: [ spec requires: #('Tidbit-Core' 'MaterialDesignLite') ].

		spec 
			group: 'default' with: #('core' 'tests');
			group: 'core' with: #('Tidbit-MaterialDesignLite');
			group: 'tests' with: #('Tidbit-Core-Tests') ]