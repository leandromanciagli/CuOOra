"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCuOOraWeb,
	#superclass : #PackageManifest,
	#category : #'CuOOraWeb-Manifest'
}

{ #category : #'code-critics' }
ManifestCuOOraWeb class >> ruleRBStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#UsuarioDetalleComponent #renderContentOn: #false)) #'2020-04-11T22:46:03.724349-03:00') )
]
