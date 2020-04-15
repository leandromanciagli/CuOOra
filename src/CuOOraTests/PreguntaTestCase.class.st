Class {
	#name : #PreguntaTestCase,
	#superclass : #TestCase,
	#instVars : [
		'cuoora',
		'usuarioCatherine',
		'usuarioLeandro',
		'topicoProgramacion',
		'topicoPOO',
		'topicoCocina',
		'preguntaDeProgramacion',
		'respuestaAPreguntaDeProgramacion'
	],
	#category : #CuOOraTests
}

{ #category : #running }
PreguntaTestCase >> setUp [ 
	super setUp.
	cuoora := CuOOra new.
	
	"Se crean 2 usuarios"
	usuarioCatherine := cuoora crearUsuarioConNombre: 'Catherine' yContrasena: 'laContrasenaDeCatherine'.
	usuarioLeandro := cuoora crearUsuarioConNombre: 'Leandro' yContrasena: 'laContrasenaDeLeandro'.
	
	"Se crean 3 topicos"
	topicoProgramacion := cuoora crearTopicoConNombre: 'Programacion' yDescripcion: 'Patrones'.
	topicoPOO := cuoora crearTopicoConNombre: 'POO' yDescripcion: 'Programacion orientada a objetos'.
	topicoCocina := cuoora crearTopicoConNombre: 'Cocina' yDescripcion: 'Arroz con pollo'.
	
	"Los usuarios registran topicos de su interes"
	usuarioCatherine agregarTopicoDeInteres: topicoProgramacion.
	usuarioLeandro agregarTopicoDeInteres: topicoCocina.
	
	"Se crea una pregunta"
	preguntaDeProgramacion := cuoora crearPreguntaConTitulo: '¿Que es la POO?' descripcion: 'Funcionamiento del paradigma' porUsuario: usuarioCatherine yTopicos:(OrderedCollection with: topicoProgramacion with: topicoPOO).
	
	"Se crea una respuesta para la pregunta"
	respuestaAPreguntaDeProgramacion := cuoora crearRespuestaConTexto: 'Es un conjunto de objetos que se mandan mensajes entre si' aPregunta: preguntaDeProgramacion porUsuario: usuarioLeandro.
	
	"Se registra reaccion a la respuesta"
	cuoora registrarReaccionDelUsuario: usuarioCatherine aPublicacion: respuestaAPreguntaDeProgramacion conVoto: true.

	






	






]

{ #category : #tests }
PreguntaTestCase >> testAgregarRespuesta [
	self
		assert:
			(topicoProgramacion preguntas
				detect: [ :p | p titulo = '¿Alguien sabe test de unidad?' ])
				notNil.	"La pregunta se encuentra entre las preguntas del topico"
	self
		assert:
			(topicoProgramacion preguntas
				detect: [ :p | p titulo = '¿Cual es la capital de Italia?' ])
				notNil.	"La pregunta se encuentra entre las preguntas del topico"
	self
		should: [ topicoProgramacion preguntas
				detect: [ :p | p titulo = '¿Cual es la capital de Italia?' ] ]
		raise: Error	"La pregunta se agregó al topico que se le indico y no a otro"
]

{ #category : #tests }
PreguntaTestCase >> testDelete [
	| pregunta |
	cuoora
		crearPreguntaConTitulo: '¿Como multiplicar matrices?'
		descripcion: 'En Pascal'
		porUsuario: usuarioCatherine
		yTopicos: (OrderedCollection with: topicoProgramacion).
	pregunta := usuarioCatherine preguntasRealizadas
		detect: [ :p | p titulo = '¿Como multiplicar matrices?' ]
		ifNone: [ nil ].
	self assert: pregunta notNil.	"La pregunta debería existir"
	pregunta delete.	"Se borra la pregunta"
	pregunta := usuarioCatherine preguntasRealizadas
		detect: [ :p | p titulo = '¿Como multiplicar matrices?' ]
		ifNone: [ nil ].
	self assert: pregunta isNil	"La pregunta ya no debería existir"
]

{ #category : #tests }
PreguntaTestCase >> testObtenerRespuestasPorPuntaje [
]
