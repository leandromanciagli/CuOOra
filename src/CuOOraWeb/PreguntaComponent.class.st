Class {
	#name : #PreguntaComponent,
	#superclass : #WAComponent,
	#instVars : [
		'titulo',
		'descripcion',
		'topicos'
	],
	#category : #CuOOraWeb
}

{ #category : #'as yet unclassified' }
PreguntaComponent >> agregarPregunta [
	
(CuOOra instancia) agregarPregunta: titulo  Descrip:descripcion usu:(CuOOraComponent instancia usuario) topics:self topicosIngresados.

 self answer: nil.

]

{ #category : #accessing }
PreguntaComponent >> descripcion [
	^ descripcion
]

{ #category : #accessing }
PreguntaComponent >> descripcion: anObject [
	descripcion := anObject
]

{ #category : #rendering }
PreguntaComponent >> renderContentOn: html [
	html heading: 'Haga una pregunta'.
	
	html form:[
		html text: 'Título: '.
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
		
		html submitButton
			callback: [ self agregarPregunta ];  "llamar al metodo que agrega la pregunta"
			value: 'Agregar'.
	]. "fin"
	html anchor 
	callback: [ self renderHome]; "redireccionar al home"
	with: 'volver'.  
]

{ #category : #rendering }
PreguntaComponent >> renderHome [
	
 	self answer: nil.
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

{ #category : #'as yet unclassified' }
PreguntaComponent >> topicosIngresados [
|t|
 t:= self topicos splitOn: ','. 
^ t collect: [ :topic | CuOOra instancia getTopicos: topic ].

"getTopicos esta en el model de cuoora y busca si los topicos ingresados son los que existen"
]
