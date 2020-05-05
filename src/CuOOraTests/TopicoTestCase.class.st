Class {
	#name : #TopicoTestCase,
	#superclass : #TestCase,
	#instVars : [
		'cuoora',
		'usuarioCatherine',
		'usuarioLeandro',
		'topicoProgramacion',
		'topicoGeografia',
		'preguntaDeProgramacion',
		'preguntaDeGeografia'
	],
	#category : #CuOOraTests
}

{ #category : #running }
TopicoTestCase >> setUp [ 
	super setUp.
	cuoora := CuOOra new.
	
	"Se crean 2 usuarios"
	usuarioCatherine := cuoora crearUsuarioConNombre: 'Catherine' yContrasena: 'laContrasenaDeCatherine'.
	usuarioLeandro := cuoora crearUsuarioConNombre: 'Leandro' 	yContrasena: 'laContrasenaDeLeandro'.
	
	"Se crean 2 topicos"
	topicoProgramacion := cuoora crearTopicoConNombre: 'Programacion' yDescripcion: 'Preguntas referidas a la programación en informática'.
	topicoGeografia := cuoora crearTopicoConNombre: 'Geografia' yDescripcion: 'Preguntas referidas a geografia'.
	
	"Se crean 2 preguntas"
	preguntaDeProgramacion := cuoora crearPreguntaConTitulo: '¿Alguien sabe test de unidad?' descripcion: 'Test para OO2' porUsuario: usuarioCatherine yTopicos:(OrderedCollection with: topicoProgramacion).
	
	preguntaDeGeografia := cuoora crearPreguntaConTitulo:'¿Cual es la capital de Italia?' descripcion:'Del topico geografia' porUsuario: usuarioLeandro yTopicos:(OrderedCollection with: topicoGeografia ).
	







]

{ #category : #tests }
TopicoTestCase >> testAgregarPregunta [
	self
		assert:
			(topicoProgramacion preguntas
				detect: [ :p | p titulo = '¿Alguien sabe test de unidad?' ])
				notNil.	"La pregunta se encuentra entre las preguntas del topico"
	self
		assert:
			(topicoGeografia preguntas
				detect: [ :p | p titulo = '¿Cual es la capital de Italia?' ])
				notNil.	"La pregunta se encuentra entre las preguntas del topico"
	self
		should: [ topicoProgramacion preguntas
				detect: [ :p | p titulo = '¿Cual es la capital de Italia?' ] ]
		raise: Error	"La pregunta se agregó al topico que se le indico y no a otro"
]

{ #category : #tests }
TopicoTestCase >> testQuitarPregunta [
	self
		assert: (topicoProgramacion quitarPregunta: preguntaDeProgramacion)
		equals: preguntaDeProgramacion.	"La pregunta se encuentra dentro de la coleccion de preguntas entonces se quita de la misma y se retorna"
	self
		assert: (topicoProgramacion preguntas includes: preguntaDeProgramacion)
		equals: false. "La pregunta no deberia encontrarse dentro de las preguntas del topico"
	self
		assert: (topicoProgramacion quitarPregunta: preguntaDeGeografia)
		equals: false	"Al intentar quitar la pregunta no se encuentra dentro de la coleccion de preguntas entonces retorna false"
]
