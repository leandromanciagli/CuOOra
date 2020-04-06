Class {
	#name : #HomeComponent,
	#superclass : #WAComponent,
	#category : #CuOOraWeb
}

{ #category : #rendering }
HomeComponent >> renderContentOn: html [ 
|preg|
	preg:=CuOOraComponent instancia usuario obtenerPreguntasRelevantes.
	 preg do: [ :p |
html div.
html heading
level: 3;
with: p titulo.
html text: 'Realizada por: ', p usuario nombre.
html paragraph
with: 'respuestas:' , p obtenerRespuestas size asString.
html paragraph
with: 'Likes: ' , p likes size asString , '| Dislikes: ' , (p reacciones size - p likes size)  asString. 
html anchor
callback: [ CuOOra instancia registrarReaccionDe:(CuOOraComponent instancia usuario) a:p conVoto:true. ];
with: 'like  '.

html anchor
callback: [ CuOOra instancia registrarReaccionDe:(CuOOraComponent instancia usuario) a:p conVoto:false. ];
with: 'dislike'.

html tag: 'hr'.].
html anchor 
			callback: [ 0];
			with: 'Agregar Pregunta'.
	
]
