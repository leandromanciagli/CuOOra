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

{ #category : #'as yet unclassified' }
Publicacion >> agregarReaccion: unaReaccion [
	reacciones add: unaReaccion
]

{ #category : #'as yet unclassified' }
Publicacion >> buscarReaccionDelUsuario: unUsuario [
	| reaccion |
	reacciones
		do: [ :r | 
			r usuario = unUsuario
				ifTrue: [ reaccion := r ] ].
	^ reaccion
]

{ #category : #'submorphs-add/remove' }
Publicacion >> delete [ 
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
Publicacion >> dislikes [
	^ self reacciones reject: [ :each | each estado ] "reject devuelve todos los false"
]

{ #category : #'as yet unclassified' }
Publicacion >> esPregunta [
	^ false
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
Publicacion >> likes [
	^ self reacciones select: [ :each | each estado ] "select devuelve todos los true"
]

{ #category : #'as yet unclassified' }
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

{ #category : #accessing }
Publicacion >> usuario [
	^ usuario
]
