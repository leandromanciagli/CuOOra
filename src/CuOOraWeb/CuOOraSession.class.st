Class {
	#name : #CuOOraSession,
	#superclass : #WASession,
	#instVars : [
		'usuario'
	],
	#category : #CuOOraWeb
}

{ #category : #accessing }
CuOOraSession >> usuario [
	^ usuario
]

{ #category : #accessing }
CuOOraSession >> usuario: unUsuario [
	usuario := unUsuario
]
