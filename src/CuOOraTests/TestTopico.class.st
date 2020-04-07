Class {
	#name : #TestTopico,
	#superclass : #TestCase,
	#instVars : [
		'cuoora',
		'usuarioCatherine',
		'usuarioLeandro',
		'usuarioMariano',
		'topicoProgramacion',
		'preguntaDeProgramacion1',
		'preguntaDeProgramacion2',
		'preguntaDeProgramacion3',
		'preguntaDeGeografia1',
		'topicoGeografia'
	],
	#category : #CuOOraTests
}

{ #category : #running }
TestTopico >> setUp [ 
	super setUp.
	cuoora := CuOOra new.
	usuarioCatherine := cuoora crearNuevoUsuario: 'Catherine' cont:'1234'.
	usuarioLeandro := cuoora crearNuevoUsuario: 'Leandro' 	cont:'2345'.
	usuarioMariano := cuoora crearNuevoUsuario: 'Mariano' 	cont:'3456'.
	topicoProgramacion := cuoora agregarTopico: 'Programacion' descripcion:'Preguntas referidas a la programación en informática'.
	topicoGeografia := cuoora agregarTopico: 'Geografia' descripcion:'Preguntas referidas a geografia'.
	preguntaDeProgramacion1 := cuoora agregarPregunta:'¿Alguien sabe test de unidad?' Descrip:'Test para OO2' usu:usuarioCatherine topics:(OrderedCollection with: topicoProgramacion).
	preguntaDeProgramacion2 := cuoora agregarPregunta:'¿Que es programar?' Descrip:'Definicion' usu:usuarioMariano topics:(OrderedCollection with: topicoProgramacion ).
	preguntaDeProgramacion3 := cuoora agregarPregunta:'¿Que es la POO?' Descrip:'Definir paradigma' usu:usuarioCatherine topics:(OrderedCollection with: topicoProgramacion).
	preguntaDeGeografia1 := cuoora agregarPregunta:'¿Cual es la capital de Italia?' Descrip:'Del topico geografia' usu:usuarioMariano topics:(OrderedCollection with: topicoGeografia ).
]

{ #category : #tests }
TestTopico >> testTodasLasPreguntas [
	self
		assert:
			(topicoProgramacion todasLasPreguntas
				detect: [ :p | p titulo = '¿Alguien sabe test de unidad?' ])
				notNil.	"La pregunta se encuentra porque pertenece al topico"
	self
		should: [ topicoProgramacion todasLasPreguntas
				detect: [ :p | p titulo = '¿Cual es la capital de Italia?' ] ]
		raise: Error
]
