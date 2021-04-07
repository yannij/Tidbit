Class {
	#name : #VOLightningMDBMaterializerTest,
	#superclass : #VOJSONMaterializerTest,
	#category : 'Voyage-LightningMDB-Tests'
}

{ #category : #private }
VOLightningMDBMaterializerTest >> newRepository [
	^ VOLightningMDBRepository new
]
