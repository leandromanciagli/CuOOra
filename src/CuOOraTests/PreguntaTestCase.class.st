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
		'respuestaAPreguntaDeProgramacion',
		'preguntaDeCocina'
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
	
	"Se crean 2 preguntas"
	preguntaDeProgramacion := cuoora crearPreguntaConTitulo: '¿Que es la POO?' descripcion: 'Funcionamiento del paradigma' porUsuario: usuarioCatherine yTopicos:(OrderedCollection with: topicoProgramacion with: topicoPOO).
	
	preguntaDeCocina := cuoora crearPreguntaConTitulo: '¿Como se hace una torta?' descripcion: 'Ingredientes' porUsuario: usuarioCatherine yTopicos:(OrderedCollection with: topicoProgramacion with: topicoPOO).
	
	"Se crea una respuesta para la pregunta"
	respuestaAPreguntaDeProgramacion := cuoora crearRespuestaConTexto: 'Es un conjunto de objetos que se mandan mensajes entre si' aPregunta: preguntaDeProgramacion porUsuario: usuarioLeandro.
	
	"Se registra reaccion a la respuesta"
	cuoora registrarReaccionDelUsuario: usuarioCatherine aPublicacion: respuestaAPreguntaDeProgramacion conVoto: true.

	






	






]

{ #category : #tests }
PreguntaTestCase >> testAgregarRespuesta [
	self
		assert:
			(preguntaDeProgramacion obtenerRespuestasPorPuntaje
				detect: [ :resp | 
					resp texto
						= 'Es un conjunto de objetos que se mandan mensajes entre si' ])
				notNil.	"La respuesta se encuentra entre las respuestas de la pregunta"
	self
		should: [ preguntaDeCocina obtenerRespuestasPorPuntaje
				detect: [ :resp | resp texto = '¿Como se hace una torta?' ] ]
		raise: Error	"La respuesta se agregó a las respuestas de la pregunta que se indico y no a otra"

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
		
	self assert: pregunta isNil.	"La pregunta ya no debería existir en la coleccion de publicaciones del usuario"
		
	pregunta := topicoProgramacion preguntas 
		detect: [ :p | p titulo = '¿Como multiplicar matrices?' ]
		ifNone: [ nil ].
		
	self assert: pregunta isNil.	"La pregunta ya no debería existir en la coleccion de preguntas del topico"


]
