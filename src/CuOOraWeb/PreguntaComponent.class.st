Class {
	#name : #PreguntaComponent,
	#superclass : #WAComponent,
	#instVars : [
		'header',
		'titulo',
		'descripcion',
		'topicos'
	],
	#category : #CuOOraWeb
}

{ #category : #callbacks }
PreguntaComponent >> agregarPregunta [
	CuOOra instancia
		crearPreguntaConTitulo: titulo
		descripcion: descripcion
		porUsuario: self session usuario
		yTopicos: self topicosIngresados.
	self volver
]

{ #category : #callbacks }
PreguntaComponent >> cancelar [
	titulo := nil.
	descripcion := nil.
	topicos := nil
]

{ #category : #accessing }
PreguntaComponent >> descripcion [
	^ descripcion
]

{ #category : #accessing }
PreguntaComponent >> descripcion: anObject [
	descripcion := anObject
]

{ #category : #initialization }
PreguntaComponent >> initialize [
	super initialize.
	header := HeaderComponent newConPadre: self
]

{ #category : #rendering }
PreguntaComponent >> renderContentOn: html [
	html render: header.
	html heading: 'Haga una pregunta'.
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
			html button
				callback: [ self cancelar ];
				value: 'Cancelar'.
			"Llamar al metodo que agrega la pregunta"
			html submitButton
				callback: [ self agregarPregunta ];
				value: 'Agregar' ].
	html anchor
		callback: [ self volver ];
		with: 'volver'
]

{ #category : #accessing }
PreguntaComponent >> titulo [
	^ titulo
]

{ #category : #accessing }
PreguntaComponent >> titulo: anObject [
	titulo := anObject
]

{ #category : #accessing }
PreguntaComponent >> topicos [
	^ topicos
]

{ #category : #accessing }
PreguntaComponent >> topicos: anObject [
	topicos := anObject
]

{ #category : #accessing }
PreguntaComponent >> topicosIngresados [
	| t |
	t := self topicos splitOn: ','.
	^ t
		collect: [ :topico | CuOOra instancia buscarTopicoConNombre: topico ]

	"buscarTopicoConNombre: esta en el model de cuoora y busca si los topicos ingresados existen. En caso de no existir, lo crea"
]

{ #category : #callbacks }
PreguntaComponent >> volver [
	self cancelar.
	self answer
]
