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

{ #category : #'search and filtering' }
Publicacion >> buscarReaccionDelUsuario: unUsuario [
	| reaccion |
	reacciones
		do: [ :r | r usuario = unUsuario
				ifTrue: [ reaccion := r ] ].
	^ reaccion
]

{ #category : #'submorphs-add/remove' }
Publicacion >> delete [ 
	self subclassResponsibility.
]

{ #category : #'search and filtering' }
Publicacion >> dislikes [
	^ self reacciones reject: [ :each | each estado ] "reject devuelve todos los false"
]

{ #category : #overridden }
Publicacion >> esPregunta [
	^ false
]

{ #category : #overridden }
Publicacion >> esRespuesta [
	^ false
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
	^ self reacciones select: [ :each | each estado ] "select devuelve todos los true"
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
Publicacion >> registrarDisLikeDelUsuario: unUsuario [
	| reaccion |
	reaccion := self buscarReaccionDelUsuario: unUsuario.
	reaccion
		ifNil: [ reaccion := Reaccion nuevaDelUsuario:unUsuario dislikesPublicacion: self.
			      self agregarReaccion: reaccion ]
		ifNotNil: [ reaccion dislike].
	^ reaccion
]

{ #category : #adding }
Publicacion >> registrarLikeDelUsuario: unUsuario [
	| reaccion |
	reaccion := self buscarReaccionDelUsuario: unUsuario.
	reaccion
		ifNil: [ reaccion := Reaccion nuevaDelusuario:unUsuario likesPublicacion: self.
			      self agregarReaccion: reaccion ]
		ifNotNil: [ reaccion like].
	^ reaccion
]

{ #category : #accessing }
Publicacion >> usuario [
	^ usuario
]
