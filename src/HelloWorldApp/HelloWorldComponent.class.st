Class {
	#name : #HelloWorldComponent,
	#superclass : #WAComponent,
	#instVars : [
		'number'
	],
	#category : #HelloWorldApp
}

{ #category : #callbacks }
HelloWorldComponent >> guessAgain [
	number := 100 atRandom
]

{ #category : #initialization }
HelloWorldComponent >> initialize [
	super initialize.
	number := 0
]

{ #category : #rendering }
HelloWorldComponent >> renderContentOn: aCanvas [
	aCanvas paragraph
		with: [ aCanvas text: 'El numero que estas pensando es..'.
			aCanvas space.
			aCanvas strong with: number printString ].
	aCanvas anchor
		callback: [ self guessAgain ];
		with: 'Probar de nuevo (Try again)'.
]
