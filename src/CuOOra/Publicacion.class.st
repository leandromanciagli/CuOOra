Class {
	#name : #Publicacion,
	#superclass : #Object,
	#instVars : [
		'reacciones',
		'usuario',
		'fechaHora'
	],
	#category : #CuOOra
}

{ #category : #adding }
Publicacion >> agregarReaccion: unaReaccion [
	reacciones add: unaReaccion
]

{ #category : #removing }
Publicacion >> borrarReacciones [
	reacciones := nil
]

{ #category : #'search and filtering' }
Publicacion >> buscarReaccionDelUsuario: unUsuario [
	^ reacciones
		detect: [ :reaccion | reaccion usuario = unUsuario ]
		ifNone: [ nil ]
]

{ #category : #'search and filtering' }
Publicacion >> dislikes [
	^ self reacciones reject: [ :reaccion | reaccion estado ]
]

{ #category : #accessing }
Publicacion >> fechaHora [
	^ fechaHora
]

{ #category : #initialization }
Publicacion >> initialize [
	fechaHora := DateAndTime now.
	reacciones := OrderedCollection new
]

{ #category : #'search and filtering' }
Publicacion >> likes [
	^ self reacciones select: [ :reaccion | reaccion estado ]
]

{ #category : #calculating }
Publicacion >> puntaje [
	| cantLikes cantDislikes |
	self reacciones isEmpty
		ifTrue: [ ^ 0 ] "Por si esa publicacion no tiene ninguna reaccion"
		ifFalse: [ cantLikes := self likes size.
			cantDislikes := self dislikes size.
			^ cantLikes - cantDislikes ]
]

{ #category : #accessing }
Publicacion >> reacciones [
	^ reacciones
]

{ #category : #adding }
Publicacion >> registrarDislikeDelUsuario: unUsuario [
	| reaccion |
	reaccion := self buscarReaccionDelUsuario: unUsuario.
	reaccion
		ifNil: [ reaccion := Reaccion
				nuevaDelUsuario: unUsuario
				dislikesPublicacion: self.
			self agregarReaccion: reaccion ]
		ifNotNil: [ reaccion dislike ].
	^ reaccion
]

{ #category : #adding }
Publicacion >> registrarLikeDelUsuario: unUsuario [
	| reaccion |
	reaccion := self buscarReaccionDelUsuario: unUsuario.
	reaccion
		ifNil: [ reaccion := Reaccion
				nuevaDelusuario: unUsuario
				likesPublicacion: self.
			self agregarReaccion: reaccion ]
		ifNotNil: [ reaccion like ].
	^ reaccion
]

{ #category : #accessing }
Publicacion >> usuario [
	^ usuario
]
