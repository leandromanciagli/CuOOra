Class {
	#name : #PreguntaDetalleComponent,
	#superclass : #WAComponent,
	#instVars : [
		'header',
		'pregunta'
	],
	#category : #CuOOraWeb
}

{ #category : #'instance creation' }
PreguntaDetalleComponent class >> new: unaPregunta [
	^ self new pregunta: unaPregunta
]

{ #category : #callbacks }
PreguntaDetalleComponent >> agregarRespuesta: unaPregunta [
	self call: (RespuestaComponent pregunta: unaPregunta)
]

{ #category : #initialization }
PreguntaDetalleComponent >> initialize [
	super initialize.
	header := HeaderComponent newConPadre: self
]

{ #category : #accessing }
PreguntaDetalleComponent >> pregunta: anObject [
	pregunta := anObject
]

{ #category : #rendering }
PreguntaDetalleComponent >> renderContentOn: html [
	| usuarioLogueado |
	usuarioLogueado := self session usuario.
	html render: header.
	html div.
	html heading
		level: 1;
		with: pregunta titulo.
	html paragraph with: 'Topicos: ' , pregunta topicos.
	html text: 'Realizada por: '.
	html anchor
		callback: [ self renderUsuario: pregunta usuario ];
		with: pregunta usuario nombre.
	html paragraph
		with: 'Respuestas: ' , pregunta obtenerRespuestasPorPuntaje size asString.
	html paragraph
		with:
			'Likes: ' , pregunta likes size asString , '| Dislikes: '
				, pregunta dislikes size asString.
	html anchor
		callback: [ CuOOra instancia
				registrarReaccionDelUsuario: usuarioLogueado
				aPublicacion: pregunta
				conVoto: true ];
		with: 'like  '.
	html anchor
		callback: [ CuOOra instancia
				registrarReaccionDelUsuario: usuarioLogueado
				aPublicacion: pregunta
				conVoto: false ];
		with: 'dislike'.
	html tag: 'hr'.
	pregunta obtenerRespuestasPorPuntaje
		do: [ :r | 
			html text: 'Respuesta de: '.
			html anchor
				callback: [ self renderUsuario: r usuario ];
				with: r usuario nombre.
			html break.
			html paragraph: r texto.
			html paragraph
				with:
					'Likes: ' , r likes size asString , '| Dislikes: '
						, r dislikes size asString.
			html anchor
				callback: [ CuOOra instancia
						registrarReaccionDelUsuario: usuarioLogueado
						aPublicacion: r
						conVoto: true ];
				with: 'like  '.
			html anchor
				callback: [ CuOOra instancia
						registrarReaccionDelUsuario: usuarioLogueado
						aPublicacion: r
						conVoto: false ];
				with: 'dislike'.
			html tag: 'hr' ].
	html anchor
		callback: [ self agregarRespuesta: pregunta ];
		with: 'Agregar respuesta'.
	html space.
	html anchor
		callback: [ self answer ];
		with: 'volver'
]

{ #category : #rendering }
PreguntaDetalleComponent >> renderUsuario: unUsuario [
	self call: (UsuarioDetalleComponent new: unUsuario)
]
