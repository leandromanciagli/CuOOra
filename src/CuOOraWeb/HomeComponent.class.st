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
	html paragraph with: cuooraweb usuario nombre.
	preg := CuOOraComponent instancia usuario obtenerPreguntasRelevantes.
	preg
		do: [ :p | 
			html div.
			html heading
				level: 3;
				with: p titulo.
			html paragraph with: 'Fecha y hora de creación: ' , p fechaHora asString.
			html paragraph with: 'topicos: ' , p topicos.
			html text: 'Realizada por: ' , p usuario nombre.
			html paragraph
				with: 'respuestas: ' , p obtenerRespuestas size asString.
			html paragraph
				with:
					'Likes: ' , p likes size asString , '| Dislikes: '
						, (p reacciones size - p likes size) asString.
			html anchor
				callback: [ CuOOra instancia
						registrarReaccionDe: CuOOraComponent instancia usuario
						a: p
						conVoto: true ];
				with: 'like  '.
			html anchor
				callback: [ CuOOra instancia
						registrarReaccionDe: CuOOraComponent instancia usuario
						a: p
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
