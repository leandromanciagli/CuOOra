Class {
	#name : #LoggerComponent,
	#superclass : #WAComponent,
	#instVars : [
		'headerComponent'
	],
	#category : #CuOOraWeb
}

{ #category : #initialization }
LoggerComponent >> initialize [
	super initialize.
	headerComponent := HeaderComponent newConPadre: self
]
