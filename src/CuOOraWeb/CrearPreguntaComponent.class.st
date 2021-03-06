Class {
	#name : #CrearPreguntaComponent,
	#superclass : #LoggerComponent,
	#instVars : [
		'titulo',
		'descripcion',
		'topicos'
	],
	#category : #CuOOraWeb
}

{ #category : #callbacks }
CrearPreguntaComponent >> agregarPregunta [
	CuOOra instancia
		crearPreguntaConTitulo: titulo
		descripcion: descripcion
		porUsuario: self session usuario
		yTopicos: self topicosIngresados.
	self volver
]

{ #category : #callbacks }
CrearPreguntaComponent >> cancelar [
	titulo := nil.
	descripcion := nil.
	topicos := nil
]

{ #category : #accessing }
CrearPreguntaComponent >> descripcion [
	^ descripcion
]

{ #category : #accessing }
CrearPreguntaComponent >> descripcion: unaDescripcion [ 
	descripcion := unaDescripcion
]

{ #category : #rendering }
CrearPreguntaComponent >> renderCancelarButtonOn: html [
	html anchor
		callback: [ self cancelar ];
		with: [ html button with: 'Cancelar' ]
]

{ #category : #rendering }
CrearPreguntaComponent >> renderContentOn: html [
	html render: headerComponent.
	html heading: 'Haga una pregunta'.
	self renderFormOn: html.
	self renderVolverButtonOn: html
]

{ #category : #rendering }
CrearPreguntaComponent >> renderFormOn: html [
	html
		form: [ html text: 'Título: '.
			html textInput on: #titulo of: self.
			html break.
			html tag: 'br'.
			html text: 'Descripción: '.
			html textArea on: #descripcion of: self.
			html break.
			html tag: 'br'.
			html text: 'Tópicos: '.
			html textInput on: #topicos of: self.
			html break.
			html tag: 'br'.
			self renderCancelarButtonOn: html.
			self renderSubmitButtonOn: html ]
]

{ #category : #rendering }
CrearPreguntaComponent >> renderSubmitButtonOn: html [
	html submitButton
		callback: [ self agregarPregunta ];
		value: 'Agregar'
]

{ #category : #rendering }
CrearPreguntaComponent >> renderVolverButtonOn: html [
	html anchor
		callback: [ self volver ];
		with: [ html button with: 'Volver' ]
]

{ #category : #accessing }
CrearPreguntaComponent >> titulo [
	^ titulo
]

{ #category : #accessing }
CrearPreguntaComponent >> titulo: unTitulo [
	titulo := unTitulo
]

{ #category : #accessing }
CrearPreguntaComponent >> topicos [
	^ topicos
]

{ #category : #accessing }
CrearPreguntaComponent >> topicos: unosTopicos [
	topicos := unosTopicos
]

{ #category : #accessing }
CrearPreguntaComponent >> topicosIngresados [
	| topicosIngresados |
	topicosIngresados := self topicos splitOn: ','.
	^ topicosIngresados
		collect: [ :topico | CuOOra instancia buscarYCrearTopico: topico ]
]

{ #category : #callbacks }
CrearPreguntaComponent >> volver [
	self cancelar.
	self answer
]
