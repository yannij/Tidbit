Class {
	#name : #VOLightningMDBLazyProxy,
	#superclass : #VOLazyProxy,
	#category : 'Voyage-LightningMDB'
}

{ #category : #private }
VOLightningMDBLazyProxy >> obtainRealObject [
	^ repository selectOne: objectClass id: objectId
	
]
