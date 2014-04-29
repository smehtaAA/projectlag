<?php

class Admin_LogController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelFonctionCompte;

    protected function connexion($userid, $type) {
        $defaultNamespace = new Zend_Session_Namespace();
        $defaultNamespace->userid = $userid;
        $defaultNamespace->type = $type;
        $defaultNamespace->interface_admin = false;
    }

    public function indexAction() {
        $smarty = Zend_Registry::get('view');
        $request = $this->getRequest();
        $smarty->assign('title', 'Connexion');
        $defaultNamespace = new Zend_Session_Namespace();

        if (Zend_Session::sessionExists() && empty($defaultNamespace->userid)) {
            $form = $this->_getLogForm();
            $model = $this->_getModel();
            $modelFonctionCompte = $this->_getModelFonctionCompte();

            if ($this->getRequest()->isPost()) {
                if ($form->isValid($request->getPost())) {
                    $dataform = $form->getValues();
                    $dataform['password'] = sha1('l@g8?' . $dataform['password'] . 'pe6r!e8');
                    $dataform['login'] = utf8_decode($dataform['login']);
                    $existlog = $model->existLog($dataform);
                    if ($existlog != NULL) {
                        $userid = 'idCompte';
                        $fonction = $modelFonctionCompte->fetchFonction($existlog[$userid]);
                        $min = 200;
                        foreach ($fonction as $f) {
                            if ($f['ordre'] < $min) {
                                $min = $f['ordre'];
                                $nom = $f['nom'];
                            }
                        }
                        $this->connexion($existlog[$userid], $nom);
                        return $this->_redirect($_SERVER['HTTP_REFERER']);
                    } else {
                        $message = "Erreur de connexion : votre login ou mot de passe n'est pas valide. Vous n'avez peut &ecirc;tre pas encore activ&eacute; votre compte via le mail que vous avez re&ccedil;u lors de votre inscription.";
                        $smarty->assign('message', $message);
                        $smarty->display('error/errorconnexion.tpl');
                        return NULL;
                    }
                }
            }

            $smarty->assign('form', $form);
            $smarty->display('log/form.tpl');
        } else {
            $smarty->assign('message', 'Vous &ecirc;tes d&eacute;j&agrave; connect&eacute;(e)');
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function deconnexionAction() {
        if (Zend_Session::sessionExists()) {
            $defaultNamespace = new Zend_Session_Namespace();
            $defaultNamespace->userid = '';
            $defaultNamespace->type = '';
            $defaultNamespace->interface_admin = '';
            Zend_Session::destroy();
            return $this->_redirect('/accueil/index');
        }
    }

    public function oublimdpAction() {
        $smarty = Zend_Registry::get('view');
        $request = $this->getRequest();
        $form = $this->_getOubliMdpForm();
        if ($this->getRequest()->isPost()) {
            if ($form->isValid($request->getPost())) {
                $dataform = $form->getValues();
                $model = $this->_getModel();
                $compte = $model->fetchEntryByMail($dataform['email']);

                $compte['password'] = sha1('l@g8?' . $this->envoiMail($dataform['email']) . 'pe6r!e8');

                $model->save($compte['idCompte'], $compte);

                return $this->_redirect('/accueil/index');
            }
        }

        $smarty->assign('form', $form);

        $smarty->display('log/oublimdp.tpl');
    }

    public function envoiMail($email) {
        $pass = "";

        $alpha = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9');



        for ($i = 0; $i < 8; $i++) {
            $pass .= $alpha[rand(0, 61)];
        }



        $destinataire = $email;
        $subject = "Perte du mot de passe Compte Local Arena Games";
        $from = "From: Local Arena Games <contact@asso-lag.fr>\n";
        $from .= "MIME-version: 1.0\n";
        $from .= "Content-type: text/html; charset=iso-8859-1\n";
        $msg = "<html><head></head><body>
				<div style='font: normal 12px Arial;'>
				<b>Association - Local Arena Games</b><br />
				<b>Email :</b> contact@asso-lag.fr<br />
				<b>Site  :</b> <a href='http://www.asso-lag.fr' target='_blank'>www.asso-lag.fr</a><br /><br />

				Cher Gamer ou Gameuse,<br /><br />

				Vous venez de vous demander une r&eacute;initialisation du mot de passe de votre compte sur le site de l'assocation Local Arena Games.<br /> Ce mot de passe vous permet de vous inscrire aux lans de l'association et de participer &agrave; la vie du site tel que le forum.<br /> Nous vous rappelons que vos informations resteront confidentielles.<br /><br />

				Votre nouveau mot de passe est : " . $pass . " <br/>

                                Vous avez la possibilité de le modifier &agrave; partir de votre profil sur notre site. <br/>

				Au plaisir de vous voir bient�t.<br /><br />

				L'�quipe Local Arena Games.<br /><br />

				<div style='font: normal 11px Arial;'>Petit rappel : <a href='http://www.asso-lag.fr' target='_blank'>www.asso-lag.fr</a></div>
				</body></html>";
        mail($destinataire, $subject, $msg, $from);



        return $pass;
    }

    protected function _getModel() {
        require_once APPLICATION_PATH_COMMONS . '/models/Compte.php';
        $this->_model = new Model_Compte();

        return $this->_model;
    }

    protected function _getModelFonctionCompte() {
        require_once APPLICATION_PATH_COMMONS . '/models/FonctionCompte.php';
        $this->_modelFonctionCompte = new Model_FonctionCompte();

        return $this->_modelFonctionCompte;
    }

    public function _getLogForm() {
        require_once APPLICATION_PATH_COMMONS . '/forms/Log.php';
        $form = new Form_Log();
        $form->setAction($this->_helper->url('index'));
        return $form;
    }

    public function _getOubliMdpForm() {
        require_once APPLICATION_PATH_COMMONS . '/forms/Oublimdp.php';
        $form = new Form_OubliMdp();
        $form->setAction($this->_helper->url('oublimdp'));
        return $form;
    }

    public function _getTypeConnected($type) {
        $isconnected = false;
        $defaultNamespace = new Zend_Session_Namespace();
        if (Zend_Session::sessionExists() && $defaultNamespace->type == $type) {
            $isconnected = true;
        }
        return $isconnected;
    }

}
