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
			package: 'Tidbit-ToDo' with: [ spec requires: #('Quasar-Magritte' 'MaterialComponentsWeb' 'Voyage') ];
			package: 'Tidbit-Loanex' with: [ spec requires: #('Quasar-Magritte' 'MaterialComponentsWeb' 'Voyage') ].

		spec
			group: 'default' with: #('Tidbit-ToDo' 'Tidbit-Loanex');
			group: 'preload' with: #('Voyage') ]
]

{ #category : #dependencies }
BaselineOfTidbit >> materialComponentsWeb: spec [

	spec
		baseline: 'MaterialComponentsWeb'
		with: [ spec repository: 'github://yannij/MaterialComponentsWeb:master/src';
			loads: #('Material-Web-Responsive' 'Material-Web-Magritte') ].

]

{ #category : #dependencies }
BaselineOfTidbit >> voyage: spec [

	spec
		baseline: 'Voyage'
		with: [ spec repository: 'github://pharo-nosql/voyage:1.7.1/mc';
			loads: #( 'core' 'memory' 'mongo' ) ].

]
