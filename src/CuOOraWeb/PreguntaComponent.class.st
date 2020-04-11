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
	
(CuOOra instancia) crearPreguntaConTitulo: titulo  descripcion:descripcion porUsuario:(CuOOraComponent instancia usuario) yTopicos:self topicosIngresados.

 self answer: nil.

]

{ #category : #'as yet unclassified' }
PreguntaComponent >> cancelar [
	titulo := nil.
	descripcion := nil.
	topicos := nil.
	self answer
]

{ #category : #accessing }
PreguntaComponent >> descripcion [
	^ descripcion
]

{ #category : #accessing }
PreguntaComponent >> descripcion: anObject [
	descripcion := anObject
]

{ #category : #'as yet unclassified' }
PreguntaComponent >> desloguear [

 CuOOraComponent instancia usuario: nil.
 self answer: nil.
]

{ #category : #rendering }
PreguntaComponent >> renderContentOn: html [
	| usuarioLogueado |
	usuarioLogueado := CuOOraComponent instancia usuario.
	html anchor
		callback: [ self verUsuario: usuarioLogueado ];
		with: usuarioLogueado nombre.
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
			html submitButton
				callback: [ self agregarPregunta ];
				"llamar al metodo que agrega la pregunta"
					value: 'Agregar' ].	"fin"
	html anchor
		callback: [ self renderHome ];
		with: 'volver'.
	html space.
	html anchor
		callback: [ self desloguear ];
		with: 'logOut'
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
^ t collect: [ :topic | CuOOra instancia buscarTopicoConNombre: topic ].

"getTopicos esta en el model de cuoora y busca si los topicos ingresados son los que existen"
]

{ #category : #'as yet unclassified' }
PreguntaComponent >> verUsuario: unUsuario [
	self call: (UsuarioDetalleComponent new: unUsuario)
]
