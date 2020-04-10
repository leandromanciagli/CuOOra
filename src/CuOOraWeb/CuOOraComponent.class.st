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
	| top topicos usuarioCatherine usuarioLeandro respuesta pregunta1 pregunta2 pregunta3 pregunta4 pregunta5 pregunta6 pregunta7 pregunta8 |
	CuOOra clearInstancia.
	cuoora := CuOOra instancia.
	usuarioCatherine := cuoora crearNuevoUsuario: 'Catherine' cont:'1234'.
	usuarioLeandro := cuoora crearNuevoUsuario: 'Leandro' cont:'lacontraseña'.
	top := cuoora agregarTopico: 'topico1' descripcion:'vamos a verla'.
	cuoora registrarTopInteres: top a: usuarioCatherine.
	topicos:=OrderedCollection new.
	topicos add:top.
	pregunta1 := cuoora agregarPregunta:'pregunta 1' Descrip:'es relevante y debe mostrarse' usu:usuarioLeandro topics:topicos.
	pregunta2 := cuoora agregarPregunta:'pregunta 2' Descrip:'es relevante y debe mostrarse' usu:usuarioLeandro topics:topicos.
	pregunta3 := cuoora agregarPregunta:'pregunta 3' Descrip:'es relevante y debe mostrarse' usu:usuarioLeandro topics:topicos.
	pregunta4 := cuoora agregarPregunta:'pregunta 4' Descrip:'es relevante y debe mostrarse' usu:usuarioLeandro topics:topicos.
	pregunta5 := cuoora agregarPregunta:'pregunta 5' Descrip:'es relevante y debe mostrarse' usu:usuarioLeandro topics:topicos.
	pregunta6 := cuoora agregarPregunta:'pregunta 6' Descrip:'es relevante y debe mostrarse' usu:usuarioLeandro topics:topicos.
	pregunta7 := cuoora agregarPregunta:'pregunta 7' Descrip:'es relevante pero no debe mostrarse' usu:usuarioLeandro topics:topicos.
	pregunta8 := cuoora agregarPregunta:'pregunta 8' Descrip:'es relevante pero no debe mostrarse' usu:usuarioLeandro topics:topicos.
	respuesta := cuoora agregarRespuesta:'respuesta a la pregunta 1' de:pregunta1 usu:usuarioCatherine.
	cuoora registrarReaccionDe: usuarioCatherine a: pregunta1 conVoto:false.
	
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
