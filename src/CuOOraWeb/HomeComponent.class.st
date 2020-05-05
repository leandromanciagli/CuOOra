Class {
	#name : #HomeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'header'
	],
	#category : #CuOOraWeb
}

{ #category : #initialization }
HomeComponent >> initialize [
	super initialize.
	header := HeaderComponent newConPadre: self
]

{ #category : #rendering }
HomeComponent >> renderContentOn: html [
	| preg usuarioLogueado |
	usuarioLogueado := self session usuario.
	html render: header.
	html heading
		level: 1;
		with: 'Ultimas preguntas'.
	preg := usuarioLogueado obtenerPreguntasRelevantes takeFirst: 5.
	preg
		do: [ :p | 
			html div.
			html anchor
				callback: [ self renderPregunta: p ];
				with: [ html heading
						level: 3;
						with: p titulo ].
			html paragraph with: 'topicos: ' , p topicos.
			html text: 'Realizada por: '.
			html anchor
				callback: [ self renderUsuario: p usuario ];
				with: p usuario nombre.
			html paragraph
				with: 'respuestas: ' , p obtenerRespuestasPorPuntaje size asString.
			html paragraph
				with:
					'Likes: ' , p likes size asString , '| Dislikes: '
						, p dislikes size asString.
			html anchor
				callback: [ CuOOra instancia
						registrarReaccionDelUsuario: usuarioLogueado
						aPublicacion: p
						conVoto: true ];
				with: 'like  '.
			html anchor
				callback: [ CuOOra instancia
						registrarReaccionDelUsuario: usuarioLogueado
						aPublicacion: p
						conVoto: false ];
				with: 'dislike'.
			html tag: 'hr' ].
	html break.
	html anchor
		callback: [ self renderPregunta ];
		with: 'Agrega una nueva pregunta'
]

{ #category : #rendering }
HomeComponent >> renderPregunta [
	self call: PreguntaComponent new
]

{ #category : #rendering }
HomeComponent >> renderPregunta: unaPregunta [
	self call: (PreguntaDetalleComponent new: unaPregunta)
]

{ #category : #rendering }
HomeComponent >> renderUsuario: unUsuario [
	self call: (UsuarioDetalleComponent new: unUsuario)
]
