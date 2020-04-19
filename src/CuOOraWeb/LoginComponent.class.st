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
LoginComponent >> contrasena: anObject [
	contrasena := anObject
]

{ #category : #initialization }
LoginComponent >> initialize [
	super initialize.
	self instanciarCuOOra
]

{ #category : #'instance initialization' }
LoginComponent >> instanciarCuOOra [
	| top topicos usuarioCatherine usuarioLeandro pregunta1 |
	CuOOra clearInstancia.
	cuoora := CuOOra instancia.
	usuarioCatherine := cuoora crearUsuarioConNombre: 'Catherine' yContrasena:'1234'.
	usuarioLeandro := cuoora crearUsuarioConNombre: 'Leandro' yContrasena:'lacontraseña'.
	top := cuoora crearTopicoConNombre: 'topico1' yDescripcion:'vamos a verla'.
	cuoora crearTopicoConNombre: 'topico2' yDescripcion: 'Es el topico2'.
	usuarioCatherine agregarTopicoDeInteres: top.
	usuarioLeandro seguirAlUsuario: usuarioCatherine.
	topicos:=OrderedCollection new.
	topicos add:top.
	pregunta1 := cuoora crearPreguntaConTitulo:'pregunta 1' descripcion:'es relevante y debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	cuoora crearPreguntaConTitulo:'pregunta 2' descripcion:'es relevante y debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	cuoora crearPreguntaConTitulo:'pregunta 3' descripcion:'es relevante y debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	cuoora crearPreguntaConTitulo:'pregunta 4' descripcion:'es relevante y debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	cuoora crearPreguntaConTitulo:'pregunta 5' descripcion:'es relevante y debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	cuoora crearPreguntaConTitulo:'pregunta 6' descripcion:'es relevante y debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	cuoora crearPreguntaConTitulo:'pregunta 7' descripcion:'es relevante pero no debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	cuoora crearPreguntaConTitulo:'pregunta 8' descripcion:'es relevante pero no debe mostrarse' porUsuario:usuarioLeandro yTopicos:topicos.
	cuoora crearRespuestaConTexto:'respuesta a la pregunta 1' aPregunta:pregunta1 porUsuario:usuarioCatherine.
	cuoora registrarReaccionDelUsuario: usuarioCatherine aPublicacion: pregunta1 conVoto:false.
	
]

{ #category : #callbacks }
LoginComponent >> loginUsuario [
	"Este método loguea un usuario en cuoora"

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
LoginComponent >> nombre: anObject [
	nombre := anObject
]

{ #category : #rendering }
LoginComponent >> renderContentOn: html [
	html paragraph: 'LOGIN'.
	html heading
		level: 1;
		with: 'Bienvenido'.
	html
		form: [ html text: 'Usuario: '.
			html textInput on: #nombre of: self.
			html break.
			html text: 'Contrasena: '.
			html textInput on: #contrasena of: self.
			html break.
			html submitButton
				callback: [ self loginUsuario ];
				value: 'Login' ].
	errorLogin isNotNil
		ifFalse: [ ^ self ].
	html div
		style: 'color:red;font-weight:bold;';
		with: errorLogin.
	errorLogin := nil
]

{ #category : #rendering }
LoginComponent >> renderHome [
	self call: HomeComponent new
]
