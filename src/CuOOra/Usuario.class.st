Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'contrasena',
		'preguntas',
		'respuestas',
		'topicosDeInteres',
		'fechaHora',
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

{ #category : #'instance creation' }
Usuario class >> nuevoConNombre: unNombre yContrasena: unaContrasena [
	^ self new inicializarConNombre: unNombre yContrasena: unaContrasena
]

{ #category : #adding }
Usuario >> agregarPregunta: unaRespuesta [
	preguntas add: unaRespuesta 
]

{ #category : #adding }
Usuario >> agregarRespuesta: unaRespuesta [
	respuestas add: unaRespuesta
]

{ #category : #adding }
Usuario >> agregarTopicoDeInteres: unTopico [
	topicosDeInteres add: unTopico
]

{ #category : #deleting }
Usuario >> borrarPregunta: unaPregunta [
	self quitarPregunta: unaPregunta.
	unaPregunta quitarseDeLosTopicos.
	unaPregunta borrarRespuestas.
	unaPregunta borrarReacciones
]

{ #category : #calculating }
Usuario >> calcularPuntaje [
	| puntajePorPreguntas puntajePorRespuestas puntajePorVotacion |
	puntajePorPreguntas := self preguntasRealizadas size * 20.
	puntajePorRespuestas := self respuestasAPreguntasDeOtrosUsuarios size * 50.
	puntajePorVotacion := self publicaciones inject: 0 into: [ :acumulador :publicacion | acumulador + publicacion puntaje ].
	^ puntajePorPreguntas + puntajePorRespuestas + puntajePorVotacion 
]

{ #category : #accessing }
Usuario >> contrasena [
	^ contrasena
]

{ #category : #'instance initialization' }
Usuario >> inicializarConNombre: unNombre yContrasena: unaContrasena [
	nombre := unNombre.
	contrasena := unaContrasena
]

{ #category : #initialization }
Usuario >> initialize [
	fechaHora := DateAndTime today.
	preguntas := OrderedCollection new.
	respuestas := OrderedCollection new.
	topicosDeInteres := OrderedCollection new.
	seguidos := OrderedCollection new
]

{ #category : #accessing }
Usuario >> nombre [
	^ nombre
]

{ #category : #'search and filtering' }
Usuario >> obtenerPreguntasRelevantes [
	| preguntasRelevantes |
	preguntasRelevantes := (self preguntasDeInteres, self preguntasDeSeguidos) asSet.
	preguntasRelevantes := preguntasRelevantes
		asSortedCollection: [ :pregunta1 :pregunta2 | pregunta1 fechaHora > pregunta2 fechaHora ].
	^ preguntasRelevantes
]

{ #category : #'search and filtering' }
Usuario >> preguntasDeInteres [
	^ self topicosDeInteres flatCollect: [ :topico | topico preguntas ]
]

{ #category : #'search and filtering' }
Usuario >> preguntasDeSeguidos [
	^ self seguidos flatCollect: [ :usuario | usuario preguntasRealizadas ]
]

{ #category : #accessing }
Usuario >> preguntasRealizadas [
	^ preguntas
]

{ #category : #accessing }
Usuario >> publicaciones [
	^ (self preguntasRealizadas , self respuestasRealizadas) asSet
]

{ #category : #removing }
Usuario >> quitarPregunta: unaPregunta [
	preguntas remove: unaPregunta ifAbsent: [ ^ false ].
	^ true
]

{ #category : #removing }
Usuario >> quitarRespuesta: unaRespuesta [
	respuestas remove: unaRespuesta ifAbsent: [ ^ false ].
	^ true
]

{ #category : #'search and filtering' }
Usuario >> respuestasAPreguntasDeOtrosUsuarios [
	^ respuestas
		reject: [ :respuesta | respuesta preguntaEsDelUsuario: self ]
]

{ #category : #'search and filtering' }
Usuario >> respuestasRealizadas [
	^ respuestas
]

{ #category : #accessing }
Usuario >> seguidos [
	^ seguidos
]

{ #category : #adding }
Usuario >> seguirAlUsuario: unUsuario [
	seguidos add: unUsuario
]

{ #category : #accessing }
Usuario >> topicosDeInteres [
	^ topicosDeInteres
]
