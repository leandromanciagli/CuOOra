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
		^ self new nuevoConNombre:nom yDescripcion:descrip. 
]

{ #category : #'as yet unclassified' }
Topico >> agregarPregunta: unaPregunta [
	preguntas add: unaPregunta
]

{ #category : #'as yet unclassified' }
Topico >> borrarPregunta: unaPregunta [
	"(preguntas includes: unaPregunta) es necesario"
	preguntas remove: unaPregunta
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
Topico >> nuevoConNombre: unNombre yDescripcion: unaDescripcion [
	nombre := unNombre.
	descripcion := unaDescripcion
]

{ #category : #'as yet unclassified' }
Topico >> preguntas [
	^ preguntas.
]

{ #category : #accessing }
Topico >> preguntas: anObject [
	preguntas := anObject
]
