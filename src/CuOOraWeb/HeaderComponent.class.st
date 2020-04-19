Class {
	#name : #HeaderComponent,
	#superclass : #WAComponent,
	#instVars : [
		'padre'
	],
	#category : #CuOOraWeb
}

{ #category : #'instance creation' }
HeaderComponent class >> newConPadre: unPadre [
	^ self new padre: unPadre
]

{ #category : #callbacks }
HeaderComponent >> logout [
	self session usuario: nil.
	self session presenter home
]

{ #category : #accessing }
HeaderComponent >> padre: unPadre [
	padre := unPadre
]

{ #category : #rendering }
HeaderComponent >> renderContentOn: html [
	| usuarioLogueado |
	usuarioLogueado := self session usuario.
	html heading
		level: 2;
		with: 'CuOOra'.
	html anchor
		callback: [ self renderPerfil: usuarioLogueado ];
		with: usuarioLogueado nombre.
	html break.
	html anchor
		callback: [ self logout ];
		with: 'logOut'.
	html horizontalRule
]

{ #category : #rendering }
HeaderComponent >> renderPerfil: unUsuario [
	padre call: (UsuarioDetalleComponent new: unUsuario)
]
