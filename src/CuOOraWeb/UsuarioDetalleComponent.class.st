Class {
	#name : #UsuarioDetalleComponent,
	#superclass : #LoggerComponent,
	#instVars : [
		'usuario'
	],
	#category : #CuOOraWeb
}

{ #category : #'instance creation' }
UsuarioDetalleComponent class >> newConUsuario: unUsuario [
	^ self new usuario: unUsuario
]

{ #category : #comparing }
UsuarioDetalleComponent >> esUsuarioLogueado [
	^ usuario == self session usuario
]

{ #category : #rendering }
UsuarioDetalleComponent >> renderContentOn: html [
	html render: headerComponent.
	html heading: 'Preguntas de ' , usuario nombre.
	self renderEsSeguidoOn: html.
	self renderPreguntasOn: html.
	self renderVolverButtonOn: html
]

{ #category : #rendering }
UsuarioDetalleComponent >> renderEsSeguidoOn: html [
	self esUsuarioLogueado
		ifFalse: [ (self session usuario seguidos includes: usuario)
				ifTrue: [ html text: 'Ya sigues a este usuario' ]
				ifFalse: [ self renderSeguirUsuarioButtonOn: html ] ]
]

{ #category : #rendering }
UsuarioDetalleComponent >> renderPreguntasOn: html [
	usuario preguntasRealizadas isEmpty
		ifTrue: [ html paragraph with: 'No hay preguntas' ]
		ifFalse: [ self usuario preguntasRealizadas
				do:
					[ :pregunta | html render: (PreguntaComponent newConPadre: self yPregunta: pregunta) ] ]
]

{ #category : #rendering }
UsuarioDetalleComponent >> renderSeguirUsuarioButtonOn: html [
	html anchor
		callback: [ self session usuario seguirAlUsuario: usuario ];
		with: 'Seguir'
]

{ #category : #rendering }
UsuarioDetalleComponent >> renderVolverButtonOn: html [
	html anchor
		callback: [ self answer ];
		with: [ html button with: 'Volver' ]
]

{ #category : #accessing }
UsuarioDetalleComponent >> usuario [
	^ usuario
]

{ #category : #accessing }
UsuarioDetalleComponent >> usuario: unUsuario [
	usuario := unUsuario
]
