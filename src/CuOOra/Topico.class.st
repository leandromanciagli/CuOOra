Class {
	#name : #Topico,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'descripcion',
		'preguntas'
	],
	#category : #CuOOra
}

{ #category : #'as yet unclassified' }
Topico class >> crearTopico:nom descripcion:descrip [ 
		^ self new nombre:nom descripcion:descrip. 
]

{ #category : #accessing }
Topico >> descripcion [
	^ descripcion
]

{ #category : #initialization }
Topico >> initialize [
	preguntas:= OrderedCollection new.
	
]

{ #category : #accessing }
Topico >> nombre [
	^ nombre
]

{ #category : #accessing }
Topico >> nombre:nom descripcion:descrip [
    nombre:= nom.
	 descripcion:= descrip.
]

{ #category : #accessing }
Topico >> preguntas [
	^ preguntas
]

{ #category : #accessing }
Topico >> preguntas: anObject [
	preguntas := anObject
]
