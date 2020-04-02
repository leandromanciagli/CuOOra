Class {
	#name : #Pregunta,
	#superclass : #Publicacion,
	#instVars : [
		'topicos',
		'respuestas',
		'titulo',
		'descripcion'
	],
	#category : #CuOOra
}

{ #category : #'as yet unclassified' }
Pregunta class >> nuevoTitulo:unTitulo Descrip:unaDescripcion usu:unUsuario top:unTopico [
	^ self new nuevaPregunta: unTitulo Descrip:unaDescripcion usu:unUsuario topics:unTopico  
	
]

{ #category : #'as yet unclassified' }
Pregunta >> agregarRespuesta:resp [
	respuestas add:resp.
]

{ #category : #'as yet unclassified' }
Pregunta >> nuevaPregunta:unTitulo Descrip:unaDescripcion usu:unUsuario topics:unosTopicos [

	titulo :=unTitulo.
	descripcion :=unaDescripcion.
	usuario := unUsuario.
	topicos :=unosTopicos.
	respuestas := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
Pregunta >> obtenerRespuestas [
 ^ respuestas asSortedCollection: [:r1 :r2 | r1 puntaje  > r2 puntaje]. 
]

{ #category : #accessing }
Pregunta >> respuestas: anObject [
	respuestas := anObject
]

{ #category : #accessing }
Pregunta >> topicos [
	^ topicos
]

{ #category : #accessing }
Pregunta >> topicos: anObject [
	topicos := anObject
]
