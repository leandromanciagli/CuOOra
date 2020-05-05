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

{ #category : #'instance creation' }
Reaccion class >> nuevaDelUsuario:unUsuario dislikesPublicacion: unaPublicacion [
	^ self new inicializarDelUsuario: unUsuario dislikesPublicacion: unaPublicacion
		
		
		

]

{ #category : #'instance creation' }
Reaccion class >> nuevaDelusuario:unUsuario likesPublicacion: unaPublicacion [
	^ self new inicializarDelUsuario: unUsuario likesPublicacion: unaPublicacion
		
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
	^ estado "voto"
]

{ #category : #initialization }
Reaccion >> inicializarDelUsuario: unUsuario dislikesPublicacion: unaPublicacion [
	usuario := unUsuario.
	publicacion := unaPublicacion.
	self dislike
]

{ #category : #initialization }
Reaccion >> inicializarDelUsuario: unUsuario likesPublicacion: unaPublicacion [
	usuario := unUsuario.
	publicacion := unaPublicacion.
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
