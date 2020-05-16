Class {
	#name : #CuOOra,
	#superclass : #Object,
	#instVars : [
		'usuarios',
		'topicos'
	],
	#classInstVars : [
		'instancia'
	],
	#category : #CuOOra
}

{ #category : #clearing }
CuOOra class >> clearInstancia [ 
	instancia := nil.
]

{ #category : #'instance initialization' }
CuOOra class >> inicializarInstancia [
	| usuarioPedro usuarioDiego usuarioJuan topico1 topico2 topico3 preguntaDePedro preguntaDeDiego |
	
	"Usuarios:" 	
	usuarioPedro := instancia crearUsuarioConNombre: 'pedro@cuoora.com' yContrasena: 'pedro@cuoora.com'.
	usuarioDiego := instancia crearUsuarioConNombre: 'diego@cuoora.com' yContrasena: 'diego@cuoora.com'.
	usuarioJuan := instancia crearUsuarioConNombre: 'juan@cuoora.com' yContrasena: 'juan@cuoora.com'.

	"- Las relaciones entre ellos son:"
	"Juan sigue a Diego :" usuarioJuan seguirAlUsuario: usuarioDiego.
	"Pedro sigue a Juan :" usuarioPedro seguirAlUsuario: usuarioJuan.

	"- Preguntas y respuestas: - "
	topico1 := instancia crearTopicoConNombre: 'OO1' yDescripcion: 'Objetos 1'.
	topico2 := instancia crearTopicoConNombre: 'Test de unidad' yDescripcion: 'Test de unidad'.
	topico3 := instancia crearTopicoConNombre: 'Smalltalk' yDescripcion: 'Smalltalk'.

	"Pregunta de Pedro:  "
	preguntaDePedro := instancia crearPreguntaConTitulo: '¿Para qué sirve el método SetUp? ' descripcion: '¿Para qué sirve el método SetUp?' porUsuario: usuarioPedro yTopicos:(OrderedCollection with: topico1 with: topico2).
		 
	"- Respuesta de Diego: "
	instancia crearRespuestaConTexto: 'Sirve para instanciar los objetos que  son evaluados por el test en un único método y que se ejecute siempre antes de cada test.' aPregunta: preguntaDePedro porUsuario: usuarioDiego.

	"- Pregunta de Diego:"
	preguntaDeDiego := instancia crearPreguntaConTitulo: '¿Qué significa #messageNotUnderstood? ' descripcion: '¿Para qué sirve el método SetUp?' porUsuario: usuarioDiego yTopicos:(OrderedCollection with: topico1 with: topico3).

	"- Respuesta de Pedro:"
	instancia crearRespuestaConTexto: 'Significa que el objeto que recibió el mensaje no encontró ningún método para ejecutar en respuesta.' aPregunta: preguntaDeDiego porUsuario: usuarioPedro.
		   
]

{ #category : #accessing }
CuOOra class >> instancia [
	instancia
		ifNil: [ instancia := self new.
			self inicializarInstancia ].
	^ instancia
]

{ #category : #accessing }
CuOOra >> buscarTopicoConNombre: unNombre [
	^ topicos detect: [ :topico | topico nombre = unNombre ] ifNone: [ nil ]
]

{ #category : #accessing }
CuOOra >> buscarYCrearTopico: unNombre [
	^ (self buscarTopicoConNombre: unNombre)
		ifNil:
			[ self crearTopicoConNombre: unNombre yDescripcion: 'Sin descripcion' ]
]

{ #category : #adding }
CuOOra >> crearPreguntaConTitulo: unTitulo descripcion: unaDescripcion porUsuario: unUsuario yTopicos: unosTopicos [
	| pregunta |
	pregunta := Pregunta
		nuevaConTitulo: unTitulo
		descripcion: unaDescripcion
		porUsuario: unUsuario
		yTopicos: unosTopicos.
	unUsuario agregarPregunta: pregunta.
	unosTopicos do: [ :topico | topico agregarPregunta: pregunta ].
	^ pregunta
]

{ #category : #adding }
CuOOra >> crearRespuestaConTexto: unTexto aPregunta: unaPregunta porUsuario: unUsuario [
	| respuesta |
	respuesta := Respuesta
		nuevaConTexto: unTexto
		aPregunta: unaPregunta
		porUsuario: unUsuario.
	unUsuario agregarRespuesta: respuesta.
	unaPregunta agregarRespuesta: respuesta.
	^ respuesta
]

{ #category : #adding }
CuOOra >> crearTopicoConNombre: unNombre yDescripcion: unaDescripcion [
	^ topicos
		add: (Topico nuevoConNombre: unNombre yDescripcion: unaDescripcion)
]

{ #category : #adding }
CuOOra >> crearUsuarioConNombre: unNombre yContrasena: unaContrasena [
	^ usuarios
		add: (Usuario nuevoConNombre: unNombre yContrasena: unaContrasena)
]

{ #category : #initialization }
CuOOra >> initialize [ 
	usuarios := OrderedCollection new.
	topicos := OrderedCollection new.
	
]

{ #category : #accessing }
CuOOra >> topicos [
	^ topicos
]

{ #category : #accessing }
CuOOra >> usuarios [
	^ usuarios
]

{ #category : #validating }
CuOOra >> validarUsuarioConNombre: unNombre yContrasena: unaContrasena [
	^ usuarios
		detect: [ :usuario | usuario nombre = unNombre & (usuario contrasena = unaContrasena) ]
		ifNone: [ nil ]
]
