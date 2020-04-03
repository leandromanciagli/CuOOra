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
Publicacion >> buscarReaccionDe: unUsuario [
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
Publicacion >> esPregunta [

	^ false.
]

{ #category : #'as yet unclassified' }
Publicacion >> esRespuesta [
 	^ false.
]

{ #category : #initialization }
Publicacion >> initialize [
	fechaHora := DateAndTime now.
	reacciones := OrderedCollection new
]

{ #category : #'as yet unclassified' }
Publicacion >> likes [
	^ self reacciones select: [ :each | each estado ]
]

{ #category : #'as yet unclassified' }
Publicacion >> puntaje [
	| cantLikes cantDislikes |
	self reacciones isEmpty
		ifTrue: [ ^ 0 ] "Por si esa publicacion no tiene ninguna reaccion"
		ifFalse: [ cantLikes := self likes size.
			cantDislikes := self reacciones size - cantLikes.
			^ cantLikes - cantDislikes ]
]

{ #category : #accessing }
Publicacion >> reacciones [
	^ reacciones
]
