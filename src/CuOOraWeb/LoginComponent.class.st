Class {
	#name : #LoginComponent,
	#superclass : #WAComponent,
	#instVars : [
		'nombre',
		'contrasena'
	],
	#category : #CuOOraWeb
}

{ #category : #accessing }
LoginComponent >> contrasena [
	^ contrasena
]

{ #category : #accessing }
LoginComponent >> contrasena: anObject [
	contrasena := anObject
]

{ #category : #'as yet unclassified' }
LoginComponent >> loginUsuario [
	CuOOraComponent instancia
		usuario: (CuOOra instancia validarUsuarioConNombre: nombre yContrasena: contrasena).
	self renderHome


	"Este método loguea un usuario en cuoora"
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
				value: 'Login' ]
]

{ #category : #rendering }
LoginComponent >> renderHome [
	|web|
	web := CuOOraComponent instancia.
	self call: web.
	
]
