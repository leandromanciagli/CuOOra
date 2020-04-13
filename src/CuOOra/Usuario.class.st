Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'intereses',
		'publicaciones',
		'contrasena',
		'fechaHora',
		'seguidores',
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
	^ self new nuevoConNombre: unNombre yContrasena: unaContrasena
]

{ #category : #'as yet unclassified' }
Usuario >> agregarPublicacion: unaPublicacion [
	publicaciones add: unaPublicacion
]

{ #category : #'as yet unclassified' }
Usuario >> agregarSeguidor: unSeguidor [
	seguidores add: unSeguidor
]

{ #category : #'as yet unclassified' }
Usuario >> agregarTopicoDeInteres: unTopico [
	intereses add: unTopico
]

{ #category : #'as yet unclassified' }
Usuario >> borrarPregunta: unaPregunta [
	(publicaciones includes: unaPregunta)
		ifTrue: [ publicaciones remove: unaPregunta.
			^ true ].
	^ false
]

{ #category : #'as yet unclassified' }
Usuario >> borrarRespuesta: unaRespuesta [
	(publicaciones includes: unaRespuesta)
		ifTrue: [ publicaciones remove: unaRespuesta.
			^ true ].
	^ false
]

{ #category : #accessing }
Usuario >> contrasena [
	^ contrasena
]

{ #category : #initialization }
Usuario >> initialize [
	fechaHora := DateAndTime today.
	intereses := OrderedCollection new.
	seguidores := OrderedCollection new.
	seguidos := OrderedCollection new.
	publicaciones := OrderedCollection new
]

{ #category : #accessing }
Usuario >> intereses [
	^ intereses
]

{ #category : #accessing }
Usuario >> intereses: anObject [
	intereses := anObject
]

{ #category : #accessing }
Usuario >> nombre [
	^ nombre
]

{ #category : #accessing }
Usuario >> nuevoConNombre: unNombre yContrasena: unaContrasena [
	nombre := unNombre.
	contrasena := unaContrasena
]

{ #category : #'as yet unclassified' }
Usuario >> obtenerPreguntasRelevantes [
	| preguntasRelevantes |
	preguntasRelevantes := (self preguntasDeInteres
		, self preguntasDeSeguidos) asSet.
	preguntasRelevantes := preguntasRelevantes
		asSortedCollection: [ :pr1 :pr2 | pr1 fechaHora > pr2 fechaHora ].
	^ preguntasRelevantes first: 5
]

{ #category : #'as yet unclassified' }
Usuario >> preguntasDeInteres [
	^ self intereses flatCollect: [ :each | each preguntas ]
]

{ #category : #'as yet unclassified' }
Usuario >> preguntasDeSeguidos [
	^ self seguidos flatCollect: [ :each | each preguntasRealizadas ]
]

{ #category : #'as yet unclassified' }
Usuario >> preguntasRealizadas [
	^ publicaciones select: [ :p | p esPregunta ].

]

{ #category : #accessing }
Usuario >> publicaciones [
	^ publicaciones
]

{ #category : #'as yet unclassified' }
Usuario >> respuestasAPreguntasDeOtrosUsuarios [
	^ self respuestasRealizadas
		reject: [ :respuesta | respuesta pregunta usuario = self ]
]

{ #category : #'as yet unclassified' }
Usuario >> respuestasRealizadas [
	^ publicaciones select: [ :p | p esRespuesta ].

]

{ #category : #accessing }
Usuario >> seguidores [
	^ seguidores
]

{ #category : #accessing }
Usuario >> seguidos [
	^ seguidos
]

{ #category : #'as yet unclassified' }
Usuario >> seguirAlUsuario: unUsuario [
	seguidos add: unUsuario.
	unUsuario agregarSeguidor: self
]
