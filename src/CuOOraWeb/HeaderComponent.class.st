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
	html heading
		level: 2;
		with: 'CuOOra'.
	self renderPerfilUsuarioButtonOn: html.
	html break.
	self renderLogoutButtonOn: html.
	html horizontalRule
]

{ #category : #rendering }
HeaderComponent >> renderLogoutButtonOn: html [
	html anchor
		callback: [ self logout ];
		with: [ html button with: 'LogOut' ]
]

{ #category : #rendering }
HeaderComponent >> renderPerfilUsuarioButtonOn: html [
	html anchor
		callback: [ self renderUsuarioDetalle: self session usuario ];
		with: self session usuario nombre
]

{ #category : #rendering }
HeaderComponent >> renderUsuarioDetalle: unUsuario [
	padre call: (UsuarioDetalleComponent newConUsuario: unUsuario)
]
