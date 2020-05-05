Class {
	#name : #RespuestaTestCase,
	#superclass : #TestCase,
	#instVars : [
		'cuoora',
		'usuarioCatherine',
		'usuarioLeandro',
		'topicoProgramacion',
		'topicoPOO',
		'preguntaDeProgramacion',
		'respuestaAPreguntaDeProgramacion',
		'respuestaAPreguntaDeProgramacion2',
		'respuestaAPreguntaDeProgramacion3'
	],
	#category : #CuOOraTests
}

{ #category : #running }
RespuestaTestCase >> setUp [
	super setUp.
	cuoora := CuOOra new.
	
	"Se crean 2 usuarios"
	usuarioCatherine := cuoora crearUsuarioConNombre: 'Catherine' yContrasena: 'laContrasenaDeCatherine'.
	usuarioLeandro := cuoora crearUsuarioConNombre: 'Leandro' yContrasena: 'laContrasenaDeLeandro'.
	
	"Se crean 2 topicos"
	topicoProgramacion := cuoora crearTopicoConNombre: 'Programacion' yDescripcion: 'Patrones'.
	topicoPOO := cuoora crearTopicoConNombre: 'POO' yDescripcion: 'Programacion orientada a objetos'.
	
	"El usuario registra un topico de su interes"
	usuarioCatherine agregarTopicoDeInteres: topicoProgramacion.
	
	"Se crea 1 pregunta"
	preguntaDeProgramacion := cuoora crearPreguntaConTitulo: '¿Que es la POO?' descripcion: 'Funcionamiento del paradigma' porUsuario: usuarioCatherine yTopicos:(OrderedCollection with: topicoProgramacion with: topicoPOO).
	
	"Se crean 2 respuestas para la pregunta"
	respuestaAPreguntaDeProgramacion := cuoora crearRespuestaConTexto: 'Es un conjunto de objetos que se mandan mensajes entre si' aPregunta: preguntaDeProgramacion porUsuario: usuarioLeandro.
	
	respuestaAPreguntaDeProgramacion2 := cuoora crearRespuestaConTexto: 'Objeto - Mensaje' aPregunta: preguntaDeProgramacion porUsuario: usuarioLeandro.
	respuestaAPreguntaDeProgramacion3 := cuoora crearRespuestaConTexto: 'Es un paradigma de programación' aPregunta: preguntaDeProgramacion porUsuario: usuarioLeandro.
	
	"Se registra reaccion a la respuesta"
	respuestaAPreguntaDeProgramacion registrarLikeDelUsuario: usuarioCatherine.
	respuestaAPreguntaDeProgramacion registrarLikeDelUsuario: usuarioLeandro.
	respuestaAPreguntaDeProgramacion2 registrarLikeDelUsuario: usuarioCatherine.

	






	






]

{ #category : #tests }
RespuestaTestCase >> testAgregarReaccion [
	self
		assert:
			(respuestaAPreguntaDeProgramacion reacciones
				detect: [ :reaccion | reaccion usuario nombre = 'Leandro' ])
				notNil.	"Existe una reaccion del usuario Leandro en la coleccion de reacciones de la respuesta"
	self
		should: [ respuestaAPreguntaDeProgramacion2 reacciones
				detect: [ :reaccion | reaccion usuario = 'Leandro' ] ]
		raise: Error	"No deberia existir una reaccion del usuario Leandro para la respuesta"

]

{ #category : #tests }
RespuestaTestCase >> testPuntaje [
	| puntajeRespuesta puntajeReal puntajeFalso |
	puntajeRespuesta := respuestaAPreguntaDeProgramacion3 puntaje.
	puntajeReal := 0.
	puntajeFalso := 87.
	self assert: puntajeRespuesta equals: puntajeReal.
	self should: [ puntajeRespuesta equals: puntajeFalso ] raise: Error
]
