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

{ #category : #clearing }
CuOOra class >> clearInstancia [ 
	instancia := nil.
]

{ #category : #accessing }
CuOOra class >> instancia [
	^ instancia ifNil: [ instancia := self new ] ifNotNil: [ instancia ]
]

{ #category : #deleting }
CuOOra >> borrarPregunta: unaPregunta [
	unaPregunta delete
]

{ #category : #accessing }
CuOOra >> buscarTopicoConNombre: unNombre [
	^ topicos
		detect:
			[ :top | top nombre = unNombre ] "Verifica que el nombre del topico ingresado en el agregar pregunta exista"
]

{ #category : #calculating }
CuOOra >> calcularPuntajeDelUsuario: unUsuario [
	| puntajePorPreguntas puntajePorRespuestas puntajePorVotacion |
	puntajePorPreguntas := unUsuario preguntasRealizadas size * 20.
	puntajePorRespuestas := unUsuario respuestasAPreguntasDeOtrosUsuarios size * 50.
	puntajePorVotacion := unUsuario publicaciones inject: 0 into: [ :sum :p | sum + p puntaje ].
	^ puntajePorPreguntas + puntajePorRespuestas + puntajePorVotacion
]

{ #category : #adding }
CuOOra >> crearPreguntaConTitulo: unTitulo descripcion: unaDescripcion porUsuario: unUsuario yTopicos: unosTopicos [
	| pregunta |
	pregunta := Pregunta
		nuevaConTitulo: unTitulo
		descripcion: unaDescripcion
		porUsuario: unUsuario
		yTopicos: unosTopicos.	"La creación es realizada por la clase Pregunta"
	unUsuario agregarPublicacion: pregunta.	"La pregunta creada se agrega a la coleccion de preguntas del usuario"
	unosTopicos do: [ :top | top agregarPregunta: pregunta ].	"La pregunta creada se agrega a la coleccion de preguntas de un/os topico/s"
	^ pregunta
]

{ #category : #adding }
CuOOra >> crearRespuestaConTexto: unTexto aPregunta: unaPregunta porUsuario: unUsuario [
	| respuesta |
	respuesta := Respuesta
		crearRespuestaConTexto: unTexto
		aPregunta: unaPregunta
		porUsuario: unUsuario.	"La creación es realizada por la clase Respuesta"
	unUsuario agregarPublicacion: respuesta.	"La respuesta creada se agrega a la coleccion de publicaciones(respuestas) del usuario"
	unaPregunta agregarRespuesta: respuesta.	"La respuesta creada se agrega a la coleccion de respuestas de la pregunta"
	^ respuesta
]

{ #category : #adding }
CuOOra >> crearTopicoConNombre: unNombre yDescripcion: unaDescripcion [
	| topico |
	topico := Topico nuevoConNombre: unNombre yDescripcion: unaDescripcion.
	topicos add: topico.
	^ topico
]

{ #category : #adding }
CuOOra >> crearUsuarioConNombre: unNombre yContrasena: unaContrasena [
	| usuario |
	usuario := Usuario nuevoConNombre: unNombre yContrasena: unaContrasena.
	usuarios add: usuario.
	^ usuario
]

{ #category : #initialization }
CuOOra >> initialize [ 
	usuarios := OrderedCollection new.
	topicos := OrderedCollection new.
	
]

{ #category : #accessing }
CuOOra >> loginUsuario: unNombre contrasena: unaContrasena [
	^ usuarios
		detect: [ :usu | usu nombre = unNombre & (usu contrasena = unaContrasena) ]
		ifNone: [ nil ]
]

{ #category : #accessing }
CuOOra >> obtenerPreguntasDelTopico: unTopico [
	^ unTopico preguntas
]

{ #category : #adding }
CuOOra >> registrarReaccionDelUsuario: unUsuario aPublicacion: unaPublicacion conVoto: unVoto [
	| reaccion |
	reaccion := unaPublicacion buscarReaccionDelUsuario: unUsuario.
	reaccion
		ifNil: [ reaccion := Reaccion
				nuevaDelUsuario: unUsuario
				aPublicacion: unaPublicacion
				conVoto: unVoto.
			unaPublicacion agregarReaccion: reaccion ]
		ifNotNil: [ reaccion estado: unVoto ].
	^ reaccion
]

{ #category : #adding }
CuOOra >> registrarTopicoDeInteres: unTopico aUsuario: unUsuario [
	unUsuario agregarTopicoDeInteres: unTopico
]

{ #category : #accessing }
CuOOra >> topicos [
	^ topicos
]

{ #category : #accessing }
CuOOra >> topicos: anObject [
	topicos := anObject
]

{ #category : #adding }
CuOOra >> usuario: unUsuario sigue: otroUsuario [
	unUsuario seguirAlUsuario: otroUsuario
]

{ #category : #accessing }
CuOOra >> usuarios [
	^ usuarios
]
