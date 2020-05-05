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
	^ self new inicializarConNombre: unNombre yDescripcion: unaDescripcion
]

{ #category : #adding }
Topico >> agregarPregunta: unaPregunta [
	preguntas add: unaPregunta
]

{ #category : #accessing }
Topico >> descripcion [
	^ descripcion
]

{ #category : #'instance initialization' }
Topico >> inicializarConNombre: unNombre yDescripcion: unaDescripcion [
	nombre := unNombre.
	descripcion := unaDescripcion
]

{ #category : #initialization }
Topico >> initialize [
	preguntas := OrderedCollection new
]

{ #category : #accessing }
Topico >> nombre [
	^ nombre
]

{ #category : #accessing }
Topico >> preguntas [
	^ preguntas
]

{ #category : #deleting }
Topico >> quitarPregunta: unaPregunta [
	^ preguntas remove: unaPregunta ifAbsent: [ false ]
]
