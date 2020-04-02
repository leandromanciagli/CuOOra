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

{ #category : #'submorphs-add/remove' }
Publicacion >> delete [ 
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
Publicacion >> eliminarReaccion: unaReaccion [
	reacciones remove: unaReaccion.
]

{ #category : #'as yet unclassified' }
Publicacion >> eliminarReaccionDe: unUsuario [

	reacciones do: [ :r | (r usuario = unUsuario) ifTrue: [ self eliminarReaccion: r ] ].
	"Buscar corte de control para que cuando encuentre la reaccion del usuario no siga buscando".
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
Publicacion >> puntaje [
	(reacciones isEmpty)
	ifTrue: [ ^ 0 ] "por si esa publicacion no tiene ninguna reaccion"
	ifFalse:[]. "aca habria que obtener el puntaje"
]
