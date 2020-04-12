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
		'respuestaPregunta1'
	],
	#category : #CuOOraTests
}

{ #category : #running }
TestCuOOra >> setUp [ 
	super setUp.
	cuoora := CuOOra new.
	usuarioCatherine := cuoora crearUsuarioConNombre: 'Catherine' yContrasena:'1234'.
	usuarioLeandro := cuoora crearUsuarioConNombre: 'Leandro' yContrasena:'2345'.
	usuarioMariano := cuoora crearUsuarioConNombre: 'Mariano' yContrasena:'3456'.
		
	topicoProgramacion := cuoora crearTopicoConNombre: 'Programacion' yDescripcion:'patrones'.
	topicoPOO := cuoora crearTopicoConNombre: 'POO' yDescripcion:'Programacion orientada a objetos'.
	topicoCocina := cuoora crearTopicoConNombre: 'Cocina' yDescripcion:'Arroz con pollo'.
	
	cuoora registrarTopicoDeInteres: topicoProgramacion aUsuario: usuarioCatherine.
	cuoora registrarTopicoDeInteres: topicoCocina aUsuario: usuarioLeandro.
	usuarioCatherine seguirAlUsuario: usuarioLeandro.
	usuarioCatherine seguirAlUsuario: usuarioMariano.
	
	pregunta1:= cuoora crearPreguntaConTitulo: '¿Que es la POO?' descripcion: 'Funcionamiento del paradigma' porUsuario: usuarioCatherine yTopicos:(OrderedCollection with: topicoProgramacion with: topicoPOO).
	pregunta2:= cuoora crearPreguntaConTitulo: 'prueba por topico' descripcion: 'lo es' porUsuario: usuarioLeandro  yTopicos: (OrderedCollection with: topicoCocina).
	pregunta3:= cuoora crearPreguntaConTitulo: 'prueba por seguidores' descripcion: 'lo es' porUsuario: usuarioMariano yTopicos: (OrderedCollection with: topicoProgramacion).
	
	respuestaPregunta1 := cuoora crearRespuestaConTexto: 'Es un conjunto de objetos que se mandan mensajes entre si' aPregunta: pregunta1 porUsuario: usuarioLeandro. 
	






]

{ #category : #tests }
TestCuOOra >> testBorrarPregunta [
	|q|
	cuoora crearPreguntaConTitulo:'Como multiplicar matrices'  descripcion:'eso.' porUsuario: usuarioCatherine yTopicos:(OrderedCollection with:topicoProgramacion).
	q:= ((usuarioCatherine preguntasRealizadas) detect: [:pre | pre titulo ='Como multiplicar matrices'] ifNone: [nil] ).
	self assert: q notNil. "la pregunta existe"
	
	cuoora borrarPregunta: q.
	
	q:= ((usuarioLeandro preguntasRealizadas) detect: [:qu | qu titulo='Como multiplicar matrices'] ifNone: [nil]).
	
	self assert: q isNil. "la pregunta ya no existe"
 

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
		assert: (cuoora topicos detect: [ :t | t nombre = 'Programacion' ]) notNil
]

{ #category : #tests }
TestCuOOra >> testCrearUsuario [
	"El usuario 'Leandro' deberia estar agregado correctamente en la coleccion de usuarios de cuoora"

	self
		assert: (cuoora usuarios detect: [ :u | u nombre = 'Leandro' ]) notNil
]

{ #category : #tests }
TestCuOOra >> testRegistrarTopicoDeInteres [ 
	self assert: ( usuarioCatherine intereses detect: [:i | i nombre = 'Programacion'] )notNil.



]
