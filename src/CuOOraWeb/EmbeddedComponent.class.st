Class {
	#name : #EmbeddedComponent,
	#superclass : #WAComponent,
	#instVars : [
		'padre'
	],
	#category : #CuOOraWeb
}

{ #category : #'instance creation' }
EmbeddedComponent class >> newConPadre: unPadre [
	^ self new padre: unPadre
]

{ #category : #accessing }
EmbeddedComponent >> padre: unPadre [
	padre := unPadre
]

{ #category : #accessing }
EmbeddedComponent >> renderPerfilUsuarioButtonOn: html [ 
	^ self subclassResponsibility
]

{ #category : #rendering }
EmbeddedComponent >> renderUsuarioDetalle: unUsuario [
	padre call: (UsuarioDetalleComponent newConUsuario: unUsuario)
]
