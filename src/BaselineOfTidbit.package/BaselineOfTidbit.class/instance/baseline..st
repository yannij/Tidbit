baselines
baseline: spec
	<baseline>

	spec for: #common do: [

		self neoJSON: spec.
		self voyage: spec.
		self materialDesignLite: spec.
		self magritteSeaside: spec.
		self lightningMDB: spec.
		self materialComponentsWeb: spec.

		spec 
			package: 'Voyage-LightningMDB' with: [
				spec requires: #('NeoJSON' 'LightningMDB-Core' 'LightningMDB-Dictionary' 'Voyage') ];
			package: 'Voyage-LightningMDB-Tests' with: [
				spec requires: #('Voyage-LightningMDB' 'LightningMDB-Tests-Core' 'LightningMDB-Tests-Dictionary') ];
			package: 'Tidbit-Core' with: [ spec requires: #('MaterialDesignLite' 'MagritteSeaside') ];
			package: 'Tidbit-Core-Tests' with: [ spec requires: #('Tidbit-Core') ];
			package: 'Tidbit-MaterialComponentsWeb' with: [ spec requires: #('Tidbit-Core' 'Voyage-LightningMDB' 'MaterialComponentsWeb') ];
			package: 'Tidbit-MDL' with: [ spec requires: #('MaterialDesignLite') ];
			package: 'Tidbit-MaterialDesignLite' with: [ spec requires: #('Tidbit-Core' 'Tidbit-MDL') ].

		spec 
			group: 'default' with: #('app' 'tests');
			group: 'app' with: #('Tidbit-MaterialDesignLite' 'Tidbit-MaterialComponentsWeb');
			group: 'tests' with: #('Tidbit-Core-Tests' 'Voyage-LightningMDB-Tests') ]