Class {
	#name : #Reaccion,
	#superclass : #Object,
	#instVars : [
		'usuario',
		'publicacion',
		'fechaHora'
	],
	#category : #CuOOra
}

{ #category : #initialization }
Reaccion class >> newConUsuario: unUsuario yPublicacion: unaPublicacion [
	^ self newConUsuario: unUsuario yPublicacion: unaPublicacion
]

{ #category : #initialization }
Reaccion >> initialize [
	fechaHora := DateAndTime today
]

{ #category : #initialization }
Reaccion >> newConUsuario: unUsuario yPublicacion: unaPublicacion [
	usuario := unUsuario.
	publicacion := unaPublicacion
]

{ #category : #accessing }
Reaccion >> publicacion [
	^ publicacion
]

{ #category : #accessing }
Reaccion >> usuario [
	^ usuario
]
