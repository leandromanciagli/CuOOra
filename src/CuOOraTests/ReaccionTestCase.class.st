Class {
	#name : #ReaccionTestCase,
	#superclass : #TestCase,
	#instVars : [
		'usuarioLeandro',
		'usuarioCatherine',
		'preguntaDeProgramacion',
		'topicoProgramacion',
		'reaccionDeLeandro',
		'reaccionDeCatherine'
	],
	#category : #CuOOraTests
}

{ #category : #running }
ReaccionTestCase >> setUp [
	super setUp.
	usuarioLeandro := Usuario nuevoConNombre: 'Leandro' yContrasena: 'laContrasenaDeLeandro'.
	usuarioCatherine := Usuario nuevoConNombre: 'Catherine' yContrasena: 'laContrasenaDeCatherine'.
	topicoProgramacion := Topico nuevoConNombre: 'Programacion' yDescripcion: 'Programacion en Informática'.
	preguntaDeProgramacion := Pregunta
		nuevaConTitulo: '¿Que es la POO?'
		descripcion: 'Funcionamiento del paradigma'
		porUsuario: usuarioLeandro
		yTopicos: (OrderedCollection with: topicoProgramacion).
	reaccionDeLeandro := preguntaDeProgramacion registrarLikeDelUsuario: usuarioLeandro.
	reaccionDeCatherine := preguntaDeProgramacion registrarDislikeDelUsuario: usuarioCatherine
]

{ #category : #tests }
ReaccionTestCase >> testDislike [
	self assert: reaccionDeLeandro estado equals: true.						"El estado de la reaccion del usuarioLeandro es true"
	reaccionDeLeandro dislike.														"El usuarioLeandro cambia el estado de su reaccion a la preguntaDeProgramacion"
	self assert: reaccionDeLeandro estado equals: false.						"Ahora el estado de la reaccion del usuarioLeandro para la preguntaDeProgramacion es false"
	self should: [ reaccionDeLeandro estado equals: true ] raise: Error "El estado de la reaccion es false por lo tanto decir que es true deberia ser erroneo"
	


										
	
												
]

{ #category : #tests }
ReaccionTestCase >> testLike [
	self assert: reaccionDeCatherine estado equals: false. "El estado de la reaccion del usuarioCatherine es false"
	reaccionDeCatherine like.										"El usuarioCatherine cambia el estado de su reaccion a la preguntaDeProgramacion"
	self assert: reaccionDeCatherine estado equals: true.  "Ahora el estado de la reaccion del usuarioCatherine para la preguntaDeProgramacion es true"
	self
		should: [ reaccionDeCatherine estado equals: false ]
		raise: Error 													"El estado de la reaccion es true por lo tanto decir que es false deberia ser erroneo"
]
