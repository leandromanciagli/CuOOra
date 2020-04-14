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
		nuevaConTexto: unTexto
		aPregunta: unaPregunta
		porUsuario: unUsuario
]

{ #category : #deleting }
Respuesta >> delete [
	usuario borrarPublicacion: self
]

{ #category : #overrided }
Respuesta >> esRespuesta [
	^ true
]

{ #category : #'instance initialization' }
Respuesta >> nuevaConTexto: unTexto aPregunta: unaPregunta porUsuario: unUsuario [
	pregunta := unaPregunta.
	usuario := unUsuario.
	texto := unTexto
]

{ #category : #accessing }
Respuesta >> pregunta [
	^ pregunta
]

{ #category : #accessing }
Respuesta >> texto [
	^ texto
]
