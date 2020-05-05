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
	^ self new inicializarDelUsuario: unUsuario aPublicacion: unaPublicacion conVoto: unVoto
]

{ #category : #deleting }
Reaccion >> borrarPublicacion [
	publicacion := nil
]

{ #category : #accessing }
Reaccion >> dislike [
	estado := false.
]

{ #category : #accessing }
Reaccion >> estado [
	^ estado
]

{ #category : #initialization }
Reaccion >> inicializarDelUsuario: unUsuario aPublicacion: unaPublicacion conVoto: unVoto [
	usuario := unUsuario.
	publicacion := unaPublicacion.
	estado := unVoto
]

{ #category : #initialization }
Reaccion >> initialize [
	estado  := true.
	fechaHora := DateAndTime today
]

{ #category : #accessing }
Reaccion >> like [
	estado := true.
]

{ #category : #accessing }
Reaccion >> usuario [
	^ usuario
]
