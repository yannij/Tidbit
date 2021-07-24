Class {
	#name : #BaselineOfTidbit,
	#superclass : #BaselineOf,
	#category : #BaselineOfTidbit
}

{ #category : #baselines }
BaselineOfTidbit >> baseline: spec [
	<baseline>

	spec for: #common do: [

		"self neoJSON: spec."
		self materialComponentsWeb: spec.
		self voyage: spec.

		spec
			package: 'Tidbit-Core' with: [ spec requires: #('MaterialComponentsWeb' 'Voyage') ];
			package: 'Tidbit-Core-Tests' with: [ spec requires: #('Tidbit-Core') ];
			package: 'Tidbit-MaterialComponentsWeb' with: [ spec requires: #('Tidbit-Core') ].

		spec
			group: 'default' with: #('Tidbit-MaterialComponentsWeb' 'Tidbit-Core-Tests');
			group: 'preload' with: #('Voyage') ]
]

{ #category : #dependencies }
BaselineOfTidbit >> materialComponentsWeb: spec [

	spec
		baseline: 'MaterialComponentsWeb'
		with: [ spec repository: 'github://yannij/MaterialComponentsWeb:master/src';
			loads: #('Responsive' 'Material-Web-Magritte') ].

]

{ #category : #dependencies }
BaselineOfTidbit >> voyage: spec [

	spec
		baseline: 'Voyage'
		with: [ spec repository: 'github://pharo-nosql/voyage:1.7.1/mc';
			loads: #( 'core' 'memory' 'mongo' ) ].

]
