Class {
	#name : #UsuarioDetalleComponent,
	#superclass : #WAComponent,
	#instVars : [
		'usuario'
	],
	#category : #CuOOraWeb
}

{ #category : #'instance creation' }
UsuarioDetalleComponent class >> new: usuario [
	^ self new usuario: usuario
]

{ #category : #rendering }
UsuarioDetalleComponent >> renderContentOn: html [
	| usuarioLogueado |
	html render: HeaderComponent new.
	usuarioLogueado := CuOOraComponent instancia usuario.	"para tener el usuario logueado"
	"html anchor
		callback: [ self verUsuario: usuarioLogueado ];
		with: usuarioLogueado nombre."
	html heading: 'Preguntas de ' , self usuario nombre.
	self usuario == usuarioLogueado
		ifFalse: [ "el usuario logueado es el usuario del que se ve su perfil?"
			(usuarioLogueado seguidos includes: self usuario)
				ifTrue: [ html text: 'Ya sigues a este usuario' ]
				ifFalse: [ html anchor
						callback: [ usuarioLogueado seguirAlUsuario: usuario ];
						"el  2do usuario es el usuario cuyo perfil estoy viendo"
							with: 'Seguir' ] ].
	self usuario preguntasRealizadas isEmpty
		ifTrue: [ html paragraph with: 'No hay preguntas' ]
		ifFalse: [ self usuario preguntasRealizadas
				do: [ :p | 
					html div.
					html anchor
						callback: [ self verPregunta: p ];
						with: [ html heading
								level: 3;
								with: p titulo ].
					html paragraph with: 'topicos: ' , p topicos .
					html paragraph
						with: 'respuestas:' , p obtenerRespuestasPorPuntaje size asString.
					html paragraph
						with:
							'Likes: ' , p likes size asString , '| Dislikes: '
								, p dislikes size asString.
					html anchor
						callback: [ CuOOra instancia
								registrarReaccionDelUsuario: CuOOraComponent instancia usuario
								aPublicacion: p
								conVoto: true ];
						with: 'like  '.
					html anchor
						callback: [ CuOOra instancia
								registrarReaccionDelUsuario: CuOOraComponent instancia usuario
								aPublicacion: p
								conVoto: false ];
						with: 'dislike'.
					html tag: 'hr' ] ].
	html tag: 'br'.
	html anchor
		callback: [ self renderHome ];
		"redireccionar al home"
			with: 'volver'
]

{ #category : #rendering }
UsuarioDetalleComponent >> renderHome [
	self answer: nil
]

{ #category : #accessing }
UsuarioDetalleComponent >> usuario [
	^ usuario
]

{ #category : #accessing }
UsuarioDetalleComponent >> usuario: anObject [
	usuario := anObject
]

{ #category : #'as yet unclassified' }
UsuarioDetalleComponent >> verPregunta: preg [
	| pregunta |
	pregunta := PreguntaDetalleComponent new: preg.
	self call: pregunta
]
