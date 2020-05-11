Class {
	#name : #PreguntaComponent,
	#superclass : #WAComponent,
	#instVars : [
		'padre',
		'pregunta'
	],
	#category : #CuOOraWeb
}

{ #category : #'instance creation' }
PreguntaComponent class >> newConPadre: unPadre yPregunta: unaPregunta [
	^ self new inicializarConPadre: unPadre yPregunta: unaPregunta
]

{ #category : #'instance initialization' }
PreguntaComponent >> inicializarConPadre: unPadre yPregunta: unaPregunta [
	padre := unPadre.
	pregunta := unaPregunta
]

{ #category : #rendering }
PreguntaComponent >> renderContentOn: html [
	html div.
	self renderTituloButtonOn: html.
	html paragraph: 'Topicos: ' , pregunta topicos.
	html text: 'Realizada por: '. self renderPerfilUsuarioButtonOn: html.
	html paragraph: 'Respuestas: ' , (pregunta obtenerRespuestasPorPuntaje size asString).
	html paragraph: 'Likes: ' , (pregunta likes size asString) , 
	                ' | Dislikes: ', (pregunta dislikes size asString).
	html paragraph: [ self renderLikeButtonOn: html.
				         html space.
	                  self renderDislikeButtonOn: html ].
	html tag: 'hr'
]

{ #category : #rendering }
PreguntaComponent >> renderDislikeButtonOn: html [
	html anchor
		callback: [ pregunta registrarDislikeDelUsuario: self session usuario ];
		with: [ html button with: 'Dislike' ]
]

{ #category : #rendering }
PreguntaComponent >> renderLikeButtonOn: html [
	html anchor
		callback: [ pregunta registrarLikeDelUsuario: self session usuario ];
		with: [ html button with: 'Like' ]
]

{ #category : #rendering }
PreguntaComponent >> renderPerfilUsuarioButtonOn: html [
	html anchor
		callback: [ self renderUsuarioDetalle: pregunta usuario ];
		with: pregunta usuario nombre
]

{ #category : #rendering }
PreguntaComponent >> renderPreguntaDetalle [
	padre call: (PreguntaDetalleComponent newConPregunta: pregunta)
]

{ #category : #rendering }
PreguntaComponent >> renderTituloButtonOn: html [
	html anchor
		callback: [ self renderPreguntaDetalle ];
		with: [ html heading
				level: 2;
				with: pregunta titulo ]
]

{ #category : #rendering }
PreguntaComponent >> renderUsuarioDetalle: unUsuario [
	padre call: (UsuarioDetalleComponent newConUsuario: unUsuario)
]
