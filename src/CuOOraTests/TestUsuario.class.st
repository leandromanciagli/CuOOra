Class {
	#name : #TestUsuario,
	#superclass : #TestCase,
	#instVars : [
		'cuoora',
		'usuarioCatherine',
		'usuarioLeandro',
		'usuarioMariano',
		'topicoProgramacion',
		'preguntaDeTopico',
		'preguntaDeUsuario',
		'topicoGeografia'
	],
	#category : #CuOOraTests
}

{ #category : #running }
TestUsuario >> setUp [ 
	super setUp.
	cuoora := CuOOra new.
	usuarioCatherine := cuoora crearUsuarioConNombre: 'Catherine' yContrasena:'1234'.
	usuarioLeandro := cuoora crearUsuarioConNombre: 'Leandro' 	yContrasena:'2345'.
	usuarioMariano := cuoora crearUsuarioConNombre: 'Mariano' 	yContrasena:'3456'.
	usuarioLeandro seguirAlUsuario: usuarioMariano.
	topicoProgramacion := cuoora crearTopicoConNombre: 'Programacion' yDescripcion:'Preguntas referidas a la programación en informática'.
	topicoGeografia := cuoora crearTopicoConNombre: 'Geografia' yDescripcion:'Preguntas referidas a geografia'.
	cuoora registrarTopicoDeInteres: topicoProgramacion aUsuario: usuarioLeandro.
	preguntaDeTopico := cuoora crearPreguntaConTitulo:'¿Alguien sabe test de unidad?' descripcion:'Test para OO2' porUsuario:usuarioCatherine yTopicos:(OrderedCollection with: topicoProgramacion).
	preguntaDeUsuario := cuoora crearPreguntaConTitulo:'¿Cual es la capital de Italia?' descripcion:'Del topico geografia' porUsuario:usuarioMariano yTopicos:(OrderedCollection with: topicoGeografia ).
	
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
TestUsuario >> testSeguir [
	self
		assert:
			(usuarioLeandro seguidos
				detect: [ :usuario | usuario nombre = 'Mariano' ]) notNil.	"El usuario Leandro sigue al usuario Mariano."
	self
		should: [ usuarioMariano seguidos
				detect: [ :usuario | usuario nombre = 'Leandro' ] ]
		raise: Error "El usuario Mariano no sigue al usuario Leandro. La relacion no es reciproca."
]
