dependencies
lightningMDB: spec

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
