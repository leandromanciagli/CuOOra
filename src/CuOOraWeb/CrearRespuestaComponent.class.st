Class {
	#name : #CrearRespuestaComponent,
	#superclass : #WAComponent,
	#instVars : [
		'headerComponent',
		'newTexto',
		'pregunta'
	],
	#category : #CuOOraWeb
}

{ #category : #'instance creation' }
CrearRespuestaComponent class >> pregunta: unaPregunta [
	^ self new pregunta: unaPregunta
]

{ #category : #callbacks }
CrearRespuestaComponent >> agregarRespuesta [
	CuOOra instancia
		crearRespuestaConTexto: newTexto
		aPregunta: pregunta
		porUsuario: self session usuario.
	self volver
]

{ #category : #callbacks }
CrearRespuestaComponent >> cancelar [
	newTexto := nil.
	
]

{ #category : #initialization }
CrearRespuestaComponent >> initialize [
	super initialize.
	headerComponent := HeaderComponent newConPadre: self
]

{ #category : #accessing }
CrearRespuestaComponent >> newTexto [
	^ newTexto
]

{ #category : #accessing }
CrearRespuestaComponent >> newTexto: unTexto [
	newTexto := unTexto
]

{ #category : #accessing }
CrearRespuestaComponent >> pregunta: unaPregunta [
	pregunta := unaPregunta
]

{ #category : #rendering }
CrearRespuestaComponent >> renderCancelarButtonOn: html [
	html anchor
		callback: [ self cancelar ];
		with: [ html button with: 'Cancelar' ]
]

{ #category : #rendering }
CrearRespuestaComponent >> renderContentOn: html [
	html render: headerComponent.
	html render: (PreguntaComponent newConPadre: self yPregunta: pregunta).
	html paragraph with: 'RESPONDER'.
	self renderFormOn: html.
	self renderVolverButtonOn: html
]

{ #category : #rendering }
CrearRespuestaComponent >> renderFormOn: html [
	html
		form: [ html textArea on: #newTexto of: self.
			self renderCancelarButtonOn: html.
			self renderSubmitButtonOn: html ]
]

{ #category : #rendering }
CrearRespuestaComponent >> renderSubmitButtonOn: html [
	html submitButton
		callback: [ self agregarRespuesta ];
		value: 'Guardar'
]

{ #category : #rendering }
CrearRespuestaComponent >> renderVolverButtonOn: html [
	html anchor
		callback: [ self volver ];
		with: [ html button with: 'Volver' ]
]

{ #category : #callbacks }
CrearRespuestaComponent >> volver [
	self cancelar.
	self answer
]
