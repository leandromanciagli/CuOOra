Class {
	#name : #UsuarioTestCase,
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
	cuoora := CuOOra new.
	
	"Se crean 3 usuarios"
	usuarioLeandro := cuoora crearUsuarioConNombre: 'Leandro' 	yContrasena: 'laContrasenaDeLeandro'.
	usuarioCatherine := cuoora crearUsuarioConNombre: 'Catherine' yContrasena: 'laContrasenaDeCatherine'.
	usuarioMariano := cuoora crearUsuarioConNombre: 'Mariano' 	yContrasena: 'laContrasenaDeMariano'.
	
	usuarioLeandro seguirAlUsuario: usuarioMariano.
	
	"Se crean 3 topicos"
	topicoProgramacion := cuoora crearTopicoConNombre: 'Programacion' yDescripcion: 'Preguntas referidas a la programación en informática'.
	topicoGeografia := cuoora crearTopicoConNombre: 'Geografia' yDescripcion: 'Preguntas referidas a geografia'.
	topicoModa := cuoora crearTopicoConNombre: 'Moda' yDescripcion: 'Preguntas referidas a Moda'.
	
	usuarioLeandro agregarTopicoDeInteres: topicoProgramacion.
	
	"Se crean 3 preguntas"
	preguntaDeProgramacion := cuoora crearPreguntaConTitulo: '¿Alguien sabe test de unidad?' descripcion: 'Test para OO2' porUsuario: usuarioCatherine yTopicos:(OrderedCollection with: topicoProgramacion).
	
	preguntaDeGeografia := cuoora crearPreguntaConTitulo: '¿Cual es la capital de Italia?' descripcion: 'Del topico geografia' porUsuario: usuarioMariano yTopicos:(OrderedCollection with: topicoGeografia).
	
	preguntaDeModa := cuoora crearPreguntaConTitulo: '¿Cómo caminar en tacones?' descripcion: 'Del topico moda' porUsuario: usuarioCatherine yTopicos:(OrderedCollection with: topicoModa).
	
	"Se crean 5 respuestas"
	respuesta1PreguntaProgramacion := cuoora crearRespuestaConTexto: 'Si, yo!' aPregunta: preguntaDeProgramacion porUsuario: usuarioLeandro.
	respuesta2PreguntaProgramacion := cuoora crearRespuestaConTexto: 'Idem' aPregunta: preguntaDeProgramacion porUsuario: usuarioMariano.
	respuesta1PreguntaGeografia := cuoora crearRespuestaConTexto: 'Roma' aPregunta: preguntaDeGeografia porUsuario: usuarioCatherine.
	respuesta1PreguntaModa := cuoora crearRespuestaConTexto: 'No lo sé' aPregunta: preguntaDeModa porUsuario: usuarioLeandro.
	respuesta2PreguntaModa := cuoora crearRespuestaConTexto: 'Yo tampoco' aPregunta: preguntaDeModa porUsuario: usuarioMariano.
	
	"Se registran reacciones de los usuarios a las preguntas y respuestas"
	cuoora registrarReaccionDelUsuario: usuarioLeandro aPublicacion: preguntaDeProgramacion conVoto: false.
	cuoora registrarReaccionDelUsuario: usuarioMariano aPublicacion: preguntaDeProgramacion conVoto: false.
	cuoora registrarReaccionDelUsuario: usuarioLeandro aPublicacion: respuesta1PreguntaGeografia conVoto: true.
	cuoora registrarReaccionDelUsuario: usuarioMariano aPublicacion: respuesta1PreguntaGeografia conVoto: true.
	cuoora registrarReaccionDelUsuario: usuarioLeandro aPublicacion: preguntaDeModa conVoto: false.
	cuoora registrarReaccionDelUsuario: usuarioMariano aPublicacion: preguntaDeModa conVoto: false.
	cuoora registrarReaccionDelUsuario: usuarioCatherine aPublicacion: preguntaDeGeografia conVoto: true.
	
	
	
	
		
	
	
	
]

