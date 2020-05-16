Class {
	#name : #UsuarioTestCase,
	#superclass : #TestCase,
	#instVars : [
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
		'respuesta2PreguntaProgramacion',
		'respuesta1PreguntaGeografia',
		'respuesta1PreguntaModa',
		'respuesta2PreguntaModa'
	],
	#category : #CuOOraTests
}

{ #category : #running }
UsuarioTestCase >> setUp [ 
	super setUp.

	"Se crean 3 usuarios"
	usuarioLeandro := Usuario nuevoConNombre: 'Leandro' 	yContrasena: 'laContrasenaDeLeandro'.
	usuarioCatherine := Usuario nuevoConNombre: 'Catherine' yContrasena: 'laContrasenaDeCatherine'.
	usuarioMariano := Usuario nuevoConNombre: 'Mariano' 	yContrasena: 'laContrasenaDeMariano'.
	
	usuarioLeandro seguirAlUsuario: usuarioMariano.
	
	"Se crean 3 topicos"
	topicoProgramacion := Topico nuevoConNombre: 'Programacion' yDescripcion: 'Preguntas referidas a la programación en informática'.
	topicoGeografia := Topico nuevoConNombre: 'Geografia' yDescripcion: 'Preguntas referidas a geografia'.
	topicoModa := Topico nuevoConNombre: 'Moda' yDescripcion: 'Preguntas referidas a Moda'.
	
	usuarioLeandro agregarTopicoDeInteres: topicoProgramacion.
	usuarioCatherine agregarTopicoDeInteres: topicoGeografia.
	
	"Se crean 3 preguntas"
	preguntaDeProgramacion := Pregunta nuevaConTitulo: '¿Alguien sabe test de unidad?' descripcion: 'Test para OO2' porUsuario: usuarioCatherine yTopicos:(OrderedCollection with: topicoProgramacion).
	usuarioCatherine agregarPregunta: preguntaDeProgramacion.
	topicoProgramacion agregarPregunta: preguntaDeProgramacion.
	
	preguntaDeGeografia := Pregunta nuevaConTitulo: '¿Cual es la capital de Italia?' descripcion: 'Del topico geografia' porUsuario: usuarioMariano yTopicos:(OrderedCollection with: topicoGeografia).
	usuarioMariano agregarPregunta: preguntaDeGeografia.
	topicoGeografia agregarPregunta: preguntaDeGeografia.
	
	preguntaDeModa := Pregunta nuevaConTitulo: '¿Cómo caminar en tacones?' descripcion: 'Del topico moda' porUsuario: usuarioCatherine yTopicos:(OrderedCollection with: topicoModa).
	usuarioCatherine agregarPregunta: preguntaDeModa.
	topicoModa agregarPregunta: preguntaDeModa.
	
	"Se crean 5 respuestas"
	respuesta1PreguntaProgramacion := Respuesta nuevaConTexto: 'Si, yo!' aPregunta: preguntaDeProgramacion porUsuario: usuarioLeandro.
	respuesta2PreguntaProgramacion := Respuesta nuevaConTexto: 'Idem' aPregunta: preguntaDeProgramacion porUsuario: usuarioMariano.
	respuesta1PreguntaGeografia := Respuesta nuevaConTexto: 'Roma' aPregunta: preguntaDeGeografia porUsuario: usuarioCatherine.
	respuesta1PreguntaModa := Respuesta nuevaConTexto: 'No lo sé' aPregunta: preguntaDeModa porUsuario: usuarioLeandro.
	respuesta2PreguntaModa := Respuesta nuevaConTexto: 'Yo tampoco' aPregunta: preguntaDeModa porUsuario: usuarioMariano.
	
	preguntaDeProgramacion agregarRespuesta: respuesta1PreguntaProgramacion.
	preguntaDeProgramacion agregarRespuesta: respuesta2PreguntaProgramacion.
	preguntaDeGeografia agregarRespuesta: respuesta1PreguntaGeografia.
	preguntaDeModa agregarRespuesta: respuesta1PreguntaModa.
	preguntaDeModa agregarRespuesta: respuesta2PreguntaModa.
	
	usuarioLeandro agregarRespuesta: respuesta1PreguntaProgramacion.
	usuarioMariano agregarRespuesta: respuesta2PreguntaProgramacion.
	usuarioCatherine agregarRespuesta: respuesta1PreguntaGeografia.
	usuarioLeandro agregarRespuesta: respuesta1PreguntaModa.
	usuarioMariano agregarRespuesta: respuesta2PreguntaModa.
		
	"Se registran reacciones de los usuarios a las preguntas y respuestas"
	preguntaDeProgramacion registrarDislikeDelUsuario: usuarioLeandro.
	preguntaDeProgramacion registrarDislikeDelUsuario: usuarioMariano.
	preguntaDeGeografia registrarLikeDelUsuario: usuarioCatherine.
	preguntaDeModa registrarDislikeDelUsuario: usuarioLeandro.
	preguntaDeModa registrarDislikeDelUsuario: usuarioMariano.
	respuesta1PreguntaGeografia registrarLikeDelUsuario: usuarioLeandro.
	respuesta1PreguntaGeografia registrarLikeDelUsuario: usuarioMariano.
	
]

{ #category : #tests }
UsuarioTestCase >> testAgregarPregunta [
	self
		assert:
			(usuarioCatherine preguntasRealizadas
				detect: [ :pregunta | pregunta titulo = '¿Alguien sabe test de unidad?' ])
				notNil.	"La pregunta se encuentra entre las preguntas del usuario"
	self
		should: [ usuarioLeandro preguntasRealizadas
				detect: [ :pregunta | pregunta titulo = '¿Cual es la capital de Italia?' ] ]
		raise: Error	"La pregunta no debería encontrarse entre las publicaciones del usuario"
]

{ #category : #tests }
UsuarioTestCase >> testAgregarTopicoDeInteres [
	self
		assert:
			(usuarioLeandro topicosDeInteres
				detect: [ :topico | topico nombre = 'Programacion' ]) notNil.	"El topico se encuentra entre los topicos de interes del usuario"
	self
		should:
			[ usuarioLeandro topicosDeInteres detect: [ :topico | topico nombre = 'Geografia' ] ]
		raise: Error	"El topico no debería encontrarse entre los topicos de interes del usuario"
]

{ #category : #tests }
UsuarioTestCase >> testBorrarPregunta [
	| preguntaDeCatherine |
	
	preguntaDeCatherine := Pregunta 
		nuevaConTitulo: '¿Como multiplicar matrices?' 
	   descripcion: 'En Pascal' 
	   porUsuario: usuarioCatherine 
	   yTopicos: (OrderedCollection with: topicoProgramacion).
	usuarioCatherine agregarPregunta: preguntaDeCatherine.
	
	preguntaDeCatherine := usuarioCatherine preguntasRealizadas
		detect: [ :pregunta | pregunta titulo = '¿Como multiplicar matrices?' ]
		ifNone: [ nil ].
		
	self assert: preguntaDeCatherine notNil.	"La pregunta debería existir"
	
	usuarioCatherine borrarPregunta: preguntaDeCatherine.	"Se borra la pregunta"
		
	preguntaDeCatherine := usuarioCatherine preguntasRealizadas
		detect: [ :pregunta | pregunta titulo = '¿Como multiplicar matrices?' ]
		ifNone: [ nil ].
		
	self assert: preguntaDeCatherine isNil.	"La pregunta ya no debería existir en la coleccion de preguntas del usuario"
		
	preguntaDeCatherine := topicoProgramacion preguntas
		detect: [ :pregunta | pregunta titulo = '¿Como multiplicar matrices?' ]
		ifNone: [ nil ].
		
	self assert: preguntaDeCatherine isNil.	"La pregunta ya no debería existir en la coleccion de preguntas del topico"


]

{ #category : #tests }
UsuarioTestCase >> testCalcularPuntaje [
	"puntajeCatherine = 20 + 20 + 50 + (-2) + 2 + (-2) = 88"

	| puntajeCatherine puntajeReal puntajeFalso |
	puntajeCatherine := usuarioCatherine calcularPuntaje.
	puntajeReal := 88.
	puntajeFalso := 87.
	self assert: puntajeCatherine equals: puntajeReal.
	self should: [ puntajeCatherine equals: puntajeFalso ] raise: Error
]

{ #category : #tests }
UsuarioTestCase >> testObtenerPreguntasRelevantes [

	self
		assert:
			(usuarioLeandro obtenerPreguntasRelevantes
				detect: [ :pregunta | pregunta titulo = '¿Alguien sabe test de unidad?' ])
				notNil.	"La pregunta se encuentra entre las preguntas relevantes del usuario porque le interesa el topico"
	self
		assert:
			(usuarioLeandro obtenerPreguntasRelevantes
				detect: [ :pregunta | pregunta titulo = '¿Cual es la capital de Italia?' ])
				notNil.	"La pregunta se encuentra entre las preguntas relevantes del usuario porque sigue al usuario que la realizo"
	self
		should: [ usuarioLeandro obtenerPreguntasRelevantes
				detect: [ :pregunta | pregunta titulo = '¿Cómo caminar en tacones?' ] ]
		raise: Error	."La pregunta no pertenece a un topico de su interes ni fue realizada por un usuario al que sigue"
			
		
]

{ #category : #tests }
UsuarioTestCase >> testPreguntasDeInteres [
	self
		assert:
			(usuarioLeandro preguntasDeInteres
				detect: [ :pregunta | pregunta titulo = '¿Alguien sabe test de unidad?' ])
				notNil	"La pregunta es de interes para el usuario Leandro porque pertenece al topico que le interesa"
]

{ #category : #tests }
UsuarioTestCase >> testPreguntasDeSeguidos [
	self
		assert:
			(usuarioLeandro preguntasDeSeguidos 
				detect: [ :pregunta | pregunta titulo = '¿Cual es la capital de Italia?' ])
				notNil "La pregunta es de interes para el usuario Leandro porque pertenece al usuario que sigue"
]

{ #category : #tests }
UsuarioTestCase >> testQuitarPregunta [
	self
		assert: (usuarioCatherine quitarPregunta: preguntaDeProgramacion)
		equals: true.	"La pregunta se encuentra dentro de la coleccion de publicaciones entonces se quita de la misma y se retorna"
	self
		assert: (usuarioCatherine preguntasRealizadas includes: preguntaDeProgramacion)
		equals: false.	"La pregunta no deberia encontrarse dentro de las publicaciones del usuario"
	self
		assert: (usuarioCatherine quitarPregunta: preguntaDeGeografia)
		equals: false	"Al intentar quitar la pregunta no se encuentra dentro de la coleccion de publicaciones entonces retorna false"
]

{ #category : #tests }
UsuarioTestCase >> testSeguirAlUsuario [
	self
		assert:
			(usuarioLeandro seguidos
				detect: [ :usuario | usuario nombre = 'Mariano' ]) notNil.	"El usuario Leandro sigue al usuario Mariano."
	self
		should: [ usuarioMariano seguidos
				detect: [ :usuario | usuario nombre = 'Leandro' ] ]
		raise: Error "El usuario Mariano no sigue al usuario Leandro. La relacion no es reciproca."
]
