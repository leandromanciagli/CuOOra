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

{ #category : #'as yet unclassified' }
Usuario class >> nuevo:nombre y:contrasena [
	^self new nom: nombre cont: contrasena.
]

{ #category : #'as yet unclassified' }
Usuario >> agregarPublicacion:unaPublicacion [
    publicaciones add:unaPublicacion. 
]

{ #category : #'as yet unclassified' }
Usuario >> agregarSeguidor:unSeguidor [
	seguidores add:unSeguidor.
]

{ #category : #'as yet unclassified' }
Usuario >> agregarTopicoInteres:unTopi [
	intereses add:unTopi.
	
]

{ #category : #'as yet unclassified' }
Usuario >> borrarPregunta:unaPregunta [
	"(publicaciones includes: unaPregunta) => Es necesario hacer esta pregunta o esta de mas?"
	publicaciones remove: unaPregunta.
	
	
]

{ #category : #'as yet unclassified' }
Usuario >> borrarPublicacion:unaPregunta [
	"(publicaciones includes: unaPregunta) => Es necesario hacer esta pregunta o esta de mas?"
	publicaciones remove: unaPregunta.
	
	
]

{ #category : #accessing }
Usuario >> contrasena [
		^contrasena.
]

{ #category : #initialization }
Usuario >> initialize [
	fechaHora:= DateAndTime today.
	intereses:= OrderedCollection new.
	seguidores:= OrderedCollection new.
	seguidos:= OrderedCollection new.
	publicaciones := OrderedCollection new.
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
Usuario >> nom:string cont:string1 [
	nombre := string.
	contrasena := string1.
]

{ #category : #accessing }
Usuario >> nombre [ 
	^nombre.
]

{ #category : #'as yet unclassified' }
Usuario >> obtenerPreguntasRelevantes [
	| preguntasRelevantes |

	preguntasRelevantes := (self preguntasDeInteres , self preguntasDeSeguidos) asSet .
	^ preguntasRelevantes asSortedCollection: [:pr1 :pr2 | pr1 fechaHora > pr2 fechaHora ].
	

	


]

{ #category : #'as yet unclassified' }
Usuario >> preguntasDeInteres [
	^ self intereses flatCollect: [ :each | each todasLasPreguntas ]
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

{ #category : #accessing }
Usuario >> publicaciones: anObject [
	publicaciones := anObject
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
Usuario >> seguir:unUsuario [
	seguidos add:unUsuario.
	unUsuario agregarSeguidor: self.
]
