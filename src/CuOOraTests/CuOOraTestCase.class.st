Class {
	#name : #CuOOraTestCase,
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
CuOOraTestCase >> setUp [ 
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
	respuestaAPreguntaDeProgramacion registrarLikeDelUsuario: usuarioCatherine.

	






	






]

{ #category : #tests }
CuOOraTestCase >> testBuscarTopicoConNombre [
	self
		assert: (cuoora topicos detect: [ :t | t nombre = 'Programacion' ]) notNil.
	self
		should: [ cuoora topicos detect: [ :t | t nombre = 'Moda' ] ]
		raise: Error
]

{ #category : #tests }
CuOOraTestCase >> testCrearPregunta [
	self
		assert:
			(usuarioCatherine preguntasRealizadas
				detect: [ :p | p titulo = '¿Que es la POO?' ]) notNil.	"La pregunta se agrego a la coleccion de preguntas del usuario usuarioCatherine"
	self
		assert:
			(topicoProgramacion preguntas
				detect: [ :p | p titulo = '¿Que es la POO?' ]) notNil.	"La pregunta se agrego a la coleccion de preguntas del topico topicoProgramacion"
	self
		assert:
			(topicoPOO preguntas detect: [ :p | p titulo = '¿Que es la POO?' ])
				notNil	"La pregunta se agrego a la coleccion de preguntas del topico topicoProgramacion"
]

{ #category : #tests }
CuOOraTestCase >> testCrearRespuesta [
	self
		assert:
			(usuarioLeandro respuestasRealizadas
				detect:
					[ :r | r texto = 'Es un conjunto de objetos que se mandan mensajes entre si' ])
				notNil.	"La respuesta es agregada a la coleccion de publicaciones del usuario usuarioLeandro"
	self
		assert:
			(preguntaDeProgramacion obtenerRespuestasPorPuntaje
				detect:
					[ :r | r texto = 'Es un conjunto de objetos que se mandan mensajes entre si' ])
				notNil	"La respuesta es agregada a la coleccion de respuestas de la pregunta preguntaDeProgramacion"
]

{ #category : #tests }
CuOOraTestCase >> testCrearTopico [
	"El topico 'Programacion' deberia estar agregado correctamente en la coleccion de topicos de cuoora"

	self
		assert: (cuoora topicos detect: [ :top | top nombre = 'Programacion' ]) notNil
]

{ #category : #tests }
CuOOraTestCase >> testCrearUsuario [
	"El usuario 'Leandro' deberia estar agregado correctamente en la coleccion de usuarios de cuoora"

	self
		assert: (cuoora usuarios detect: [ :u | u nombre = 'Leandro' ]) notNil
]

{ #category : #tests }
CuOOraTestCase >> testRegistrarReaccionDelUsuario [
	| reaccionDeCatherine |
	reaccionDeCatherine := respuestaAPreguntaDeProgramacion
		buscarReaccionDelUsuario: usuarioCatherine.
	self assert: reaccionDeCatherine estado equals: true.
	respuestaAPreguntaDeProgramacion
		registrarDisLikeDelUsuario: usuarioCatherine.
	self assert: reaccionDeCatherine estado equals: false
]

{ #category : #tests }
CuOOraTestCase >> testValidarUsuario [
	self
		assert:
			(cuoora
				validarUsuarioConNombre: usuarioLeandro nombre
				yContrasena: usuarioLeandro contrasena) notNil.	"Debería existir el usuario"
	self
		assert:
			(cuoora validarUsuarioConNombre: 'Alberto' yContrasena: 'laContrasenaDeAlberto')
				isNil	"No debería existir el usuario"
]
