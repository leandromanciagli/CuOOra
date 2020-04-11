Class {
	#name : #RespuestaComponent,
	#superclass : #WAComponent,
	#instVars : [
		'pregunta',
		'respuesta',
		'newTexto'
	],
	#category : #CuOOraWeb
}

{ #category : #'instance creation' }
RespuestaComponent class >> pregunta: unaPregunta [
	^ self new pregunta: unaPregunta
]

{ #category : #'as yet unclassified' }
RespuestaComponent >> agregarRespuesta [
	CuOOra instancia
		crearRespuestaConTexto: newTexto
		aPregunta: pregunta
		porUsuario: CuOOraComponent instancia usuario.
	self answer: nil
]

{ #category : #'as yet unclassified' }
RespuestaComponent >> cancelar [
	respuesta := nil.
	self answer
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
	usuarioLogueado := CuOOraComponent instancia usuario.
	aCanvas anchor
		callback: [ self verUsuario: usuarioLogueado ];
		with: usuarioLogueado nombre.
	aCanvas div.
	aCanvas heading
		level: 1;
		with: pregunta titulo.
	aCanvas paragraph with: 'Tópicos: ' , pregunta topicos.
	aCanvas text: 'Realizada por: '.
	aCanvas anchor
		callback: [ self verUsuario: pregunta usuario ];
		with: pregunta usuario nombre.
	aCanvas paragraph
		with:
			'Likes: ' , pregunta likes size asString , '| Dislikes: '
				, pregunta dislikes size asString.
	aCanvas anchor
		callback: [ CuOOra instancia
				registrarReaccionDelUsuario: usuarioLogueado
				aPublicacion: pregunta
				conVoto: true ];
		with: 'like  '.
	aCanvas anchor
		callback: [ CuOOra instancia
				registrarReaccionDelUsuario: usuarioLogueado
				aPublicacion: pregunta
				conVoto: false ];
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
				value: 'Guardar' ]
]

{ #category : #'as yet unclassified' }
RespuestaComponent >> verUsuario: unUsuario [
	| usuarioDetalleComponent |
	usuarioDetalleComponent := UsuarioDetalleComponent new: unUsuario.
	self call: usuarioDetalleComponent
]
