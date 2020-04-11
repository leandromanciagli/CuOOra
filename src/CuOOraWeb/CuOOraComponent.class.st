Class {
	#name : #CuOOraComponent,
	#superclass : #WAComponent,
	#instVars : [
		'cuoora',
		'loginComponent',
		'homeComponent',
		'preguntaComponent',
		'usuario'
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
	| top top2 topicos usuarioCatherine usuarioLeandro respuesta pregunta1 pregunta2 pregunta3 pregunta4 pregunta5 pregunta6 pregunta7 pregunta8 |
	CuOOra clearInstancia.
	cuoora := CuOOra instancia.
	usuarioCatherine := cuoora crearUsuarioConNombre: 'Catherine' yContrasena:'1234'.
	usuarioLeandro := cuoora crearUsuarioConNombre: 'Leandro' yContrasena:'lacontraseña'.
	top := cuoora crearTopicoConNombre: 'topico1' yDescripcion:'vamos a verla'.
	top2 := cuoora crearTopicoConNombre: 'topico2' yDescripcion: 'Es el topico2'.
	cuoora registrarTopicoDeInteres: top aUsuario: usuarioCatherine.
	topicos:=OrderedCollection new.
	topicos add:top.
	pregunta1 := cuoora crearPreguntaConTitulo:'pregunta 1' descripcion:'es relevante y debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	pregunta2 := cuoora crearPreguntaConTitulo:'pregunta 2' descripcion:'es relevante y debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	pregunta3 := cuoora crearPreguntaConTitulo:'pregunta 3' descripcion:'es relevante y debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	pregunta4 := cuoora crearPreguntaConTitulo:'pregunta 4' descripcion:'es relevante y debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	pregunta5 := cuoora crearPreguntaConTitulo:'pregunta 5' descripcion:'es relevante y debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	pregunta6 := cuoora crearPreguntaConTitulo:'pregunta 6' descripcion:'es relevante y debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	pregunta7 := cuoora crearPreguntaConTitulo:'pregunta 7' descripcion:'es relevante pero no debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	pregunta8 := cuoora crearPreguntaConTitulo:'pregunta 8' descripcion:'es relevante pero no debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	respuesta := cuoora crearRespuestaConTexto:'respuesta a la pregunta 1' aPregunta:pregunta1 porUsuario:usuarioCatherine.
	cuoora registrarReaccionDelUsuario: usuarioCatherine aPublicacion: pregunta1 conVoto:false.
	
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
		
	"nbvgccg"
]

{ #category : #accessing }
CuOOraComponent >> usuario [
	^ usuario
]

{ #category : #accessing }
CuOOraComponent >> usuario: anObject [
	usuario := anObject
]
