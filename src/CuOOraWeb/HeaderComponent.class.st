Class {
	#name : #HeaderComponent,
	#superclass : #EmbeddedComponent,
	#category : #CuOOraWeb
}

{ #category : #callbacks }
HeaderComponent >> logout [
	self session usuario: nil.
	self session presenter home
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
