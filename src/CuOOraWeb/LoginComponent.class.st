"
| app |
	app := WAAdmin register: LoginComponent asApplicationAt: 'cuoora'.
	app preferenceAt: #sessionClass put: CuOOraSession
"
Class {
	#name : #LoginComponent,
	#superclass : #WAComponent,
	#instVars : [
		'cuoora',
		'nombre',
		'contrasena',
		'errorLogin'
	],
	#category : #CuOOraWeb
}

{ #category : #'class initialization' }
LoginComponent class >> initialize [
	| app |
	app := WAAdmin register: self asApplicationAt: 'cuoora'.
	app preferenceAt: #sessionClass put: CuOOraSession
]

{ #category : #accessing }
LoginComponent >> contrasena [
	^ contrasena
]

{ #category : #accessing }
LoginComponent >> contrasena: unaContrasena [
	contrasena := unaContrasena
]

{ #category : #'instance initialization' }
LoginComponent >> inicializarCuOOra [
	| usuarioPedro usuarioDiego usuarioJuan topico1 topico2 topico3 preguntaDePedro preguntaDeDiego respuestaAPreguntaDePedro respuestaAPreguntaDeDiego |
	
	cuoora := CuOOra instancia.
	
	"Usuarios:" 	
	usuarioPedro := cuoora crearUsuarioConNombre: 'pedro@cuoora.com' yContrasena: 'pedro@cuoora.com'.
	usuarioDiego := cuoora crearUsuarioConNombre: 'diego@cuoora.com' yContrasena: 'diego@cuoora.com'.
	usuarioJuan := cuoora crearUsuarioConNombre: 'juan@cuoora.com' yContrasena: 'juan@cuoora.com'.

	"- Las relaciones entre ellos son:"
	"Juan sigue a Diego :" usuarioJuan seguirAlUsuario: usuarioDiego.
	"Pedro sigue a Juan :" usuarioPedro seguirAlUsuario: usuarioJuan.

"- Preguntas y respuestas: - "
	topico1 := cuoora crearTopicoConNombre: 'OO1' yDescripcion: 'Objetos 1'.
	topico2 := cuoora crearTopicoConNombre: 'Test de unidad' yDescripcion: 'Test de unidad'.
	topico3 := cuoora crearTopicoConNombre: 'Smalltalk' yDescripcion: 'Smalltalk'.

	"Pregunta de Pedro:  "
	preguntaDePedro := cuoora crearPreguntaConTitulo: '¿Para qué sirve el método SetUp? ' descripcion: '¿Para qué sirve el método SetUp?' porUsuario: usuarioPedro yTopicos:(OrderedCollection with: topico1 with: topico2).
		 
	"- Respuesta de Diego: "
	respuestaAPreguntaDePedro := cuoora crearRespuestaConTexto: 'Sirve para instanciar los objetos que  son evaluados por el test en un único método y que se ejecute siempre antes de cada test.' aPregunta: preguntaDePedro porUsuario: usuarioDiego.

	"- Pregunta de Diego:"
	preguntaDeDiego := cuoora crearPreguntaConTitulo: '¿Qué significa #messageNotUnderstood? ' descripcion: '¿Para qué sirve el método SetUp?' porUsuario: usuarioDiego yTopicos:(OrderedCollection with: topico1 with: topico3).

	"- Respuesta de Pedro:"
	respuestaAPreguntaDeDiego := cuoora crearRespuestaConTexto: 'Significa que el objeto que recibió el mensaje no encontró ningún método para ejecutar en respuesta.' aPregunta: preguntaDeDiego porUsuario: usuarioPedro.
		   
]

{ #category : #initialization }
LoginComponent >> initialize [
	super initialize.
	self inicializarCuOOra
]

{ #category : #callbacks }
LoginComponent >> loginUsuario [
	| usuario |
	usuario := CuOOra instancia validarUsuarioConNombre: nombre yContrasena: contrasena.
	usuario
		ifNil: [ errorLogin := 'El usuario es inválido' ]
		ifNotNil: [ self session usuario: usuario.	"Asigno el usuario a la sesion"
			nombre := ''.	"Borro todo para que no se muestre al salir"
			contrasena := ''.
			self renderHome ]
]

{ #category : #accessing }
LoginComponent >> nombre [
	^ nombre
]

{ #category : #accessing }
LoginComponent >> nombre: unNombre [
	nombre := unNombre
]

{ #category : #rendering }
LoginComponent >> renderContentOn: html [
	html paragraph: 'LOGIN'.
	html heading
		level: 1;
		with: 'Bienvenido'.
	self renderLoginFormOn: html.
	self renderMensajeDeErrorOn: html
]

{ #category : #rendering }
LoginComponent >> renderHome [
	self call: HomeComponent new
]

{ #category : #rendering }
LoginComponent >> renderLoginButtonOn: html [
	html submitButton
		callback: [ self loginUsuario ];
		value: 'Login'
]

{ #category : #rendering }
LoginComponent >> renderLoginFormOn: html [
	html
		form: [ html text: 'Usuario: '.
			html textInput on: #nombre of: self.
			html break.
			html text: 'Contrasena: '.
			html textInput on: #contrasena of: self.
			html break.
			self renderLoginButtonOn: html ]
]

{ #category : #rendering }
LoginComponent >> renderMensajeDeErrorOn: html [
	errorLogin isNotNil
		ifFalse: [ ^ self ].
	html div
		style: 'color:red;font-weight:bold;';
		with: errorLogin.
	errorLogin := nil
]
