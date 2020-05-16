"
| app |
	app := WAAdmin register: LoginComponent asApplicationAt: 'cuoora'.
	app preferenceAt: #sessionClass put: CuOOraSession
"
Class {
	#name : #LoginComponent,
	#superclass : #WAComponent,
	#instVars : [
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
