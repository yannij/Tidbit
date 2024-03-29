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
		self quasar: spec.
		self voyage: spec.

		spec
			package: 'Tidbit-ToDo' with: [ spec requires: #('MaterialComponentsWeb' 'Voyage') ];
			package: 'Tidbit-Loanex' with: [ spec requires: #('MaterialComponentsWeb' 'Voyage') ].

		spec
			group: 'default' with: #('Tidbit-ToDo' 'Tidbit-Loanex');
			group: 'preload' with: #('Voyage') ]
]

{ #category : #dependencies }
BaselineOfTidbit >> quasar: spec [

	spec
		baseline: 'MaterialComponentsWeb'
		with: [ spec repository: 'github://yannij/MaterialComponentsWeb:master/src';
			loads: #('Quasar-Demo') ]
]

{ #category : #dependencies }
BaselineOfTidbit >> voyage: spec [

	spec
		baseline: 'Voyage'
		with: [ spec repository: 'github://pharo-nosql/voyage:1.7.1/mc';
			loads: #( 'core' 'memory' 'mongo' ) ].

]
