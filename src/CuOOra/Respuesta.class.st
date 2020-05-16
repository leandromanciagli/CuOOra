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
Respuesta class >> nuevaConTexto: unTexto aPregunta: unaPregunta porUsuario: unUsuario [
	^ self new
		inicializarConTexto: unTexto
		aPregunta: unaPregunta
		porUsuario: unUsuario
]

{ #category : #'instance initialization' }
Respuesta >> inicializarConTexto: unTexto aPregunta: unaPregunta porUsuario: unUsuario [
	pregunta := unaPregunta.
	usuario := unUsuario.
	texto := unTexto
]

{ #category : #accessing }
Respuesta >> pregunta [
	^ pregunta
]

{ #category : #accessing }
Respuesta >> pregunta: unaPregunta [
	pregunta := unaPregunta
]

{ #category : #accessing }
Respuesta >> preguntaEsDelUsuario: unUsuario [
	^ self pregunta usuario == unUsuario
]

{ #category : #accessing }
Respuesta >> texto [
	^ texto
]
