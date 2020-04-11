Class {
	#name : #HomeComponent,
	#superclass : #WAComponent,
	#category : #CuOOraWeb
}

{ #category : #'as yet unclassified' }
HomeComponent >> desloguear [

 CuOOraComponent instancia usuario: nil.
 self answer: nil.
]

{ #category : #rendering }
HomeComponent >> renderContentOn: html [
	| preg cuooraweb |
	cuooraweb := CuOOraComponent instancia.
	html anchor
		callback: [ self verUsuario: cuooraweb usuario nombre ];
		with: cuooraweb usuario nombre.
	html heading
		level: 1;
		with: 'Ultimas preguntas'.
	preg := CuOOraComponent instancia usuario obtenerPreguntasRelevantes.
	preg
		do: [ :p | 
			html div.
			html anchor
				callback: [ self verPregunta: p ];
				with: [ html heading
						level: 3;
						with: p titulo ].
			html paragraph
				with: 'Fecha y hora de creación: ' , p fechaHora asString.
			html paragraph with: 'topicos: ' , p topicos.
			html text: 'Realizada por: '.
			html anchor
				callback: [ self verUsuario: p usuario ];
				with: p usuario nombre.
			html paragraph
				with: 'respuestas: ' , p obtenerRespuestasPorPuntaje size asString.
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
			html tag: 'hr' ].
	html anchor
		callback: [ self desloguear ];
		with: 'logOut'.
	html break.
	html anchor
		callback: [ self renderPregunta ];
		with: 'Agrega una nueva pregunta'
]

{ #category : #rendering }
HomeComponent >> renderPregunta [
	self call: (CuOOraComponent instancia preguntaComponent).
]

{ #category : #'as yet unclassified' }
HomeComponent >> verPregunta:preg [ 
 | pregunta |
pregunta:= PreguntaDetalleComponent new:preg.
self call: pregunta.
]

{ #category : #'as yet unclassified' }
HomeComponent >> verUsuario: usu [
	| usuario |
	usuario := UsuarioDetalleComponent new: usu.
	self call: usuario
	

]
