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
	usuarioCatherine := cuoora crearNuevoUsuario: 'Catherine' cont:'1234'.
	usuarioLeandro := cuoora crearNuevoUsuario: 'Leandro' 	cont:'2345'.
	usuarioMariano := cuoora crearNuevoUsuario: 'Mariano' 	cont:'3456'.
	usuarioLeandro seguir: usuarioMariano.
	topicoProgramacion := cuoora agregarTopico: 'Programacion' descripcion:'Preguntas referidas a la programación en informática'.
	topicoGeografia := cuoora agregarTopico: 'Geografia' descripcion:'Preguntas referidas a geografia'.
	cuoora registrarTopInteres: topicoProgramacion a: usuarioLeandro.
	preguntaDeTopico := cuoora agregarPregunta:'¿Alguien sabe test de unidad?' Descrip:'Test para OO2' usu:usuarioCatherine topics:(OrderedCollection with: topicoProgramacion).
	preguntaDeUsuario := cuoora agregarPregunta:'¿Cual es la capital de Italia?' Descrip:'Del topico geografia' usu:usuarioMariano topics:(OrderedCollection with: topicoGeografia ).
	
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
