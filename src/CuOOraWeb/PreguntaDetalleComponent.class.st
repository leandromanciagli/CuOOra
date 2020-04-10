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
PreguntaDetalleComponent >> renderContentOn:html [
html div.
html heading
level: 3;
with: preg titulo.
html paragraph
with: 'topicos:' , preg topicos.
html text: 'Realizada por: ', preg usuario nombre.
html paragraph
with: 'respuestas:' , preg obtenerRespuestas size asString.
html paragraph
with: 'Likes: ' , preg likes size asString , '| Dislikes: ' , (preg reacciones size - preg likes size)  asString. 
html anchor
callback: [ CuOOra instancia registrarReaccionDe:(CuOOraComponent instancia usuario) a:preg conVoto:true. ];
with: 'like  '.

html anchor
callback: [ CuOOra instancia registrarReaccionDe:(CuOOraComponent instancia usuario) a:preg conVoto:false. ];
with: 'dislike'.
html tag: 'hr'.
preg obtenerRespuestas  do:[:r | 
 html text: 'Respuesta de: '.
 html anchor callback: [ self verUsuario:r usuario ]; with: r usuario nombre.

html break.
html paragraph: r texto.

html paragraph
with: 'Likes: ' , r likes size asString , '| Dislikes: ' , (r reacciones size - r likes size)  asString. 
html anchor
callback: [ CuOOra instancia registrarReaccionDe:(CuOOraComponent instancia usuario) a:r conVoto:true. ];
with: 'like  '.
html anchor
callback: [ CuOOra instancia registrarReaccionDe:(CuOOraComponent instancia usuario) a:r conVoto:false. ];
with: 'dislike'.
html tag: 'hr'.].



html anchor callback: [self desloguear];
  			with: 'logOut'.



]

{ #category : #'as yet unclassified' }
PreguntaDetalleComponent >> verUsuario:usu [ 
 | usuario |
usuario:= UsuarioDetalleComponent new:usu.
self call: usuario.
]
