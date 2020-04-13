Class {
	#name : #TestUsuario,
	#superclass : #TestCase,
	#instVars : [
		'cuoora',
		'usuarioCatherine',
		'usuarioLeandro',
		'usuarioMariano',
		'topicoProgramacion',
		'topicoGeografia',
		'topicoModa',
		'preguntaDeProgramacion',
		'preguntaDeGeografia',
		'preguntaDeModa',
		'respuesta1PreguntaProgramacion',
		'respuesta2PreguntaProgramacion'
	],
	#category : #CuOOraTests
}

{ #category : #running }
TestUsuario >> setUp [ 
	super setUp.
	cuoora := CuOOra new.
	
	"Se crean 3 usuarios"
	usuarioCatherine := cuoora crearUsuarioConNombre: 'Catherine' yContrasena: 'laContrasenaDeCatherine'.
	usuarioLeandro := cuoora crearUsuarioConNombre: 'Leandro' 	yContrasena: 'laContrasenaDeLeandro'.
	usuarioMariano := cuoora crearUsuarioConNombre: 'Mariano' 	yContrasena: 'laContrasenaDeMariano'.
	
	"Se crean 3 topicos"
	topicoProgramacion := cuoora crearTopicoConNombre: 'Programacion' yDescripcion: 'Preguntas referidas a la programación en informática'.
	topicoGeografia := cuoora crearTopicoConNombre: 'Geografia' yDescripcion: 'Preguntas referidas a geografia'.
	topicoModa := cuoora crearTopicoConNombre: 'Moda' yDescripcion: 'Preguntas referidas a Moda'.
	
	"Se crean 3 preguntas"
	preguntaDeProgramacion := cuoora crearPreguntaConTitulo: '¿Alguien sabe test de unidad?' descripcion: 'Test para OO2' porUsuario: usuarioCatherine yTopicos:(OrderedCollection with: topicoProgramacion).
	
	preguntaDeGeografia := cuoora crearPreguntaConTitulo: '¿Cual es la capital de Italia?' descripcion: 'Del topico geografia' porUsuario: usuarioMariano yTopicos:(OrderedCollection with: topicoGeografia).
	
	preguntaDeModa := cuoora crearPreguntaConTitulo: '¿Cómo caminar en tacones?' descripcion: 'Del topico moda' porUsuario: usuarioCatherine yTopicos:(OrderedCollection with: topicoModa).
	
	"Se crean 2 respuestas"
	respuesta1PreguntaProgramacion := cuoora crearRespuestaConTexto: 'Si, yo!' aPregunta: preguntaDeProgramacion porUsuario: usuarioLeandro.
	respuesta2PreguntaProgramacion := cuoora crearRespuestaConTexto: 'Idem' aPregunta: preguntaDeProgramacion porUsuario: usuarioMariano.
	
	usuarioLeandro seguirAlUsuario: usuarioMariano.
	cuoora registrarTopicoDeInteres: topicoProgramacion aUsuario: usuarioLeandro.
	
	
	
	
		
	
	
	
]

{ #category : #tests }
TestUsuario >> testAgregarPublicacion [
	self
		assert:
			(usuarioCatherine preguntasRealizadas
				detect: [ :p | p titulo = '¿Alguien sabe test de unidad?' ])
				notNil.	"La pregunta se encuentra entre las publicaciones del usuario"
	self
		assert:
			(usuarioLeandro respuestasRealizadas
				detect: [ :r | r texto = 'Si, yo!' ]) notNil.	"La respuesta se encuentra entre las publicaciones del usuario"
	self
		should: [ usuarioLeandro preguntasRealizadas
				detect: [ :p | p titulo = '¿Cual es la capital de Italia?' ] ]
		raise: Error.	"La pregunta no debería encontrarse entre las publicaciones del usuario"
	self
		should: [ usuarioLeandro respuestasRealizadas
				detect: [ :r | r texto = 'Idem' ] ]
		raise: Error	"La respuesta no debería encontrarse entre las publicaciones del usuario"
]

{ #category : #tests }
TestUsuario >> testAgregarTopicoDeInteres [
	self
		assert:
			(usuarioLeandro intereses
				detect: [ :top | top nombre = 'Programacion' ]) notNil.	"El topico se encuentra entre los topicos de interes del usuario"
	self
		should:
			[ usuarioLeandro intereses detect: [ :top | top nombre = 'Geografia' ] ]
		raise: Error	"El topico no debería encontrarse entre los topicos de interes del usuario"
]

{ #category : #tests }
TestUsuario >> testBorrarPregunta [
	self
		assert: (usuarioCatherine borrarPregunta: preguntaDeProgramacion)
		equals: true.	"La pregunta se encuentra dentro de la coleccion de publicaciones entonces se quita de la misma y retorna true"
	self
		assert: (usuarioCatherine publicaciones includes: preguntaDeProgramacion)
		equals: false.	"La pregunta no deberia encontrarse dentro de las publicaciones del usuario"
	self
		assert: (usuarioCatherine borrarPregunta: preguntaDeGeografia)
		equals: false	"Al intentar borrar la pregunta no se encuentra dentro de la coleccion de publicaciones entonces retorna false"
]

{ #category : #tests }
TestUsuario >> testBorrarRespuesta [
self
		assert: (usuarioLeandro borrarRespuesta: respuesta1PreguntaProgramacion)
		equals: true.	"La respuesta se encuentra dentro de la coleccion de publicaciones entonces se quita de la misma y retorna true"
	self
		assert: (usuarioLeandro publicaciones includes: respuesta1PreguntaProgramacion)
		equals: false.	"La respuesta no deberia encontrarse dentro de las publicaciones del usuario"
	self
		assert: (usuarioLeandro borrarRespuesta: respuesta2PreguntaProgramacion)
		equals: false	"Al intentar borrar la respuesta no se encuentra dentro de la coleccion de publicaciones entonces retorna false"
]

{ #category : #tests }
TestUsuario >> testObtenerPreguntasRelevantes [
	"self
		assert:
			(usuarioLeandro obtenerPreguntasRelevantes
				detect: [ :p | p titulo = '¿Alguien sabe test de unidad?' ])
				notNil."	"La pregunta se encuentra entre las preguntas relevantes del usuario porque le interesa el topico"
	"self
		assert:
			(usuarioLeandro obtenerPreguntasRelevantes
				detect: [ :p | p titulo = '¿Cual es la capital de Italia?' ])
				notNil."	"La pregunta se encuentra entre las preguntas relevantes del usuario porque sigue al usuario que la realizo"
	"self
		should: [ usuarioLeandro obtenerPreguntasRelevantes
				detect: [ :p | p titulo = '¿Cómo caminar en tacones?' ] ]
		raise: Error	""La pregunta no pertenece a un topico de su interes ni fue realizada por un usuario al que sigue"
]

{ #category : #tests }
TestUsuario >> testPreguntasDeInteres [
	self
		assert:
			(usuarioLeandro preguntasDeInteres
				detect: [ :p | p titulo = '¿Alguien sabe test de unidad?' ])
				notNil	"La pregunta es de interes para el usuario Leandro porque pertenece al topico que le interesa"
]

{ #category : #tests }
TestUsuario >> testPreguntasDeSeguidos [
	self
		assert:
			(usuarioLeandro preguntasDeSeguidos 
				detect: [ :p | p titulo = '¿Cual es la capital de Italia?' ])
				notNil	"La pregunta es de interes para el usuario Leandro porque pertenece al usuario que sigue"
]

{ #category : #tests }
TestUsuario >> testSeguirAlUsuario [
	self
		assert:
			(usuarioLeandro seguidos
				detect: [ :usuario | usuario nombre = 'Mariano' ]) notNil.	"El usuario Leandro sigue al usuario Mariano."
	self
		should: [ usuarioMariano seguidos
				detect: [ :usuario | usuario nombre = 'Leandro' ] ]
		raise: Error "El usuario Mariano no sigue al usuario Leandro. La relacion no es reciproca."
]
