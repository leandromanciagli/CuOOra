Class {
	#name : #Respuesta,
	#superclass : #Publicacion,
	#instVars : [
		'texto',
		'pregunta'
	],
	#category : #CuOOra
}

{ #category : #'as yet unclassified' }
Respuesta class >> nuevoRespuesta:unTexto de:unaPregunta usu:unUsuario [
	^ self new nuevaRespuesta:unTexto de:unaPregunta usu:unUsuario.
]

{ #category : #'as yet unclassified' }
Respuesta >> delete [
        usuario borrarPublicacion: self.
]

{ #category : #'as yet unclassified' }
Respuesta >> esRespuesta [
 	^ true.
]

{ #category : #'as yet unclassified' }
Respuesta >> likes [
	^ self reacciones select: [ :each | each estado ]
]

{ #category : #'as yet unclassified' }
Respuesta >> nuevaRespuesta:unTexto de:unaPregunta usu:unUsuario [
	pregunta := unaPregunta.
	usuario := unUsuario.
	texto := unTexto.
	
]

{ #category : #'as yet unclassified' }
Respuesta >> puntaje [
	| cantLikes cantDislikes |
	self reacciones isEmpty
		ifTrue: [ ^ 0 ] "Por si esa publicacion no tiene ninguna reaccion"
		ifFalse: [ cantLikes := self likes size.
			cantDislikes := self reacciones size - cantLikes.
			^ cantLikes - cantDislikes ]
]
