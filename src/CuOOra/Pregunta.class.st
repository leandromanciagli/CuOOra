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
		nuevaConTitulo: unTitulo
		descripcion: unaDescripcion
		porUsuario: unUsuario
		yTopicos: unTopico
]

{ #category : #adding }
Pregunta >> agregarRespuesta: unaRespuesta [
	respuestas add: unaRespuesta
]

{ #category : #'submorphs-add/remove' }
Pregunta >> delete [
	usuario quitarPublicacion: self.	"La pregunta se quita de la coleccion de publicaciones del usuario"
	topicos do: [ :top | top quitarPregunta: self ]. "La pregunta se quita de cada topico al que pertenece"
	respuestas do: [ :resp | resp delete ]. "Cada respuesta de la pregunta se quita de la coleccion de publicaciones del usuario"
	respuestas := nil. "Se borran todas las respuestas asociadas a la pregunta"
	reacciones do: [ :reaccion | reaccion borrarPublicacion ]. "La pregunta se quita de cada reaccion a la que pertenece"
	reacciones := nil "Se borran todas las reacciones asociadas a la pregunta"
]

{ #category : #overrided }
Pregunta >> esPregunta [
	^ true
]

{ #category : #initialization }
Pregunta >> initialize [
	super initialize.
	respuestas := OrderedCollection new
]

{ #category : #'instance initialization' }
Pregunta >> nuevaConTitulo: unTitulo descripcion: unaDescripcion porUsuario: unUsuario yTopicos: unosTopicos [
	titulo := unTitulo.
	descripcion := unaDescripcion.
	usuario := unUsuario.
	topicos := unosTopicos
]

{ #category : #accessing }
Pregunta >> obtenerRespuestasPorPuntaje [
	^ respuestas
		asSortedCollection: [ :r1 :r2 | r1 puntaje > r2 puntaje ]
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
