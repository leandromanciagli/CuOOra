Class {
	#name : #UsuarioDetalleComponent,
	#superclass : #WAComponent,
	#instVars : [
		'header',
		'usuario'
	],
	#category : #CuOOraWeb
}

{ #category : #'instance creation' }
UsuarioDetalleComponent class >> new: unUsuario [
	^ self new usuario: unUsuario
]

{ #category : #initialization }
UsuarioDetalleComponent >> initialize [
	super initialize.
	header := HeaderComponent newConPadre: self
]

{ #category : #rendering }
UsuarioDetalleComponent >> renderContentOn: html [
	| usuarioLogueado |
	html render: header.
	usuarioLogueado := self session usuario.	"Para obtener el usuario logueado"
	html heading: 'Preguntas de ' , self usuario nombre.
	self usuario == usuarioLogueado
		ifFalse: [ "el usuario logueado es el usuario del que se ve su perfil?"
			(usuarioLogueado seguidos includes: self usuario)
				ifTrue: [ html text: 'Ya sigues a este usuario' ]
				ifFalse: [ html anchor
						callback: [ usuarioLogueado seguirAlUsuario: usuario ];
						"el  2do usuario es el usuario cuyo perfil estoy viendo"
							with: 'Seguir' ] ].
	self usuario preguntas isEmpty
		ifTrue: [ html paragraph with: 'No hay preguntas' ]
		ifFalse: [ self usuario preguntas
				do: [ :p | 
					html div.
					html anchor
						callback: [ self renderPregunta: p ];
						with: [ html heading
								level: 3;
								with: p titulo ].
					html paragraph with: 'topicos: ' , p topicos.
					html paragraph
						with: 'respuestas:' , p obtenerRespuestasPorPuntaje size asString.
					html paragraph
						with:
							'Likes: ' , p likes size asString , '| Dislikes: '
								, p dislikes size asString.
					html anchor
						callback: [ p registrarLikeDelUsuario: usuarioLogueado];
						with: 'like  '.
					html anchor
						callback: [ p registrarDislikeDelUsuario: usuarioLogueado];
						with: 'dislike'.
					html tag: 'hr' ] ].
	html tag: 'br'.
	"redireccionar al home"
	html anchor
		callback: [ self volver ];
		with: 'volver'
]

{ #category : #rendering }
UsuarioDetalleComponent >> renderPregunta: unaPregunta [
	self call: (PreguntaDetalleComponent new: unaPregunta)
]

{ #category : #accessing }
UsuarioDetalleComponent >> usuario [
	^ usuario
]

{ #category : #accessing }
UsuarioDetalleComponent >> usuario: anObject [
	usuario := anObject
]

{ #category : #rendering }
UsuarioDetalleComponent >> volver [
	self answer
]
