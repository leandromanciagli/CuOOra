Class {
	#name : #RespuestaComponent,
	#superclass : #EmbeddedComponent,
	#instVars : [
		'respuesta'
	],
	#category : #CuOOraWeb
}

{ #category : #'instance creation' }
RespuestaComponent class >> newConPadre: unPadre yRespuesta: unaRespuesta [
	^ self new inicializarConPadre: unPadre yRespuesta: unaRespuesta
]

{ #category : #'instance initialization' }
RespuestaComponent >> inicializarConPadre: unPadre yRespuesta: unaRespuesta [
	padre := unPadre.
	respuesta := unaRespuesta
]

{ #category : #rendering }
RespuestaComponent >> renderContentOn: html [
	html text: 'Respuesta de: '.
	self renderPerfilUsuarioButtonOn: html.
	html paragraph: respuesta texto.
	html paragraph: 'Likes: ' , (respuesta likes size asString) , 
	                ' | Dislikes: ', (respuesta dislikes size asString).
	html paragraph: [ self renderLikeButtonOn: html.
							html space.
	                  self renderDislikeButtonOn: html ].
	html tag: 'hr'
]

{ #category : #rendering }
RespuestaComponent >> renderDislikeButtonOn: html [
	html anchor
		callback: [ respuesta registrarDislikeDelUsuario: self session usuario ];
		with: [ html button with: 'Dislike' ]
]

{ #category : #rendering }
RespuestaComponent >> renderLikeButtonOn: html [
	html anchor
		callback: [ respuesta registrarLikeDelUsuario: self session usuario ];
		with: [ html button with: 'Like' ]
]

{ #category : #rendering }
RespuestaComponent >> renderPerfilUsuarioButtonOn: html [
	html anchor
		callback: [ self renderUsuarioDetalle: respuesta usuario ];
		with: respuesta usuario nombre
]
