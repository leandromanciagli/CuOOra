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

{ #category : #deleting }
Respuesta >> delete [
	usuario quitarPublicacion: self. "La respuesta se quita de la coleccion de publicaciones del usuario"
	reacciones do: [ :reaccion | reaccion borrarPublicacion ]. "La respuesta se quita de cada reaccion a la que pertenece"
	reacciones := nil "Se borran todas las reacciones asociadas a la respuesta"
]

{ #category : #overrided }
Respuesta >> esRespuesta [
	^ true
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
Respuesta >> texto [
	^ texto
]
