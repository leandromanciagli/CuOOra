Class {
	#name : #PreguntaDetalleComponent,
	#superclass : #WAComponent,
	#instVars : [
		'headerComponent',
		'pregunta'
	],
	#category : #CuOOraWeb
}

{ #category : #'instance creation' }
PreguntaDetalleComponent class >> newConPregunta: unaPregunta [
	^ self new inicializarConPregunta: unaPregunta
]

{ #category : #callbacks }
PreguntaDetalleComponent >> agregarRespuesta: unaPregunta [
	self call: (CrearRespuestaComponent pregunta: unaPregunta)
]

{ #category : #accessing }
PreguntaDetalleComponent >> inicializarConPregunta: unaPregunta [
	pregunta := unaPregunta
]

{ #category : #initialization }
PreguntaDetalleComponent >> initialize [
	super initialize.
	headerComponent := HeaderComponent newConPadre: self
]

{ #category : #rendering }
PreguntaDetalleComponent >> renderAgregarRespuestaButtonOn: html [
	html anchor
		callback: [ self agregarRespuesta: pregunta ];
		with: [ html button with: 'Agregar respuesta' ]
]

{ #category : #rendering }
PreguntaDetalleComponent >> renderContentOn: html [
	html render: headerComponent.
	html div.
	html render: (PreguntaComponent newConPadre: self yPregunta: pregunta).
	self renderRespuestasOn: html.
	self renderAgregarRespuestaButtonOn: html.
	html space.
	self renderVolverButtonOn: html
]

{ #category : #rendering }
PreguntaDetalleComponent >> renderRespuestasOn: html [
	pregunta obtenerRespuestasPorPuntaje
		do: [ :respuesta | 
			html
				render: (RespuestaComponent newConPadre: self yRespuesta: respuesta) ]
]

{ #category : #rendering }
PreguntaDetalleComponent >> renderVolverButtonOn: html [
	html anchor
		callback: [ self answer ];
		with: [ html button with: 'Volver' ]
]
