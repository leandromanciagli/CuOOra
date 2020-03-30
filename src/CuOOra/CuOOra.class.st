Class {
	#name : #CuOOra,
	#superclass : #Object,
	#instVars : [
		'usuarios',
		'topicos'
	],
	#classInstVars : [
		'instance',
		'cuoora'
	],
	#category : #CuOOra
}

{ #category : #'as yet unclassified' }
CuOOra >> agregarTopico:unTopico [
	topicos add: unTopico.
]

{ #category : #'as yet unclassified' }
CuOOra >> agregarTopico:nom descripcion:descrip [ 
|top|
	top:=Topico crearTopico: nom descripcion:descrip.
	topicos add: top.
]

{ #category : #'as yet unclassified' }
CuOOra >> crearNuevoUsuario:nombre cont:contrasena [
|usuario|
usuario:= Usuario nuevo: nombre y:contrasena.
usuarios add:usuario. 
	
]

{ #category : #initialization }
CuOOra >> initialize [ 
	usuarios := OrderedCollection new.
	topicos := OrderedCollection new.
	
]

{ #category : #accessing }
CuOOra >> topicos [
	^ topicos
]

{ #category : #accessing }
CuOOra >> topicos: anObject [
	topicos := anObject
]

{ #category : #'as yet unclassified' }
CuOOra >> usuario:unUsuario sigue:otroUsuario [
	unUsuario seguir:otroUsuario.
]

{ #category : #accessing }
CuOOra >> usuarios [
	^ usuarios
]

{ #category : #accessing }
CuOOra >> usuarios: anObject [
	usuarios := anObject
]
