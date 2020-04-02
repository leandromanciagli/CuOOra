Class {
	#name : #Reaccion,
	#superclass : #Object,
	#instVars : [
		'usuario',
		'publicacion',
		'fechaHora',
		'estado'
	],
	#category : #CuOOra
}

{ #category : #initialization }
Reaccion class >> newConUsuario: unUsuario publicacion: unaPublicacion yVoto: unVoto [
	^ self new nuevaReaccionUsuario: unUsuario publicacion: unaPublicacion yVoto: unVoto
]

{ #category : #accessing }
Reaccion >> estado [
	^estado
]

{ #category : #accessing }
Reaccion >> estado: unEstado [
	estado := unEstado
]

{ #category : #initialization }
Reaccion >> initialize [
	fechaHora := DateAndTime today
]

{ #category : #initialization }
Reaccion >> nuevaReaccionUsuario: unUsuario publicacion: unaPublicacion yVoto: unVoto [
	usuario := unUsuario.
	publicacion := unaPublicacion.
	estado := unVoto
]

{ #category : #accessing }
Reaccion >> publicacion [
	^ publicacion
]

{ #category : #accessing }
Reaccion >> usuario [
	^ usuario
]
