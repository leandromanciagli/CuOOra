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
Respuesta class >> nuevaConTexto:unTexto aPregunta:unaPregunta porUsuario:unUsuario [
	^ self new nuevaConTexto:unTexto aPregunta:unaPregunta porUsuario:unUsuario.
]

{ #category : #'as yet unclassified' }
Respuesta >> delete [
	usuario borrarRespuesta: self
]

{ #category : #'as yet unclassified' }
Respuesta >> esRespuesta [
	^ true
]

{ #category : #'as yet unclassified' }
Respuesta >> nuevaConTexto:unTexto aPregunta:unaPregunta porUsuario:unUsuario [
	pregunta := unaPregunta.
	usuario := unUsuario.
	texto := unTexto.
	
]

{ #category : #accessing }
Respuesta >> pregunta [
	^ pregunta
]

{ #category : #accessing }
Respuesta >> texto [
	^ texto
]

{ #category : #accessing }
Respuesta >> texto: anObject [
	texto := anObject
]
