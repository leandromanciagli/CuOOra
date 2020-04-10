Class {
	#name : #UsuarioDetalleComponent,
	#superclass : #WAComponent,
	#instVars : [
		'usuario'
	],
	#category : #CuOOraWeb
}

{ #category : #'instance creation' }
UsuarioDetalleComponent class >> new:usuario [
	^ self new usuario:usuario.
]

{ #category : #rendering }
UsuarioDetalleComponent >> renderContentOn: html [ 
 | web |
web:=CuOOraComponent instancia. "para tener el usuario logueado"
html heading: 'Preguntas de ', usuario nombre.
(usuario == web usuario  ) "el usuario logueado es el usuario del que se ve su perfil?"
ifFalse:[(usuario seguidores includes: (web usuario )) 
			ifTrue:[html text: 'Ya sigues a este usuario']
			ifFalse:[html anchor callback: [web usuario seguir:usuario]; "el  2do usuario es el usuario cuyo perfil estoy 																							 																							viendo"
						with: 'Seguir'.
                  ].
        ].

(( usuario preguntasRealizadas )) do: [ :p |
html div.
html heading
level: 3;
with: p titulo.
html anchor callback: [ self verPregunta: p ]; with: 'ver'.
html paragraph
with: 'topicos:' , p topicos.
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
html tag: 'br'.
html anchor 
	callback: [ self renderHome]; "redireccionar al home"
	with: 'volver'.  

	
]

{ #category : #rendering }
UsuarioDetalleComponent >> renderHome [
	
 	self answer: nil.
]

{ #category : #accessing }
UsuarioDetalleComponent >> usuario [
	^ usuario
]

{ #category : #accessing }
UsuarioDetalleComponent >> usuario: anObject [
	usuario := anObject
]

{ #category : #'as yet unclassified' }
UsuarioDetalleComponent >> verPregunta:preg [ 
 | pregunta |
pregunta:= PreguntaDetalleComponent new:preg.
self call: pregunta.
]
