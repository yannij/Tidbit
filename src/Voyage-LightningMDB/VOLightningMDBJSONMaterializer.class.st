Class {
	#name : #VOLightningMDBJSONMaterializer,
	#superclass : #VOJSONMaterializer,
	#category : 'Voyage-LightningMDB'
}

{ #category : #private }
VOLightningMDBJSONMaterializer >> obtainReferenceOf: objectClass id: anId [
	^ self repository 
		selectOne: objectClass 
		id: anId			
]

{ #category : #visiting }
VOLightningMDBJSONMaterializer >> visitDateAndTimeDescription: anObject [
	self visitMagnitudeDescription: anObject
]

{ #category : #visiting }
VOLightningMDBJSONMaterializer >> visitDateDescription: anObject [
	self visitMagnitudeDescription: anObject
]
