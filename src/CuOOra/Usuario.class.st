Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'contrasena',
		'preguntas',
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
Usuario >> agregarPregunta: unaPregunta [
	preguntas add: unaPregunta 
]

{ #category : #adding }
Usuario >> agregarTopicoDeInteres: unTopico [
	topicosDeInteres add: unTopico
]

{ #category : #calculating }
Usuario >> calcularPuntaje [
	| puntajePorPreguntas puntajePorRespuestas puntajePorVotacion |
	puntajePorPreguntas := self preguntasRealizadas size * 20.
	puntajePorRespuestas := self respuestasAPreguntasDeOtrosUsuarios size * 50.
	puntajePorVotacion := self publicaciones inject: 0 into: [ :sum :p | sum + p puntaje ]. "ver este"
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
	topicosDeInteres := OrderedCollection new.
	seguidos := OrderedCollection new.
	preguntas := OrderedCollection new
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
		asSortedCollection: [ :pr1 :pr2 | pr1 fechaHora > pr2 fechaHora ].
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
	^ (self respuestasRealizadas , self preguntasRealizadas) asSet
]

{ #category : #deleting }
Usuario >> quitarPregunta: unaPregunta [
	preguntas remove: unaPregunta ifAbsent: [ ^ false ].
	^ true
]

{ #category : #'search and filtering' }
Usuario >> respuestasALasPreguntas: unasPreguntas [
	| respuestas |
	respuestas := unasPreguntas
		flatCollect: [ :pregunta | pregunta obtenerRespuestasPorPuntaje ].
	^ respuestas
		select: [ :respuesta | respuesta respuestaEsDelUsuario: self ]
]

{ #category : #'search and filtering' }
Usuario >> respuestasAPreguntasDeOtrosUsuarios [
	^ self respuestasALasPreguntas: self obtenerPreguntasRelevantes
]

{ #category : #'search and filtering' }
Usuario >> respuestasAPreguntasPropias [
	^ self respuestasALasPreguntas: self preguntasRealizadas
]

{ #category : #'search and filtering' }
Usuario >> respuestasRealizadas [
	^ (self respuestasAPreguntasPropias, self respuestasAPreguntasDeOtrosUsuarios) asSet

	"Todas las respuestas que dió un usuario."
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
