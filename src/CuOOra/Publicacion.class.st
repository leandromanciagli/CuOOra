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
Publicacion >> eliminarReaccion: unaReaccion [
	reacciones remove: unaReaccion.
]

{ #category : #'as yet unclassified' }
Publicacion >> eliminarReaccionDe: unUsuario [

	reacciones do: [ :r | (r usuario = unUsuario) ifTrue: [ self eliminarReaccion: r ] ].
	"Buscar corte de control para que cuando encuentre la reaccion del usuario no siga buscando".
]

{ #category : #initialization }
Publicacion >> initialize [
	fechaHora := DateAndTime now.
	reacciones := OrderedCollection new
]
