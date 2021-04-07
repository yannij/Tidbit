Class {
	#name : #VOLightningMDBSerializerTest,
	#superclass : #VOJSONSerializerTest,
	#category : 'Voyage-LightningMDB-Tests'
}

{ #category : #private }
VOLightningMDBSerializerTest >> newRepository [
	^ VOLightningMDBRepository new
]
