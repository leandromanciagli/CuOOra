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
		'top2'
	],
	#category : #CuOOra
}

{ #category : #running }
TestCuOOra >> setUp [ 
	super setUp.
	cuoora := CuOOra new.
	usu1 := cuoora crearNuevoUsuario: 'Catherine' cont:'1234'.
	usu2 := cuoora crearNuevoUsuario: 'Leandro' 	cont:'2345'.
	usu3 := cuoora crearNuevoUsuario: 'Mariano' 	cont:'3456'. 
	usu1 seguir: usu2.
	top1 := cuoora agregarTopico: 'Programacion' descripcion:'patrones'.
	top2 := cuoora agregarTopico: 'Cocina' descripcion:'Arroz con pollo'.
	cuoora registrarTopInteres: top1 a: usu1.
	cuoora registrarTopInteres: top2 a: usu2.  
	usu1 seguir: usu3.
	preg1:= cuoora agregarPregunta: '¿Como hacer arroz con pollo' Descrip:'el aderezo'  usu:usu1  topics:(OrderedCollection with: top1).
	cuoora agregarRespuesta: 'mezclarlos' de:preg1  usu:usu1.
	preg2:= cuoora agregarPregunta: 'prueba por topico' Descrip:'lo es'  usu:usu2  topics:(OrderedCollection with: top2). 
	preg3:= cuoora agregarPregunta: 'prueba por seguidores' Descrip:'lo es'  usu:usu3  topics:(OrderedCollection with: top1). 
]

{ #category : #tests }
TestCuOOra >> testAgregarRespuesta [
	
	self assert: (usu1 respuestasRealizadas detect: [:a | a texto = 'mezclarlos'] )notNil.

]

{ #category : #tests }
TestCuOOra >> testBorrarPregunta [
	|q|
	cuoora agregarPregunta:'Como multiplicar matrices'  Descrip:'eso.' usu: usu1 topics:(OrderedCollection with:top1).
	q:= ((usu1 preguntasRealizadas) detect: [:pre | pre titulo ='Como multiplicar matrices'] ifNone: [nil] ).
	self assert: q notNil. "la pregunta existe"
	
	cuoora borrarUnaPregunta: q.
	
	q:= ((usu2 preguntasRealizadas) detect: [:qu | qu titulo='Como multiplicar matrices'] ifNone: [nil]).
	
	self assert: q isNil. "la pregunta ya no existe"
 

]

{ #category : #tests }
TestCuOOra >> testRegistrarTopicoDeInteres [ 
	self assert: ( usu1 intereses detect: [:i | i nombre = 'Programacion'] )notNil.



]