{ #category : #tests }
UsuarioTestCase >> testAgregarPublicacion [
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
UsuarioTestCase >> testAgregarTopicoDeInteres [
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
UsuarioTestCase >> testBorrarPublicacion [
	self
		assert: (usuarioLeandro borrarPublicacion: respuesta1PreguntaProgramacion)
		equals: true.	"La respuesta se encuentra dentro de la coleccion de publicaciones entonces se quita de la misma y retorna true"
	self
		assert:
			(usuarioLeandro publicaciones includes: respuesta1PreguntaProgramacion)
		equals: false.	"La respuesta no deberia encontrarse dentro de las publicaciones del usuario"
	self
		assert: (usuarioLeandro borrarPublicacion: respuesta2PreguntaProgramacion)
		equals: false.	"Al intentar borrar la respuesta no se encuentra dentro de la coleccion de publicaciones entonces retorna false"
	self
		assert: (usuarioCatherine borrarPublicacion: preguntaDeProgramacion)
		equals: true.	"La pregunta se encuentra dentro de la coleccion de publicaciones entonces se quita de la misma y retorna true"
	self
		assert: (usuarioCatherine publicaciones includes: preguntaDeProgramacion)
		equals: false.	"La pregunta no deberia encontrarse dentro de las publicaciones del usuario"
	self
		assert: (usuarioCatherine borrarPublicacion: preguntaDeGeografia)
		equals: false	"Al intentar borrar la pregunta no se encuentra dentro de la coleccion de publicaciones entonces retorna false"
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
| preguntaDeGeografia2 preguntaDeGeografia3 |

	self
		assert:
			(usuarioLeandro obtenerPreguntasRelevantes
				detect: [ :p | p titulo = '¿Alguien sabe test de unidad?' ])
				notNil.	"La pregunta se encuentra entre las preguntas relevantes del usuario porque le interesa el topico"
	self
		assert:
			(usuarioLeandro obtenerPreguntasRelevantes
				detect: [ :p | p titulo = '¿Cual es la capital de Italia?' ])
				notNil.	"La pregunta se encuentra entre las preguntas relevantes del usuario porque sigue al usuario que la realizo"
	self
		should: [ usuarioLeandro obtenerPreguntasRelevantes
				detect: [ :p | p titulo = '¿Cómo caminar en tacones?' ] ]
		raise: Error	."La pregunta no pertenece a un topico de su interes ni fue realizada por un usuario al que sigue"
			
	"Se crean 4 preguntas más que sean relevantes para el usuario para testear la cantidad de preguntar retornadas (como máximo 5)"
	preguntaDeGeografia2 := cuoora crearPreguntaConTitulo: '¿Cual es la capital de Marruecos?' descripcion: 'Del topico geografia' porUsuario: usuarioMariano yTopicos:(OrderedCollection with: topicoGeografia).
	preguntaDeGeografia3 := cuoora crearPreguntaConTitulo: '¿Cual es la capital de España?' descripcion: 'Del topico geografia' porUsuario: usuarioMariano yTopicos:(OrderedCollection with: topicoGeografia).
	cuoora crearPreguntaConTitulo: '¿Cual es la capital de Francia?' descripcion: 'Del topico geografia' porUsuario: usuarioMariano yTopicos:(OrderedCollection with: topicoGeografia).
	cuoora crearPreguntaConTitulo: '¿Cual es la capital de Canadá?' descripcion: 'Del topico geografia' porUsuario: usuarioMariano yTopicos:(OrderedCollection with: topicoGeografia).
	
	self assert: usuarioLeandro obtenerPreguntasRelevantes size equals: 5. "El usuario tiene 6 preguntas relevantes pero solo 5 son devueltas"
   preguntaDeGeografia2 delete. "Se borra una pregunta"
	self assert: usuarioLeandro obtenerPreguntasRelevantes size equals: 5. "El usuario tiene 5 preguntas relevantes y 5 son devueltas"
	preguntaDeGeografia3 delete. "Se borra otra pregunta"
	self assert: usuarioLeandro obtenerPreguntasRelevantes size equals: 4. "El usuario tiene 4 preguntas relevantes y 4 son devueltas"	
	
	
	
	
	
	
	
	
	
	
		
]

{ #category : #tests }
UsuarioTestCase >> testPreguntasDeInteres [
	self
		assert:
			(usuarioLeandro preguntasDeInteres
				detect: [ :p | p titulo = '¿Alguien sabe test de unidad?' ])
				notNil	"La pregunta es de interes para el usuario Leandro porque pertenece al topico que le interesa"
]

{ #category : #tests }
UsuarioTestCase >> testPreguntasDeSeguidos [
	self
		assert:
			(usuarioLeandro preguntasDeSeguidos 
				detect: [ :p | p titulo = '¿Cual es la capital de Italia?' ])
				notNil	"La pregunta es de interes para el usuario Leandro porque pertenece al usuario que sigue"
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
