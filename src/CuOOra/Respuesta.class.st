Class {
	#name : #Respuesta,
	#superclass : #Publicacion,
	#instVars : [
		'texto',
		'pregunta'
	],
	#category : #CuOOra
}

{ #category : #'instance creation' }
Respuesta class >> crearRespuestaConTexto:unTexto aPregunta:unaPregunta porUsuario:unUsuario [
	^ self new crearRespuestaConTexto:unTexto aPregunta:unaPregunta porUsuario:unUsuario.
]

{ #category : #'as yet unclassified' }
Respuesta >> crearRespuestaConTexto:unTexto aPregunta:unaPregunta porUsuario:unUsuario [
	pregunta := unaPregunta.
	usuario := unUsuario.
	texto := unTexto.
	
]

{ #category : #'as yet unclassified' }
Respuesta >> delete [
	usuario borrarRespuesta: self
]

{ #category : #'as yet unclassified' }
Respuesta >> esRespuesta [
	^ true
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
