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
			package: 'Tidbit-Core' with: [ spec requires: #('Voyage' 'MaterialComponentsWeb') ];
			package: 'Tidbit-Core-Tests' with: [ spec requires: #('Tidbit-Core') ];
			package: 'Tidbit-MaterialComponentsWeb' with: [ spec requires: #('Tidbit-Core') ].

		spec
			group: 'default' with: #('Tidbit-MaterialComponentsWeb' 'Tidbit-Core-Tests');
			group: 'preload' with: #('Voyage') ]
]

{ #category : #dependencies }
BaselineOfTidbit >> lightningMDB: spec [

	spec
		package: 'LightningMDB-Core' with: [ 
			spec 
				repository: 'http://smalltalkhub.com/mc/JanVanDeSandt/LightningMDB/main' ].
	spec
		package: 'LightningMDB-Tests-Core' with: [ 
			spec 
				repository: 'http://smalltalkhub.com/mc/JanVanDeSandt/LightningMDB/main' ].
	spec
		package: 'LightningMDB-Dictionary' with: [ 
			spec 
				repository: 'http://smalltalkhub.com/mc/JanVanDeSandt/LightningMDB/main' ].
	spec
		package: 'LightningMDB-Tests-Dictionary' with: [ 
			spec 
				repository: 'http://smalltalkhub.com/mc/JanVanDeSandt/LightningMDB/main' ].

	"spec
		project: 'LightningMDB'
		with: [ 
			spec
				className: 'ConfigurationOfLightningMDB';
				version: 'release3.5';
				repository: 'http://smalltalkhub.com/mc/JanVanDeSandt/LightningMDB/main' ]."

]

{ #category : #dependencies }
BaselineOfTidbit >> materialComponentsWeb: spec [

	spec
		baseline: 'MaterialComponentsWeb'
		with: [ spec repository: 'github://yannij/MaterialComponentsWeb:master/src';
			loads: #( 'default' )  ].

]

{ #category : #dependencies }
BaselineOfTidbit >> materialDesignLite: spec [

	spec
		baseline: 'MaterialDesignLite'
		with: [ spec repository: 'github://DuneSt/MaterialDesignLite:v1.1.0/src' ].

]

{ #category : #dependencies }
BaselineOfTidbit >> neoJSON: spec [

	spec
		baseline: 'NeoJSON'
		with: [ spec repository: 'github://svenvc/NeoJSON:17/repository' ].

]

{ #category : #dependencies }
BaselineOfTidbit >> voyage: spec [

	spec
		baseline: 'Voyage'
		with: [ spec repository: 'github://pharo-nosql/voyage:1.7.1/mc';
			loads: #( 'core' 'memory' 'mongo' ) ].

]
