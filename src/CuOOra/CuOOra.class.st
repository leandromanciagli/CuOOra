Class {
	#name : #CuOOra,
	#superclass : #Object,
	#instVars : [
		'usuarios',
		'topicos'
	],
	#classInstVars : [
		'instancia'
	],
	#category : #CuOOra
}

{ #category : #'as yet unclassified' }
CuOOra class >> clearInstancia [ 
	instancia := nil.
]

{ #category : #accessing }
CuOOra class >> instancia [

	^ instancia ifNil:[instancia := self new]
	ifNotNil: [ instancia ].
]

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
CuOOra >> borrarUnaPregunta:unaPregunta [
	unaPregunta delete.
]

{ #category : #'as yet unclassified' }
CuOOra >> calcularPuntajeDelUsuario: unUsuario [
	| puntajePorPreguntas puntajePorRespuestas puntajePorVotacion |
	puntajePorPreguntas := unUsuario preguntasRealizadas size * 20.
	puntajePorRespuestas := unUsuario respuestasAPreguntasDeOtrosUsuarios size * 50.
	puntajePorVotacion := unUsuario publicaciones inject: 0 into: [ :sum :p | sum + p puntaje ].
	^ puntajePorPreguntas + puntajePorRespuestas + puntajePorVotacion
]

{ #category : #'as yet unclassified' }
CuOOra >> crearNuevoUsuario:nombre cont:contrasena [
|usuario|
usuario:= Usuario nuevo: nombre y:contrasena.
usuarios add:usuario. 
^ usuario.
	
]

{ #category : #'as yet unclassified' }
CuOOra >> getTopicos: aName [ 

^ topicos detect: [ :t | t nombre = aName].

"'verifica' que el nombre del topico ingresado en el agregar pregunta exista"
]

{ #category : #initialization }
CuOOra >> initialize [ 
	usuarios := OrderedCollection new.
	topicos := OrderedCollection new.
	
]

{ #category : #'as yet unclassified' }
CuOOra >> loginUsuario:unNombre contrasena:unaContrasena [

	^ usuarios detect: [ :usu | (usu nombre = unNombre ) & (usu contrasena = unaContrasena) ] ifNone:[nil].
]

{ #category : #accessing }
CuOOra >> registrarReaccionDe: unUsuario a: unaPublicacion conVoto: unVoto [
	| reaccion |
	reaccion := unaPublicacion buscarReaccionDe: unUsuario.
	reaccion
		ifNil: [ reaccion := Reaccion
				newConUsuario: unUsuario
				publicacion: unaPublicacion
				yVoto: unVoto.
			unaPublicacion agregarReaccion: reaccion ]
		ifNotNil: [ reaccion estado: unVoto ].
	^ reaccion
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
