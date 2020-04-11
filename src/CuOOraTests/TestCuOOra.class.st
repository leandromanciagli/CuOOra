Class {
	#name : #TestCuOOra,
	#superclass : #TestCase,
	#instVars : [
		'cuoora',
		'preg1',
		'preg2',
		'preg3',
		'usu1',
		'usu2',
		'usu3',
		'top1',
		'top2',
		'top3'
	],
	#category : #CuOOraTests
}

{ #category : #running }
TestCuOOra >> setUp [ 
	super setUp.
	cuoora := CuOOra new.
	usu1 := cuoora crearUsuarioConNombre: 'Catherine' yContrasena:'1234'.
	usu2 := cuoora crearUsuarioConNombre: 'Leandro' 	yContrasena:'2345'.
	usu3 := cuoora crearUsuarioConNombre: 'Mariano' 	yContrasena:'3456'. 
	usu1 seguirAlUsuario: usu2.
	top1 := cuoora crearTopicoConNombre: 'Programacion' yDescripcion:'patrones'.
	top2 := cuoora crearTopicoConNombre: 'Cocina' yDescripcion:'Arroz con pollo'.
	cuoora registrarTopicoDeInteres: top1 aUsuario: usu1.
	cuoora registrarTopicoDeInteres: top2 aUsuario: usu2.  
	usu1 seguirAlUsuario: usu3.
	preg1:= cuoora crearPreguntaConTitulo: '¿Como hacer arroz con pollo' descripcion:'el aderezo'  porUsuario:usu1  yTopicos:(OrderedCollection with: top1).
	cuoora crearRespuestaConTexto: 'mezclarlos' aPregunta:preg1  porUsuario:usu1.
	preg2:= cuoora crearPreguntaConTitulo: 'prueba por topico' descripcion:'lo es'  porUsuario:usu2  yTopicos:(OrderedCollection with: top2). 
	preg3:= cuoora crearPreguntaConTitulo: 'prueba por seguidores' descripcion:'lo es'  porUsuario:usu3  yTopicos:(OrderedCollection with: top1). 
]

{ #category : #tests }
TestCuOOra >> testAgregarPregunta [
	self
		assert:
			(usu1 preguntasRealizadas
				detect: [ :a | a titulo = '¿Como hacer arroz con pollo?' ]) notNil
]

{ #category : #tests }
TestCuOOra >> testAgregarRespuesta [
	
	self assert: (usu1 respuestasRealizadas detect: [:a | a texto = 'mezclarlos'] )notNil.

]

{ #category : #tests }
TestCuOOra >> testAgregarTopico [
	"El topico 'Programacion' deberia estar agregado correctamente en la coleccion de topicos de cuoora"

	self
		assert: (cuoora topicos detect: [ :t | t nombre = 'Programacion' ]) notNil
]

{ #category : #tests }
TestCuOOra >> testBorrarPregunta [
	|q|
	cuoora crearPreguntaConTitulo:'Como multiplicar matrices'  descripcion:'eso.' porUsuario: usu1 yTopicos:(OrderedCollection with:top1).
	q:= ((usu1 preguntasRealizadas) detect: [:pre | pre titulo ='Como multiplicar matrices'] ifNone: [nil] ).
	self assert: q notNil. "la pregunta existe"
	
	cuoora borrarPregunta: q.
	
	q:= ((usu2 preguntasRealizadas) detect: [:qu | qu titulo='Como multiplicar matrices'] ifNone: [nil]).
	
	self assert: q isNil. "la pregunta ya no existe"
 

]

{ #category : #tests }
TestCuOOra >> testCrearNuevoUsuario [
	"El usuario 'Leandro' deberia estar agregado correctamente en la coleccion de usuarios de cuoora"

	self
		assert: (cuoora usuarios detect: [ :u | u nombre = 'Leandro' ]) notNil
]

{ #category : #tests }
TestCuOOra >> testRegistrarTopicoDeInteres [ 
	self assert: ( usu1 intereses detect: [:i | i nombre = 'Programacion'] )notNil.



]
