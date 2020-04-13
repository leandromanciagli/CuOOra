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

{ #category : #'instance creation' }
Topico class >> nuevoConNombre: unNombre yDescripcion: unaDescripcion [
	^ self new nuevoConNombre: unNombre yDescripcion: unaDescripcion
]

{ #category : #adding }
Topico >> agregarPregunta: unaPregunta [
	preguntas add: unaPregunta
]

{ #category : #deleting }
Topico >> borrarPregunta: unaPregunta [
	(preguntas includes: unaPregunta)
		ifTrue: [ preguntas remove: unaPregunta.
			^ true ].
	^ false
]

{ #category : #accessing }
Topico >> descripcion [
	^ descripcion
]

{ #category : #initialization }
Topico >> initialize [
	preguntas := OrderedCollection new
]

{ #category : #accessing }
Topico >> nombre [
	^ nombre
]

{ #category : #'instance initialization' }
Topico >> nuevoConNombre: unNombre yDescripcion: unaDescripcion [
	nombre := unNombre.
	descripcion := unaDescripcion
]

{ #category : #accessing }
Topico >> preguntas [
	^ preguntas.
]
