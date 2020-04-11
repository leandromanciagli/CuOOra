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
Pregunta class >> nuevaConTitulo: unTitulo descripcion: unaDescripcion porUsuario: unUsuario yTopicos: unTopico [
	^ self new
		nuevaConTitulo: unTitulo
		descripcion: unaDescripcion
		porUsuario: unUsuario
		yTopicos: unTopico
]

{ #category : #'as yet unclassified' }
Pregunta >> agregarRespuesta: unaRespuesta [
	respuestas add: unaRespuesta
]

{ #category : #'submorphs-add/remove' }
Pregunta >> delete [
	usuario borrarPregunta: self.	"Como la clase pregunta ya conoce al usuario que la hizo ya tenemos el dato usuario como topico"
	topicos do: [ :top | top borrarPregunta: self ].
	respuestas do: [ :resp | resp delete ]
]

{ #category : #'as yet unclassified' }
Pregunta >> esPregunta [
	^ true
]

{ #category : #'as yet unclassified' }
Pregunta >> nuevaConTitulo: unTitulo descripcion: unaDescripcion porUsuario: unUsuario yTopicos: unosTopicos [
	titulo := unTitulo.
	descripcion := unaDescripcion.
	usuario := unUsuario.
	topicos := unosTopicos.
	respuestas := OrderedCollection new
]

{ #category : #'as yet unclassified' }
Pregunta >> obtenerRespuestasPorPuntaje [
	^ respuestas
		asSortedCollection: [ :r1 :r2 | r1 puntaje > r2 puntaje ]
]

{ #category : #accessing }
Pregunta >> respuestas: anObject [
	respuestas := anObject
]

{ #category : #accessing }
Pregunta >> titulo [
	^ titulo
]

{ #category : #accessing }
Pregunta >> topicos [
	"^ topicos"
	"String streamContents: [:stream | #(’bob’ ’joe’ ’toto’) asStringOn: stream delimiter: ’.’ ] -→ ’bob.joe.toto’"
	"nextPutAll:agrega cada elemento de la colección, pasado como parámetro, a la secuencia;"
	"String streamContents: [ : tempStream |     
  (1 a: 100000)   
       hacer: [ : i | tempStream nextPutAll: i asString ; espacio ]]  "
	
^ String streamContents: [:s | 
		topicos  do: [:each | s nextPutAll: each nombre , ', ']].
]

{ #category : #accessing }
Pregunta >> topicos: anObject [
	topicos := anObject
]
