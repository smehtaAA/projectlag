<?php
class My_CreationCompte extends Zend_Form
{
    /**
    * construction du formulaire
    *
    * @param  mixed $options
    * @return void
    */
    public function __construct($options = null)
    {
        parent::__construct($options);

        // traduction des messages d'erreur de validation
        $french = array(
	        'notAlnum' => "'%value%' ne contient pas que des lettres et/ou des chiffres.",
	        'notAlpha' => "'%value%' ne contient pas que des lettres.",
	        'notBetween' => "'%value%' n'est pas compris entre %min% et %max% inclus.",
	        'notBetweenStrict' => "'%value%' n'est pas compris entre %min% et %max% exclus.",
	        'dateNotYYYY-MM-DD'=> "'%value%' n'est pas une date au format AAAA-MM-JJ (exemple : 2000-12-31).",
	        'dateInvalid' => "'%value%' n'est pas une date valide.",
	        'dateFalseFormat' => "'%value%' n'est pas une date valide au format JJ/MM/AAAA (exemple : 31/12/2000).",
	        'notDigits' => "'%value%' ne contient pas que des chiffres.",
	        'emailAddressInvalid' => "'%value%' n'est pas une adresse mail valide selon le format adresse@domaine.",
	        'emailAddressInvalidHostname' => "'%hostname%' n'est pas un domaine valide pour l'adresse mail '%value%'.",
	        'emailAddressInvalidMxRecord' => "'%hostname%' n'accepte pas l'adresse mail '%value%'.",
	        'emailAddressDotAtom' => "'%localPart%' ne respecte pas le format dot-atom.",
	        'emailAddressQuotedString' => "'%localPart%' ne respecte pas le format quoted-string.",
	        'emailAddressInvalidLocalPart' => "'%localPart%' n'est pas une adresse individuelle valide.",
	        'notFloat' => "'%value%' n'est pas un nombre décimal.",
	        //'notGreaterThan' => "'%value%' n'est pas strictement supérieur à '%min%'.",
	        'notGreaterThan' => "Veuillez choisir une team.",
	        'notInt'=> "'%value%' n'est pas un nombre entier.",
	        'notLessThan' => "'%value%' n'est pas strictement inférieur à '%max%'.",
	        'isEmpty' => "Cette saisie est obligatoire.",
	        'stringEmpty' => "Ce champ est vide : vous devez le compléter.",
	        'regexNotMatch' => "'%value%' ne respecte pas le format '%pattern%'.",
	        'stringLengthTooShort' => "'%value%' fait moins de %min% caractères.",
	        'stringLengthTooLong' => "'%value%' fait plus de %max% caractères."
        );

        $translate = new Zend_Translate('array', $french, 'fr');
        $this->setTranslator($translate);
    }
}