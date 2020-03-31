Class {
	#name : #Publicacion,
	#superclass : #Object,
	#instVars : [
		'reacciones',
		'usuario',
		'fechaHora'
	],
	#category : #CuOOra
}

{ #category : #initialization }
Publicacion >> initialize [ 
	fechaHora := DateAndTime now.
]
