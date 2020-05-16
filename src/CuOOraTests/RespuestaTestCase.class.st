Class {
	#name : #RespuestaTestCase,
	#superclass : #TestCase,
	#instVars : [
		'usuarioCatherine',
		'usuarioLeandro',
		'respuestaDeLeandro',
		'respuestaDeLeandro2',
		'publicacionVotada',
		'reaccionDeCatherine'
	],
	#category : #CuOOraTests
}

{ #category : #running }
RespuestaTestCase >> setUp [
	super setUp.
	
	"Se crean 2 usuarios"
	usuarioCatherine := Usuario nuevoConNombre: 'Catherine' yContrasena: 'laContrasenaDeCatherine'.
	usuarioLeandro := Usuario nuevoConNombre: 'Leandro' yContrasena: 'laContrasenaDeLeandro'.
	
	"Se crean 3 respuestas"
	respuestaDeLeandro := Respuesta nuevaConTexto: 'POO se basa en objetos que se mandan mensajes entre si' aPregunta: nil porUsuario: usuarioLeandro.
	respuestaDeLeandro2 := Respuesta nuevaConTexto: 'Objeto - Mensaje' aPregunta: nil porUsuario: usuarioLeandro.
	publicacionVotada := Respuesta nuevaConTexto: 'La POO es un paradigma de programación' aPregunta: nil porUsuario: usuarioLeandro.
	
	"Se registran reacciones a las respuestas"
	reaccionDeCatherine := respuestaDeLeandro registrarLikeDelUsuario: usuarioCatherine.
	respuestaDeLeandro registrarLikeDelUsuario: usuarioLeandro.
]

{ #category : #tests }
RespuestaTestCase >> testAgregarReaccion [
	self
		assert:
			( respuestaDeLeandro reacciones
				detect: [ :reaccion | reaccion usuario nombre = 'Leandro' ])
				notNil.	"Existe una reaccion del usuario Leandro en la coleccion de reacciones de la respuesta"
	self
		should: [ respuestaDeLeandro2 reacciones
				detect: [ :reaccion | reaccion usuario = 'Leandro' ] ]
		raise: Error	 "No deberia existir una reaccion del usuario Leandro para la respuesta"

]

{ #category : #tests }
RespuestaTestCase >> testBuscarReaccionDelUsuario [
	self
		assert:
			(respuestaDeLeandro
				buscarReaccionDelUsuario: usuarioCatherine)
		equals: reaccionDeCatherine.
	self
		assert:
			(respuestaDeLeandro2
				buscarReaccionDelUsuario: usuarioLeandro)
		equals: nil
]

{ #category : #tests }
RespuestaTestCase >> testEsDelUsuario [
	self
		assert: respuestaDeLeandro usuario == usuarioLeandro
		equals: true.
	self
		should: [ respuestaDeLeandro usuario == usuarioCatherine
				equals: false ]
		raise: Error
]

{ #category : #tests }
RespuestaTestCase >> testPuntaje [
	| puntajeRespuesta puntajeReal puntajeFalso |
	puntajeRespuesta := publicacionVotada puntaje.
	puntajeReal := 0.
	puntajeFalso := 87.
	self assert: puntajeRespuesta equals: puntajeReal.
	self should: [ puntajeRespuesta equals: puntajeFalso ] raise: Error
]

{ #category : #tests }
RespuestaTestCase >> testRegistrarLikeDelUsuario [
	self assert: reaccionDeCatherine estado equals: true.
	self
		should: [ reaccionDeCatherine estado equals: false ]
		raise: Error.
	self
		assert:
			(respuestaDeLeandro reacciones
				detect: [ :reaccion | reaccion usuario = usuarioLeandro ]) notNil.
	self
		should: [ respuestaDeLeandro2 reacciones
				detect: [ :reaccion | reaccion usuario = usuarioCatherine ] ]
		raise: Error
]
