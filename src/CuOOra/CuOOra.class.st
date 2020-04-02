Class {
	#name : #CuOOra,
	#superclass : #Object,
	#instVars : [
		'usuarios',
		'topicos'
	],
	#classInstVars : [
		'instance',
		'cuoora'
	],
	#category : #CuOOra
}

{ #category : #'as yet unclassified' }
CuOOra >> agregarPregunta:unTitulo Descrip:unaDescripcion usu:unUsuario topics:unosTopicos [ 
	|preg|
	preg := Pregunta nuevoTitulo: unTitulo Descrip:unaDescripcion  usu:unUsuario  top:unosTopicos. "La creación es realizada por la clase 																																Pregunta"
	unUsuario agregarPublicacion:preg.  "La pregunta creada se agrega a la coleccion de preguntas del usuario"
	unosTopicos do:[:top|top agregarPregunta:preg]. "La pregunta creada se agrega a la coleccion de preguntas de un/os topico/s"
	^ preg.
]

{ #category : #'as yet unclassified' }
CuOOra >> agregarRespuesta:unTexto de:unaPregunta usu:unUsuario [ 
	|resp|
	resp := Respuesta nuevoRespuesta:unTexto de:unaPregunta usu:unUsuario. "La creación es realizada por la clase Respuesta"
	unUsuario agregarPublicacion:resp.  "La respuesta creada se agrega a la coleccion de publicaciones(respuestas) del usuario"
	unaPregunta agregarRespuesta:resp. "La respuesta creada se agrega a la coleccion de respuestas de la pregunta"
	^ resp.
]

{ #category : #'as yet unclassified' }
CuOOra >> agregarTopico:nom descripcion:descrip [ 
|top|
	top:=Topico crearTopico: nom descripcion:descrip.
	topicos add: top.
	^top.
]

{ #category : #'as yet unclassified' }
CuOOra >> crearNuevoUsuario:nombre cont:contrasena [
|usuario|
usuario:= Usuario nuevo: nombre y:contrasena.
usuarios add:usuario. 
^ usuario.
	
]

{ #category : #initialization }
CuOOra >> initialize [ 
	usuarios := OrderedCollection new.
	topicos := OrderedCollection new.
	
]

{ #category : #'as yet unclassified' }
CuOOra >> obtenerRespuestasA:unaPregunta [
	^ unaPregunta obtenerRespuestas.
]

{ #category : #'as yet unclassified' }
CuOOra >> registrarDislikeDe: unUsuario a: unaPublicacion [
	| dislike |
	dislike := Dislike newConUsuario: unUsuario yPublicacion: unaPublicacion.
	unaPublicacion eliminarReaccionDe: unUsuario.
	unaPublicacion agregarReaccion: dislike.
	^ dislike
]

{ #category : #'as yet unclassified' }
CuOOra >> registrarLikeDe: unUsuario a: unaPublicacion [
	| like |
	like := Like newConUsuario: unUsuario yPublicacion: unaPublicacion.
	unaPublicacion eliminarReaccionDe: unUsuario.
	unaPublicacion agregarReaccion: like.
	^ like
]

{ #category : #'as yet unclassified' }
CuOOra >> registrarTopInteres:unTopico a:unUsuario [ 
	unUsuario agregarTopicoInteres: unTopico.
]

{ #category : #'as yet unclassified' }
CuOOra >> todasLasPreguntasDe:unTopico [
	^ unTopico todasLasPreguntas.
]

{ #category : #accessing }
CuOOra >> topicos [
	^ topicos
]

{ #category : #accessing }
CuOOra >> topicos: anObject [
	topicos := anObject
]

{ #category : #'as yet unclassified' }
CuOOra >> usuario:unUsuario sigue:otroUsuario [
	unUsuario seguir:otroUsuario.
]

{ #category : #accessing }
CuOOra >> usuarios [
	^ usuarios
]

{ #category : #accessing }
CuOOra >> usuarios: anObject [
	usuarios := anObject
]
