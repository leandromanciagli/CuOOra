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

{ #category : #accessing }
Publicacion >> reacciones [
	^ reacciones
]
