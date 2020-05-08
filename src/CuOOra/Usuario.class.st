Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'contrasena',
		'preguntas',
		'publicaciones',
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
	puntajePorPreguntas := self preguntas size * 20.
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

{ #category : #'search and filtering' }
Usuario >> misRespuestasAMisPreguntas [ "Me quedo con las respuestas hechas por mí a preguntas mías"
	|respuestas|
	respuestas:=  self preguntas flatCollect: [ :preg | preg obtenerRespuestasPorPuntaje ].
	
	^ respuestas select: [ :respuesta | respuesta respuestaEsDelUsuario:self ].



	
]

{ #category : #accessing }
Usuario >> nombre [
	^ nombre
]

{ #category : #'search and filtering' }
Usuario >> obtenerPreguntasRelevantes [
	| preguntasRelevantes |
	preguntasRelevantes := (self preguntasDeInteres
		, self preguntasDeSeguidos) asSet.
	preguntasRelevantes := preguntasRelevantes
		asSortedCollection: [ :pr1 :pr2 | pr1 fechaHora > pr2 fechaHora ].
	^ preguntasRelevantes
]

{ #category : #accessing }
Usuario >> preguntas [
	^ preguntas
]

{ #category : #'search and filtering' }
Usuario >> preguntasDeInteres [
	^ self topicosDeInteres flatCollect: [ :each | each preguntas ]
]

{ #category : #'search and filtering' }
Usuario >> preguntasDeSeguidos [
	^ self seguidos flatCollect: [ :each | each preguntas ]
]

{ #category : #accessing }
Usuario >> publicaciones [
	^ (self respuestasRealizadas 
		, self preguntas) asSet
]

{ #category : #deleting }
Usuario >> quitarPregunta: unaPregunta [
	preguntas remove: unaPregunta ifAbsent: [ ^ false ].
	^ true.
	
]

{ #category : #'search and filtering' }
Usuario >> respuestasAPreguntasDeOtrosUsuarios [
	| respuestas |
	respuestas := self obtenerPreguntasRelevantes
		flatCollect: [ :pre | pre obtenerRespuestasPorPuntaje ].
	^ respuestas
		select: [ :respuesta | respuesta respuestaEsDelUsuario: self ]
]

{ #category : #'search and filtering' }
Usuario >> respuestasRealizadas [
	"Conocer las respuestas que dió un usuario."

	^ (self misRespuestasAMisPreguntas
		, self respuestasAPreguntasDeOtrosUsuarios) asSet
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
