Class {
	#name : #HeaderComponent,
	#superclass : #WAComponent,
	#category : #CuOOraWeb
}

{ #category : #'as yet unclassified' }
HeaderComponent >> desloguear [

 CuOOraComponent instancia usuario: nil.
 self answer: nil.
]

{ #category : #rendering }
HeaderComponent >> renderContentOn: html [ 
	| usuarioLogueado |
	usuarioLogueado := CuOOraComponent instancia usuario.
	html heading level:2;
	with:'CuOOra'.
	html anchor
		callback: [ self verPerfilUsuario: usuarioLogueado ];
		with: usuarioLogueado nombre.
	html break.	
	html anchor
		callback: [ self desloguear ];
		with: 'logOut'.
	html horizontalRule.
]

{ #category : #'as yet unclassified' }
HeaderComponent >> verPerfilUsuario: usu [
	| usuario |
	usuario := UsuarioDetalleComponent new: usu.
	self call: usuario 
]
