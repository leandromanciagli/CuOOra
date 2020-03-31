Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'intereses',
		'publicaciones',
		'contrasena',
		'fechaHora',
		'seguidores',
		'seguidos'
	],
	#classInstVars : [
		'fechaHora',
		'intereses',
		'seguidores',
		'seguidos'
	],
	#category : #CuOOra
}

{ #category : #'as yet unclassified' }
Usuario class >> nuevo:nombre y:contrasena [
	^self new nom: nombre cont: contrasena.
]

{ #category : #'as yet unclassified' }
Usuario >> agregarPregunta:unaPregunta [
    publicaciones add:unaPregunta. 
]

{ #category : #'as yet unclassified' }
Usuario >> agregarSeguidor:unSeguidor [
	seguidores add:unSeguidor.
]

{ #category : #'as yet unclassified' }
Usuario >> agregarTopicoInteres:unTopi [
	intereses add:unTopi.
	
]

{ #category : #accessing }
Usuario >> contrasena [
		^contrasena.
]

{ #category : #initialization }
Usuario >> initialize [
	fechaHora:= DateAndTime today.
	intereses:= OrderedCollection new.
	seguidores:= OrderedCollection new.
	seguidos:= OrderedCollection new.
	publicaciones := OrderedCollection new.
]

{ #category : #accessing }
Usuario >> intereses [
	^ intereses
]

{ #category : #accessing }
Usuario >> intereses: anObject [
	intereses := anObject
]

{ #category : #accessing }
Usuario >> nom:string cont:string1 [
	nombre := string.
	contrasena := string1.
]

{ #category : #accessing }
Usuario >> nombre [ 
	^nombre.
]

{ #category : #accessing }
Usuario >> publicaciones [
	^ publicaciones
]

{ #category : #accessing }
Usuario >> publicaciones: anObject [
	publicaciones := anObject
]

{ #category : #accessing }
Usuario >> seguidores [
	^ seguidores
]

{ #category : #accessing }
Usuario >> seguidos [
	^ seguidos
]

{ #category : #'as yet unclassified' }
Usuario >> seguir:unUsuario [
	seguidos add:unUsuario.
	unUsuario agregarSeguidor: self.
]
