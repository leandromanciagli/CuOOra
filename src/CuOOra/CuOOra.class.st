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
	preg := Pregunta nuevoTitulo: unTitulo Descrip:unaDescripcion  usu:unUsuario  top:unosTopicos.
	unUsuario agregarPregunta:preg.
	unosTopicos do:[:top|top agregarPregunta:preg].
	^ preg.
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
