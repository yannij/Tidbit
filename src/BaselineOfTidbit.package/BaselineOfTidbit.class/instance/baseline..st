baselines
baseline: spec
	<baseline>

	spec for: #common do: [

		self materialDesignLite: spec.
		self magritteSeaside: spec.
		self neoJSON: spec.

		spec 
			package: 'Tidbit-Core' with: [ spec requires: #('MagritteSeaside' 'NeoJSON') ];
			package: 'Tidbit-Core-Tests' with: [ spec requires: #('Tidbit-Core') ];
			package: 'Tidbit-MaterialDesignLite' with: [ spec requires: #('Tidbit-Core' 'MaterialDesignLite') ].

		spec 
			group: 'default' with: #('core' 'tests');
			group: 'core' with: #('Tidbit-Core');
			group: 'tests' with: #('Tidbit-Core-Tests') ]