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

{ #category : #'instance creation' }
Pregunta class >> nuevaConTitulo: unTitulo descripcion: unaDescripcion porUsuario: unUsuario yTopicos: unTopico [
	^ self new
		inicializarConTitulo: unTitulo
		descripcion: unaDescripcion
		porUsuario: unUsuario
		yTopicos: unTopico
]

{ #category : #adding }
Pregunta >> agregarRespuesta: unaRespuesta [
	respuestas add: unaRespuesta.
	unaRespuesta pregunta: self
]

{ #category : #deleting }
Pregunta >> borrarRespuestas [
	respuestas
		do: [ :respuesta | 
			respuesta borrarReacciones.
			respuesta usuario quitarRespuesta: respuesta ]
]

{ #category : #'instance initialization' }
Pregunta >> inicializarConTitulo: unTitulo descripcion: unaDescripcion porUsuario: unUsuario yTopicos: unosTopicos [
	titulo := unTitulo.
	descripcion := unaDescripcion.
	usuario := unUsuario.
	topicos := unosTopicos
]

{ #category : #initialization }
Pregunta >> initialize [
	super initialize.
	respuestas := OrderedCollection new
]

{ #category : #accessing }
Pregunta >> obtenerRespuestasPorPuntaje [
	^ respuestas
		asSortedCollection: [ :respuesta1 :respuesta2 | respuesta1 puntaje > respuesta2 puntaje ]
]

{ #category : #'submorphs-add/remove' }
Pregunta >> quitarseDeLosTopicos [
	topicos do: [ :topico | topico quitarPregunta: self ]
]

{ #category : #accessing }
Pregunta >> titulo [
	^ titulo
]

{ #category : #accessing }
Pregunta >> topicos [
	^ String
		streamContents: [ :s | 
			topicos
				do: [ :each | 
					s
						nextPutAll: each nombre;
						nextPutAll: ', ' ] ]
				
	"Devuelve la coleccion de topicos como un string separados por coma"
	"^ topicos"
	"String streamContents: [:stream | #(’bob’ ’joe’ ’toto’) asStringOn: stream delimiter: ’.’ ] -→ ’bob.joe.toto’"
	"nextPutAll:agrega cada elemento de la colección, pasado como parámetro, a la secuencia;"
	"String streamContents: [ : tempStream |     
  (1 a: 100000)   
       hacer: [ : i | tempStream nextPutAll: i asString ; espacio ]]  "
]
