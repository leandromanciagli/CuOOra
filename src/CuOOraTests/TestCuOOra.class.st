Class {
	#name : #TestCuOOra,
	#superclass : #TestCase,
	#instVars : [
		'cuoora',
		'usuarioCatherine',
		'usuarioLeandro',
		'usuarioMariano',
		'topicoProgramacion',
		'topicoPOO',
		'topicoCocina',
		'pregunta1',
		'pregunta2',
		'pregunta3',
		'respuestaPregunta1',
		'respuesta2Pregunta1',
		'respuestaPregunta2',
		'respuestaPregunta3'
	],
	#category : #CuOOraTests
}

{ #category : #running }
TestCuOOra >> setUp [ 
	super setUp.
	cuoora := CuOOra new.
	
	usuarioCatherine := cuoora crearUsuarioConNombre: 'Catherine' yContrasena:'1234'.
	usuarioLeandro := cuoora crearUsuarioConNombre: 'Leandro' yContrasena:'laContrasenaDeLeandro'.
	usuarioMariano := cuoora crearUsuarioConNombre: 'Mariano' yContrasena:'3456'.
		
	topicoProgramacion := cuoora crearTopicoConNombre: 'Programacion' yDescripcion:'patrones'.
	topicoPOO := cuoora crearTopicoConNombre: 'POO' yDescripcion:'Programacion orientada a objetos'.
	topicoCocina := cuoora crearTopicoConNombre: 'Cocina' yDescripcion:'Arroz con pollo'.
	
	cuoora registrarTopicoDeInteres: topicoProgramacion aUsuario: usuarioCatherine.
	cuoora registrarTopicoDeInteres: topicoCocina aUsuario: usuarioLeandro.
	usuarioCatherine seguirAlUsuario: usuarioLeandro.
	usuarioCatherine seguirAlUsuario: usuarioMariano.
	
	pregunta1 := cuoora crearPreguntaConTitulo: '¿Que es la POO?' descripcion: 'Funcionamiento del paradigma' porUsuario: usuarioCatherine yTopicos:(OrderedCollection with: topicoProgramacion with: topicoPOO).
	pregunta2 := cuoora crearPreguntaConTitulo: '¿Como se hace una torta?' descripcion: 'Ingredientes' porUsuario: usuarioLeandro  yTopicos: (OrderedCollection with: topicoCocina).
	pregunta3 := cuoora crearPreguntaConTitulo: '¿Que es programar?' descripcion: 'Como se hace' porUsuario: usuarioMariano yTopicos: (OrderedCollection with: topicoProgramacion).
	
	respuestaPregunta1 := cuoora crearRespuestaConTexto: 'Es un conjunto de objetos que se mandan mensajes entre si' aPregunta: pregunta1 porUsuario: usuarioLeandro.
	respuesta2Pregunta1 := cuoora crearRespuestaConTexto: 'Idem' aPregunta: pregunta1 porUsuario: usuarioMariano.
	respuestaPregunta2 := cuoora crearRespuestaConTexto: 'Con harina, leche y huevos' aPregunta: pregunta2 porUsuario: usuarioCatherine.
	respuestaPregunta3 := cuoora crearRespuestaConTexto: 'Conjunto de instrucciones para resolver un problema' aPregunta: pregunta3 porUsuario: usuarioCatherine.
	
	cuoora registrarReaccionDelUsuario: usuarioLeandro aPublicacion: pregunta1 conVoto: false.
	cuoora registrarReaccionDelUsuario: usuarioMariano aPublicacion: pregunta1 conVoto: true.
	cuoora registrarReaccionDelUsuario: usuarioLeandro aPublicacion: respuestaPregunta2 conVoto: true.
	cuoora registrarReaccionDelUsuario: usuarioMariano aPublicacion: respuestaPregunta2 conVoto: false.
	cuoora registrarReaccionDelUsuario: usuarioLeandro aPublicacion: respuestaPregunta3 conVoto: false.
	cuoora registrarReaccionDelUsuario: usuarioMariano aPublicacion: respuestaPregunta3 conVoto: false.
	cuoora registrarReaccionDelUsuario: usuarioCatherine aPublicacion: pregunta2 conVoto: true.

	






	






]

{ #category : #tests }
TestCuOOra >> testBorrarPregunta [
	| pregunta |
	cuoora
		crearPreguntaConTitulo: '¿Como multiplicar matrices?'
		descripcion: 'eso.'
		porUsuario: usuarioCatherine
		yTopicos: (OrderedCollection with: topicoProgramacion).
	pregunta := usuarioCatherine preguntasRealizadas
		detect: [ :p | p titulo = '¿Como multiplicar matrices?' ]
		ifNone: [ nil ].
	self assert: pregunta notNil.	"La pregunta debería existir"
	cuoora borrarPregunta: pregunta.
	pregunta := usuarioCatherine preguntasRealizadas
		detect: [ :p | p titulo = '¿Como multiplicar matrices?' ]
		ifNone: [ nil ].
	self assert: pregunta isNil	"La pregunta ya no debería existir"
]

{ #category : #tests }
TestCuOOra >> testBuscarTopicoConNombre [
	self
		assert: (cuoora topicos detect: [ :t | t nombre = 'Programacion' ]) notNil.
	self
		should: [ cuoora topicos detect: [ :t | t nombre = 'Moda' ] ]
		raise: Error
]

{ #category : #tests }
TestCuOOra >> testCalcularPuntajeDelUsuario [
	"puntajeCatherine = 20 + 50 + 50 + 0 + 0 + (-3) = 118"

	| puntajeCatherine puntajeReal puntajeFalso |
	puntajeCatherine := cuoora
		calcularPuntajeDelUsuario: usuarioCatherine.
	puntajeReal := 118.
	puntajeFalso := 117.
	self assert: puntajeCatherine equals: puntajeReal.
	self should: [ puntajeCatherine equals: puntajeFalso ] raise: Error
]

{ #category : #tests }
TestCuOOra >> testCrearPregunta [
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
TestCuOOra >> testCrearRespuesta [
	self
		assert:
			(usuarioLeandro respuestasRealizadas
				detect:
					[ :r | r texto = 'Es un conjunto de objetos que se mandan mensajes entre si' ])
				notNil.	"La respuesta es agregada a la coleccion de publicaciones del usuario usuarioLeandro"
	self
		assert:
			(pregunta1 obtenerRespuestasPorPuntaje
				detect:
					[ :r | r texto = 'Es un conjunto de objetos que se mandan mensajes entre si' ])
				notNil	"La respuesta es agregada a la coleccion de respuestas de la pregunta pregunta1"
]

{ #category : #tests }
TestCuOOra >> testCrearTopico [
	"El topico 'Programacion' deberia estar agregado correctamente en la coleccion de topicos de cuoora"

	self
		assert: (cuoora topicos detect: [ :top | top nombre = 'Programacion' ]) notNil
]

{ #category : #tests }
TestCuOOra >> testCrearUsuario [
	"El usuario 'Leandro' deberia estar agregado correctamente en la coleccion de usuarios de cuoora"

	self
		assert: (cuoora usuarios detect: [ :u | u nombre = 'Leandro' ]) notNil
]

{ #category : #tests }
TestCuOOra >> testObtenerPreguntasDelTopico [
	self
		assert: (cuoora obtenerPreguntasDelTopico: topicoProgramacion) size
		equals: 2.
	self
		should: [ (cuoora obtenerPreguntasDelTopico: topicoProgramacion) size
				equals: 3 ]
		raise: Error
]

{ #category : #tests }
TestCuOOra >> testRegistrarReaccionDelUsuario [
	| reaccionDeCatherine |
	reaccionDeCatherine := pregunta2
		buscarReaccionDelUsuario: usuarioCatherine.
	self assert: reaccionDeCatherine estado equals: true.
	cuoora registrarReaccionDelUsuario: usuarioCatherine aPublicacion: pregunta2 conVoto: false.
	self assert: reaccionDeCatherine estado equals: false.
]

{ #category : #tests }
TestCuOOra >> testRegistrarTopicoDeInteres [ 
	self assert: ( usuarioCatherine intereses detect: [:top | top nombre = 'Programacion'] )notNil.



]

{ #category : #tests }
TestCuOOra >> testValidarUsuario [
	self
		assert:
			(cuoora
				loginUsuario: usuarioLeandro nombre
				contrasena: usuarioLeandro contrasena) notNil.	"Debería existir el usuario"
	self
		assert:
			(cuoora loginUsuario: 'Alberto' contrasena: 'laContrasenaDeAlberto')
				isNil	"No debería existir el usuario"
]
