Class {
	#name : #RespuestaComponent,
	#superclass : #WAComponent,
	#instVars : [
		'header',
		'pregunta',
		'newTexto'
	],
	#category : #CuOOraWeb
}

{ #category : #'instance creation' }
RespuestaComponent class >> pregunta: unaPregunta [
	^ self new pregunta: unaPregunta
]

{ #category : #callbacks }
RespuestaComponent >> agregarRespuesta [
	CuOOra instancia
		crearRespuestaConTexto: newTexto
		aPregunta: pregunta
		porUsuario: self session usuario.
	self volver
]

{ #category : #callbacks }
RespuestaComponent >> cancelar [
	newTexto := nil.
	
]

{ #category : #initialization }
RespuestaComponent >> initialize [
	super initialize.
	header := HeaderComponent newConPadre: self
]

{ #category : #accessing }
RespuestaComponent >> newTexto [
	^ newTexto
]

{ #category : #accessing }
RespuestaComponent >> newTexto: unTexto [
	newTexto := unTexto
]

{ #category : #accessing }
RespuestaComponent >> pregunta: unaPregunta [
	pregunta := unaPregunta
]

{ #category : #rendering }
RespuestaComponent >> renderContentOn: aCanvas [
	| usuarioLogueado |
	usuarioLogueado := self session usuario.
	aCanvas render: header.
	aCanvas div.
	aCanvas heading
		level: 1;
		with: pregunta titulo.
	aCanvas paragraph with: 'Tópicos: ' , pregunta topicos.
	aCanvas text: 'Realizada por: '.
	aCanvas anchor
		callback: [ self renderUsuario: pregunta usuario ];
		with: pregunta usuario nombre.
	aCanvas paragraph
		with:
			'Likes: ' , pregunta likes size asString , '| Dislikes: '
				, pregunta dislikes size asString.
	aCanvas anchor
		callback: [ pregunta registrarLikeDelUsuario: usuarioLogueado];
		with: 'like  '.
	aCanvas anchor
		callback: [ pregunta registrarDislikeDelUsuario: usuarioLogueado ];
		with: 'dislike'.
	aCanvas tag: 'hr'.
	aCanvas paragraph with: 'RESPONDER'.
	aCanvas
		form: [ aCanvas textArea on: #newTexto of: self.
			aCanvas button
				callback: [ self cancelar ];
				value: 'Cancelar'.
			aCanvas submitButton
				callback: [ self agregarRespuesta ];
				value: 'Guardar' ].
	aCanvas anchor
		callback: [ self volver ];
		with: 'Volver'
]

{ #category : #rendering }
RespuestaComponent >> renderUsuario: unUsuario [
	self call: (UsuarioDetalleComponent new: unUsuario)
]

{ #category : #callbacks }
RespuestaComponent >> volver [
	self cancelar.
	self answer
]
