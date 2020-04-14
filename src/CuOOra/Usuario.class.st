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

{ #category : #adding }
Usuario >> agregarPublicacion: unaPublicacion [
	publicaciones add: unaPublicacion
]

{ #category : #adding }
Usuario >> agregarSeguidor: unSeguidor [
	seguidores add: unSeguidor
]

{ #category : #adding }
Usuario >> agregarTopicoDeInteres: unTopico [
	intereses add: unTopico
]

{ #category : #deleting }
Usuario >> borrarPublicacion: unaPublicacion [
	(publicaciones includes: unaPublicacion)
		ifTrue: [ publicaciones remove: unaPublicacion.
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
Usuario >> nombre [
	^ nombre
]

{ #category : #'instance initialization' }
Usuario >> nuevoConNombre: unNombre yContrasena: unaContrasena [
	nombre := unNombre.
	contrasena := unaContrasena
]

{ #category : #'search and filtering' }
Usuario >> obtenerPreguntasRelevantes [
	| preguntasRelevantes |
	preguntasRelevantes := (self preguntasDeInteres
		, self preguntasDeSeguidos) asSet.
	preguntasRelevantes := preguntasRelevantes
		asSortedCollection: [ :pr1 :pr2 | pr1 fechaHora > pr2 fechaHora ].
	^ preguntasRelevantes takeFirst: 5
]

{ #category : #'search and filtering' }
Usuario >> preguntasDeInteres [
	^ self intereses flatCollect: [ :each | each preguntas ]
]

{ #category : #'search and filtering' }
Usuario >> preguntasDeSeguidos [
	^ self seguidos flatCollect: [ :each | each preguntasRealizadas ]
]

{ #category : #'search and filtering' }
Usuario >> preguntasRealizadas [
	^ publicaciones select: [ :p | p esPregunta ].

]

{ #category : #accessing }
Usuario >> publicaciones [
	^ publicaciones
]

{ #category : #'search and filtering' }
Usuario >> respuestasAPreguntasDeOtrosUsuarios [
	^ self respuestasRealizadas
		reject: [ :respuesta | respuesta pregunta usuario = self ]
]

{ #category : #'search and filtering' }
Usuario >> respuestasRealizadas [
	^ publicaciones select: [ :p | p esRespuesta ].

]

{ #category : #accessing }
Usuario >> seguidos [
	^ seguidos
]

{ #category : #adding }
Usuario >> seguirAlUsuario: unUsuario [
	seguidos add: unUsuario.
	unUsuario agregarSeguidor: self
]
