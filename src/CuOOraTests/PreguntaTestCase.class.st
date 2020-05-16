Class {
	#name : #PreguntaTestCase,
	#superclass : #TestCase,
	#instVars : [
		'usuarioCatherine',
		'usuarioLeandro',
		'preguntaDeProgramacion',
		'preguntaDeCocina',
		'respuestaAPreguntaDeProgramacion',
		'reaccionDeLeandro'
	],
	#category : #CuOOraTests
}

{ #category : #running }
PreguntaTestCase >> setUp [ 
	super setUp.
	
	"Se crean 2 usuarios"
	usuarioCatherine := Usuario nuevoConNombre: 'Catherine' yContrasena: 'laContrasenaDeCatherine'.
	usuarioLeandro := Usuario nuevoConNombre: 'Leandro' yContrasena: 'laContrasenaDeLeandro'.
	
	"Se crean 2 preguntas"
	preguntaDeProgramacion := Pregunta nuevaConTitulo: '¿Que es la POO?' descripcion: 'Funcionamiento del paradigma' porUsuario: usuarioCatherine yTopicos:{}.
	preguntaDeCocina := Pregunta nuevaConTitulo: '¿Como se hace una torta?' descripcion: 'Ingredientes' porUsuario: usuarioCatherine yTopicos:{}.
	
	"Se crea una respuesta para la pregunta"
	respuestaAPreguntaDeProgramacion := Respuesta nuevaConTexto: 'Es un conjunto de objetos que se mandan mensajes entre si' aPregunta: preguntaDeProgramacion porUsuario: usuarioLeandro.
	
	preguntaDeProgramacion agregarRespuesta: respuestaAPreguntaDeProgramacion.
	
	reaccionDeLeandro := Reaccion nuevaDelUsuario: usuarioLeandro dislikesPublicacion: preguntaDeCocina.
	preguntaDeCocina agregarReaccion: reaccionDeLeandro.
]

{ #category : #tests }
PreguntaTestCase >> testAgregarRespuesta [
	self
		assert:
			(preguntaDeProgramacion obtenerRespuestasPorPuntaje
				detect: [ :respuesta | respuesta texto = 'Es un conjunto de objetos que se mandan mensajes entre si' ])
				notNil. "La respuesta se encuentra entre las respuestas de la pregunta"
	self
		should: [ preguntaDeCocina obtenerRespuestasPorPuntaje
				detect: [ :respuesta | respuesta texto = 'Es un conjunto de objetos que se mandan mensajes entre si' ] ]
		raise: Error	 "La respuesta se agregó a las respuestas de la pregunta que se indico y no a otra"
]

{ #category : #tests }
PreguntaTestCase >> testRegistrarDislikeDelUsuario [
	self assert: reaccionDeLeandro estado equals: false.
	self should: [ reaccionDeLeandro estado equals: true ] raise: Error.
	self
		assert:
			(preguntaDeCocina reacciones
				detect: [ :reaccion | reaccion usuario = usuarioLeandro ]) notNil.
	self
		should: [ preguntaDeCocina reacciones
				detect: [ :reaccion | reaccion usuario = usuarioCatherine ] ]
		raise: Error
]
