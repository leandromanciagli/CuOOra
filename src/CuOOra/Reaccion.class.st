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
Reaccion class >> nuevaDelUsuario: unUsuario aPublicacion: unaPublicacion conVoto: unVoto [
	^ self new nuevaDelUsuario: unUsuario aPublicacion: unaPublicacion conVoto: unVoto
]

{ #category : #deleting }
Reaccion >> borrarPublicacion [
	publicacion := nil
]

{ #category : #accessing }
Reaccion >> estado [
	^ estado
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
Reaccion >> nuevaDelUsuario: unUsuario aPublicacion: unaPublicacion conVoto: unVoto [
	usuario := unUsuario.
	publicacion := unaPublicacion.
	estado := unVoto
]

{ #category : #accessing }
Reaccion >> usuario [
	^ usuario
]
