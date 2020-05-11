Class {
	#name : #HomeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'headerComponent'
	],
	#category : #CuOOraWeb
}

{ #category : #initialization }
HomeComponent >> initialize [
	super initialize.
	headerComponent := HeaderComponent newConPadre: self
]

{ #category : #rendering }
HomeComponent >> renderAgregarPreguntaButtonOn: html [
	html
		paragraph: [ html anchor
				callback: [ self renderCrearPregunta ];
				with: [ html button with: 'Agrega nueva pregunta' ] ]
]

{ #category : #rendering }
HomeComponent >> renderContentOn: html [
	html render: headerComponent.
	html heading: 'Ultimas preguntas'.
	self renderPreguntas: (self session usuario obtenerPreguntasRelevantes takeFirst: 5) on: html.
	self renderAgregarPreguntaButtonOn: html.
]

{ #category : #rendering }
HomeComponent >> renderCrearPregunta [
	self call: CrearPreguntaComponent new
]

{ #category : #rendering }
HomeComponent >> renderPreguntas: unasPreguntas on: html [
	unasPreguntas
		do:
			[ :pregunta | html render: (PreguntaComponent newConPadre: self yPregunta: pregunta) ]
]
