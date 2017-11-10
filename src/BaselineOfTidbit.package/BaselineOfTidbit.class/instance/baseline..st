baselines
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec 
			package: #'Tidbit-Core';
			package: #'Tidbit-Core-Tests'.
		
		spec 
			group: 'default' with: #('core' 'tests');
			group: 'core' with: #('Tidbit-Core');
			group: 'tests' with: #('Tidbit-Core-Tests') ]