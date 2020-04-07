Class {
	#name : #CuOOraComponent,
	#superclass : #WAComponent,
	#instVars : [
		'cuoora',
		'loginComponent',
		'homeComponent',
		'usuario',
		'preguntaComponent'
	],
	#classInstVars : [
		'instancia'
	],
	#category : #CuOOraWeb
}

{ #category : #'as yet unclassified' }
CuOOraComponent class >> clearInstancia [ 
	instancia := nil.
]

{ #category : #'class initialization' }
CuOOraComponent class >> initialize [ 	
	"CuOOraComponent initialize"
	WAAdmin register: self asApplicationAt: 'cuoora'.
]

{ #category : #accessing }
CuOOraComponent class >> instancia [
	^ instancia ifNil: [ instancia := self new ]
					ifNotNil: [ instancia ].
]

{ #category : #accessing }
CuOOraComponent >> homeComponent [
	^ homeComponent
]

{ #category : #initialization }
CuOOraComponent >> initialize [ 
	super initialize.
	self instanciarCuOOra.
	homeComponent := HomeComponent new.
	loginComponent := LoginComponent new.
	preguntaComponent := PreguntaComponent new.
	
	
	

]

{ #category : #'as yet unclassified' }
CuOOraComponent >> instanciarCuOOra [
	| top topicos usu preg respuesta preg1 |
	CuOOra clearInstancia.
	cuoora := CuOOra instancia.
	usu := cuoora crearNuevoUsuario: 'Catherine' cont:'1234'.
	top := cuoora agregarTopico: 'topico1' descripcion:'vamos a verla'.
	cuoora registrarTopInteres: top a: usu.
	topicos:=OrderedCollection new.
	topicos add:top.
	preg := cuoora agregarPregunta:'¿que es?' Descrip:'la pregunta 1'  usu:usu  topics:topicos.
	preg1 := cuoora agregarPregunta:'¿que es uno?' Descrip:'la pregunta 1'  usu:usu  topics:topicos.
	respuesta := cuoora agregarRespuesta: 'una Droga' de:preg usu: usu.
	cuoora registrarReaccionDe: usu a: preg conVoto:false.
	
]

{ #category : #accessing }
CuOOraComponent >> loginComponent [
	^ loginComponent
]

{ #category : #accessing }
CuOOraComponent >> preguntaComponent [
	^ preguntaComponent
]

{ #category : #rendering }
CuOOraComponent >> renderContentOn: html [
	html paragraph: 'Bienvenido a Cuoora'.
	usuario
		ifNil: [ html div with: self loginComponent ]
		ifNotNil: [ html div with: self homeComponent ]
]

{ #category : #accessing }
CuOOraComponent >> usuario [
	^ usuario
]

{ #category : #accessing }
CuOOraComponent >> usuario: anObject [
	usuario := anObject
]
