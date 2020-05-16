Class {
	#name : #CuOOraTestCase,
	#superclass : #TestCase,
	#instVars : [
		'cuoora',
		'usuarioCatherine',
		'usuarioLeandro',
		'topicoProgramacion',
		'topicoPOO',
		'preguntaDeProgramacion'
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
	
	"Se crean 2 topicos"
	topicoProgramacion := cuoora crearTopicoConNombre: 'Programacion' yDescripcion: 'Patrones'.
	topicoPOO := cuoora crearTopicoConNombre: 'POO' yDescripcion: 'Programacion orientada a objetos'.
	
	"Los usuarios registran topicos de su interes"
	usuarioCatherine agregarTopicoDeInteres: topicoProgramacion.
	usuarioLeandro agregarTopicoDeInteres: topicoProgramacion.
	
	"Se crea una pregunta"
	preguntaDeProgramacion := cuoora crearPreguntaConTitulo: '¿Que es la POO?' descripcion: 'Funcionamiento del paradigma' porUsuario: usuarioCatherine yTopicos:(OrderedCollection with: topicoProgramacion with: topicoPOO).
	
	"Se crea una respuesta para la pregunta"
	cuoora crearRespuestaConTexto: 'Es un conjunto de objetos que se mandan mensajes entre si' aPregunta: preguntaDeProgramacion porUsuario: usuarioLeandro.
	
]

{ #category : #tests }
CuOOraTestCase >> testBuscarTopicoConNombre [
	self
		assert: (cuoora topicos detect: [ :topico | topico nombre = 'Programacion' ]) notNil.
	self
		should: [ cuoora topicos detect: [ :topico | topico nombre = 'Moda' ] ]
		raise: Error
]

{ #category : #tests }
CuOOraTestCase >> testCrearPregunta [
	self
		assert:
			(usuarioCatherine preguntasRealizadas
				detect: [ :pregunta | pregunta titulo = '¿Que es la POO?' ])
				notNil.	"La pregunta se agrego a la coleccion de preguntas del usuario usuarioCatherine"
	self
		assert:
			(topicoProgramacion preguntas
				detect: [ :pregunta | pregunta titulo = '¿Que es la POO?' ])
				notNil.	"La pregunta se agrego a la coleccion de preguntas del topico topicoProgramacion"
	self
		assert:
			(topicoPOO preguntas
				detect: [ :pregunta | pregunta titulo = '¿Que es la POO?' ])
				notNil	"La pregunta se agrego a la coleccion de preguntas del topico topicoProgramacion"
]

{ #category : #tests }
CuOOraTestCase >> testCrearRespuesta [
	self
		assert:
			(usuarioLeandro respuestasRealizadas
				detect:
					[ :respuesta | respuesta texto = 'Es un conjunto de objetos que se mandan mensajes entre si' ])
				notNil.	"La respuesta es agregada a la coleccion de publicaciones del usuario usuarioLeandro"
	self
		assert:
			(preguntaDeProgramacion obtenerRespuestasPorPuntaje
				detect:
					[ :respuesta | respuesta texto = 'Es un conjunto de objetos que se mandan mensajes entre si' ])
				notNil	"La respuesta es agregada a la coleccion de respuestas de la pregunta preguntaDeProgramacion"
]

{ #category : #tests }
CuOOraTestCase >> testCrearTopico [
	self assert: (cuoora topicos detect: [ :topico | topico nombre = 'Programacion' ]) notNil
	"El topico 'Programacion' deberia estar agregado correctamente en la coleccion de topicos de cuoora"
]

{ #category : #tests }
CuOOraTestCase >> testCrearUsuario [
	self assert: (cuoora usuarios detect: [ :usuario | usuario nombre = 'Leandro' ]) notNil
	"El usuario 'Leandro' deberia estar agregado correctamente en la coleccion de usuarios de cuoora"
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
