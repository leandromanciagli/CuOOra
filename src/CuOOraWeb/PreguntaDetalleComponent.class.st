Class {
	#name : #PreguntaDetalleComponent,
	#superclass : #WAComponent,
	#instVars : [
		'preg'
	],
	#category : #CuOOraWeb
}

{ #category : #'instance creation' }
PreguntaDetalleComponent class >> new:preg [ 
	^ self new preg:preg.
]

{ #category : #adding }
PreguntaDetalleComponent >> addRespuesta: unaPregunta [
	self call: (RespuestaComponent pregunta: unaPregunta)
]

{ #category : #'as yet unclassified' }
PreguntaDetalleComponent >> desloguear [

 CuOOraComponent instancia usuario: nil.
 self answer: nil.
]

{ #category : #accessing }
PreguntaDetalleComponent >> preg [
	^ preg
]

{ #category : #accessing }
PreguntaDetalleComponent >> preg: anObject [
	preg := anObject
]

{ #category : #rendering }
PreguntaDetalleComponent >> renderContentOn: html [
	| usuarioLogueado |
	usuarioLogueado := CuOOraComponent instancia usuario.
	html anchor
		callback: [ self verUsuario: usuarioLogueado ];
		with: usuarioLogueado nombre.
	html div.
	html heading
		level: 1;
		with: preg titulo.
	html paragraph with: 'topicos:' , preg topicos.
	html text: 'Realizada por: '.
	html anchor
		callback: [ self verUsuario: preg usuario ];
		with: preg usuario nombre.
	html paragraph
		with: 'respuestas:' , preg obtenerRespuestasPorPuntaje size asString.
	html paragraph
		with:
			'Likes: ' , preg likes size asString , '| Dislikes: '
				, preg dislikes size asString.
	html anchor
		callback: [ CuOOra instancia
				registrarReaccionDelUsuario: CuOOraComponent instancia usuario
				aPublicacion: preg
				conVoto: true ];
		with: 'like  '.
	html anchor
		callback: [ CuOOra instancia
				registrarReaccionDelUsuario: CuOOraComponent instancia usuario
				aPublicacion: preg
				conVoto: false ];
		with: 'dislike'.
	html tag: 'hr'.
	preg obtenerRespuestasPorPuntaje
		do: [ :r | 
			html text: 'Respuesta de: '.
			html anchor
				callback: [ self verUsuario: r usuario ];
				with: r usuario nombre.
			html break.
			html paragraph: r texto.
			html paragraph
				with:
					'Likes: ' , r likes size asString , '| Dislikes: '
						, r dislikes size asString.
			html anchor
				callback: [ CuOOra instancia
						registrarReaccionDelUsuario: CuOOraComponent instancia usuario
						aPublicacion: r
						conVoto: true ];
				with: 'like  '.
			html anchor
				callback: [ CuOOra instancia
						registrarReaccionDelUsuario: CuOOraComponent instancia usuario
						aPublicacion: r
						conVoto: false ];
				with: 'dislike'.
			html tag: 'hr' ].
	html anchor
		callback: [ self addRespuesta: preg ];
		with: 'Agregar respuesta'.
	html space.
	html anchor
		callback: [ self volver ];
		with: 'volver'.
	html space.
	html anchor
		callback: [ self desloguear ];
		with: 'logOut'
]

{ #category : #rendering }
PreguntaDetalleComponent >> renderHome [


]

{ #category : #'as yet unclassified' }
PreguntaDetalleComponent >> verUsuario: unUsuario [
	self call: (UsuarioDetalleComponent new: unUsuario)
]

{ #category : #rendering }
PreguntaDetalleComponent >> volver [
	self answer: nil
]
