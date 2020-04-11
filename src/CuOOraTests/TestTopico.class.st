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
	usuarioCatherine := cuoora crearUsuarioConNombre: 'Catherine' yContrasena:'1234'.
	usuarioLeandro := cuoora crearUsuarioConNombre: 'Leandro' 	yContrasena:'2345'.
	usuarioMariano := cuoora crearUsuarioConNombre: 'Mariano' 	yContrasena:'3456'.
	topicoProgramacion := cuoora crearTopicoConNombre: 'Programacion' yDescripcion:'Preguntas referidas a la programación en informática'.
	topicoGeografia := cuoora crearTopicoConNombre: 'Geografia' yDescripcion:'Preguntas referidas a geografia'.
	preguntaDeProgramacion1 := cuoora crearPreguntaConTitulo:'¿Alguien sabe test de unidad?' descripcion:'Test para OO2' porUsuario:usuarioCatherine yTopicos:(OrderedCollection with: topicoProgramacion).
	preguntaDeProgramacion2 := cuoora crearPreguntaConTitulo:'¿Que es programar?' descripcion:'Definicion' porUsuario:usuarioMariano yTopicos:(OrderedCollection with: topicoProgramacion ).
	preguntaDeProgramacion3 := cuoora crearPreguntaConTitulo:'¿Que es la POO?' descripcion:'Definir paradigma' porUsuario:usuarioCatherine yTopicos:(OrderedCollection with: topicoProgramacion).
	preguntaDeGeografia1 := cuoora crearPreguntaConTitulo:'¿Cual es la capital de Italia?' descripcion:'Del topico geografia' porUsuario:usuarioMariano yTopicos:(OrderedCollection with: topicoGeografia ).
]

{ #category : #tests }
TestTopico >> testTodasLasPreguntas [
	self
		assert:
			(topicoProgramacion preguntas
				detect: [ :p | p titulo = '¿Alguien sabe test de unidad?' ])
				notNil.	"La pregunta se encuentra porque pertenece al topico"
	self
		should: [ topicoProgramacion preguntas
				detect: [ :p | p titulo = '¿Cual es la capital de Italia?' ] ]
		raise: Error
]
