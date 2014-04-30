<?php

class InscriptionController extends Zend_Controller_Action {

    protected $_modelLan;
    protected $_modelCharte;
    protected $_modelCompte;
    protected $_modelLanJoueur;
    protected $_modelFonctionCompte;
    protected $_modelLanJeux;
    protected $_modelLanJeuxJoueurTeam;
    protected $_modelTeam;
    protected $_modelNewslettermail;
    protected $_modelNewslettermailtype;

    public function __call($method, $args) {
        if ('Action' == substr($method, -6)) {
            return $this->_helper->redirector('index');
        }

        throw new Exception('Invalid method');
    }

    public function indexAction() {
        $log = new SessionLAG();
        if ($log->_getTypeConnected('joueur')) {
            $smarty = Zend_Registry::get('view');

            $modelLan = $this->_getModelLan();
            $modelLanJoueur = $this->_getModelLanJoueur();
            $request = $this->getRequest();
            $deja_inscrit = false;
            $lan = $modelLan->fetchEntryOuverte();

            if ($log->_getTypeConnected('joueur')) {
                $lans = $modelLanJoueur->fetchEntriesByJoueur($log->_getUser());

                foreach ($lans as $l) {
                    if ($l['idLan'] == $lan['idLan'])
                        $deja_inscrit = true;
                }
            }
            if ($lan == -1) {
                $smarty->assign('titre', 'Aucune Inscription n\'est actuellement ouverte');
                $smarty->assign('ouverte', false);
            } elseif ($deja_inscrit) {
                $smarty->assign('titre', 'Vous &ecirc;tes d&eacute;j&agrave; inscrit pour cette lan');
                $smarty->assign('ouverte', false);
            } else {
                $modelCharte = $this->_getModelCharte();

                $charte = $modelCharte->fetchEntryAsso();
                $articles = $modelCharte->fetchArticlesAsso();
                $smarty->assign('ouverte', true);
                $smarty->assign('articles', $articles);
                $smarty->assign('url_valide', $request->getBaseUrl() . '/inscription/inscription');
                $smarty->assign('url_nonvalide', $request->getBaseUrl());

                $smarty->assign('titre', 'Inscription pour la lan ' . $lan['nom']);
            }
            $smarty->display('inscription/index.tpl');
        } else {
            if (!$log->_getTypeConnected('admin') && !$log->_getTypeConnected('superadmin'))
                return $this->_redirect('/inscription/inscriptionmembre');
            else
                return $this->_redirect('/accueil/index');
        }
    }

    public function inscriptionAction() {
        $log = new SessionLAG();
        if ($log->_getTypeConnected('joueur')) {
            return $this->_helper->redirector('inscriptionlan', 'inscription');
        } else {
            $smarty = Zend_Registry::get('view');
            $request = $this->getRequest();
            $smarty->assign('title', 'Connexion');
            $defaultNamespace = new Zend_Session_Namespace();

            if (Zend_Session::sessionExists() && empty($defaultNamespace->userid)) {
                $form = $this->_getLogForm();
                $model = $this->_getModelCompte();
                $modelFonctionCompte = $this->_getModelFonctionCompte();

                if ($this->getRequest()->isPost()) {
                    if ($form->isValid($request->getPost())) {
                        $dataform = $form->getValues();
                        $dataform['password'] = sha1('l@g8?' . $dataform['password'] . 'pe6r!e8');
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
                            return $this->_redirect('/inscription/inscriptionlan');
                        } else {
                            $form = "Erreur de connexion : votre login ou mot de passe n'est pas valide. Votre compte n'est peut �tre pas encore activ� par un administrateur.";
                        }
                    }
                }
                $smarty->assign('creer_compte', $request->getBaseUrl() . '/inscription/inscriptionmembre');
                $smarty->assign('form', $form);
                $smarty->display('inscription/inscription.tpl');
            }
        }
    }

    protected function connexion($userid, $type) {
        $defaultNamespace = new Zend_Session_Namespace();
        $defaultNamespace->userid = $userid;
        $defaultNamespace->type = $type;
    }

    public function validationAction() {
        $smarty = Zend_Registry::get('view');
        $request = $this->getRequest();

        $smarty->assign('valid', 0);
        $smarty->assign('base_url', $request->getBaseUrl());
        $smarty->display('inscription/validation.tpl');
    }

    public function validationmembreAction() {
        $smarty = Zend_Registry::get('view');
        $request = $this->getRequest();

        $key = $request->getParam('key', "");
        if ($key != "") {
            $modelCompte = $this->_getModelCompte();

            $compte = $modelCompte->fetchEntryByKeyAndMail($key);
            $compte['actif'] = 1;

            $modelCompte->save($compte['idCompte'], $compte);
            $smarty->assign('valid', 1);
            $smarty->assign('base_url', $request->getBaseUrl());

            $smarty->display('inscription/validation.tpl');
        } else {
            echo "non";
        }
    }

    public function paiementAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('joueur') || $log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $modelLan = $this->_getModelLan();
            $modelCompte = $this->_getModelCompte();
            $id = $log->_getUser();
            $compte = $modelCompte->fetchEntry($id);
            $lan = $modelLan->fetchEntryOuverte();
            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('compte', $compte);
            $smarty->assign('lan', $lan);
            $smarty->display('inscription/paiement.tpl');
        }
    }

    public function paiementselecAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('joueur')) {

            $request = $this->getRequest();
            $modelLan = $this->_getModelLan();
            $modelLanJoueur = $this->_getModelLanJoueur();
            $idpaiement = $request->getParam('idp', 0);

            $id = $log->_getUser();
            $lan = $modelLan->fetchEntryOuverte();
            $lanJoueur = $modelLanJoueur->fetchEntriesByLanAndJoueur($lan['idLan'], $id);
            $lanJoueur['modepaiement'] = $idpaiement;
            $modelLanJoueur->save($lanJoueur['idLanJoueur'], $lanJoueur);

            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('idp', $idpaiement);
            $smarty->assign('lan', $lan);
            $smarty->display('inscription/paiementselec.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function inscriptionmembreAction() {
        $smarty = Zend_Registry::get('view');
        $modelLan = $this->_getModelLan();
        $request = $this->getRequest();
        $lan = $modelLan->fetchEntryOuverte();
        $modelCompte = $this->_getModelCompte();
        $login = $modelCompte->fetchEntryByLogin('toti');
        $form = $this->_getCompteForm();
        $smarty->assign('test', $login);
        $login_existant = 0;

        if ($this->getRequest()->isPost()) {
            if ($form->isValid($request->getPost())) {
                $modelCompte = $this->_getModelCompte();
                $modelLanJoueur = $this->_getModelLanJoueur();
                $modelNewsletterMail = $this->_getModelNewsletterMail();
                $modelNewsletterMailType = $this->_getModelNewsletterMailType();
                $dataform = $form->getValues();
                $login = $modelCompte->fetchEntryByLogin($dataform['login']);
                if ($login == -1) {
                    $datenaissance = $dataform['datenaissance'];
                    $dataform['datenaissance'] = substr($datenaissance, 6, 4) . "-" . substr($datenaissance, 3, 2) . "-" . substr($datenaissance, 0, 2) . " 00:00:00";
                    $passwordsave = $dataform['password'];
                    $dataform['password'] = sha1('l@g8?' . $dataform['password'] . 'pe6r!e8');
                    $dataform['keyvalidation'] = sha1(time() + rand());

                    if (empty($dataform['img']))
                        unset($dataform['img']);
                    else {
                        $nom_image = $dataform["login"];
                        require_once '../library/My/Utils.php';
                        $chaine_valide = valideChaine($nom_image);
                        $ext = explode('.', $dataform["img"]);
                        $ancien_nom = $dataform['img'];
                        $dataform['img'] = $chaine_valide . '.' . $ext[1];
                    }

                    $dataform['nom'] = utf8_decode($dataform['nom']);
                    $dataform['prenom'] = utf8_decode($dataform['prenom']);
                    $dataform['jeuxprefere'] = utf8_decode($dataform['jeuxprefere']);
                    $dataform['configpc'] = utf8_decode($dataform['configpc']);
                    $dataform['citationpreferee'] = utf8_decode($dataform['citationpreferee']);
                    $dataform['description'] = utf8_decode($dataform['description']);
                    $dataform['ville'] = utf8_decode($dataform['ville']);
                    $dataform['login'] = utf8_decode($dataform['login']);
                    $dataform['email'] = utf8_decode($dataform['email']);

                    $new_id = $modelCompte->save(0, $dataform);

                    // Ajout du mail dans la table Newsletter si il n'est pas d�j� pr�sent dedans
                    $record = $modelNewsletterMail->fetchEntryByMail($dataform['email']);
                    if ($record == -1) {
                        $id_mail = $modelNewsletterMail->save(0, array('mail' => $dataform['email']));
                        // li� automatiquement au groupe "Joueurs" des newsletters
                        $modelNewsletterMailType->save(0, array('idNewsletterType' => 2, 'idNewsletterMail' => $id_mail));
                    }

                    // resize picture si image dans formulaire
                    if (!empty($dataform['img'])) {
                        require_once '../library/My/PhpThumb/ThumbLib.inc.php';
                        $thumb = PhpThumbFactory::create('../www/images/comptes/tmp/' . $ancien_nom);
                        $thumb->resize(100, 100)->save('../www/images/comptes/' . $dataform["img"]);
                        $thumb->resize(25, 25)->save('../www/images/comptes/thumb/' . $dataform["img"]);
                        if (file_exists('../www/images/comptes/tmp/' . $ancien_nom))
                            unlink('../www/images/comptes/tmp/' . $ancien_nom);
                    }

                    $compte = $modelCompte->fetchEntryByLogin($dataform['login']);

                    $modelFonctionCompte = $this->_getModelFonctionCompte();
                    $f['idCompte'] = $compte['idCompte'];
                    $f['idFonction'] = 3;
                    $modelFonctionCompte->save(0, $f);

                    $dataform['passwordsave'] = $passwordsave;
                    $this->sendMailInscriptionMembre($dataform);

                    return $this->_redirect('/inscription/validation');


                    /* Code permettant l'inscription � une LAN
                      Ce morceau de code doit etre d�plac� � l'endroit voulu
                      $compte = $modelCompte->fetchEntryByLogin($dataform['login']);
                      $insc['idLan']=$lan['idLan'];
                      $insc['idCompte']=$compte['idCompte'];
                      $insc['paiement']=0;
                      $insc['validation']=false;

                      $modelLanJoueur->save(0,$insc);
                     */
                } else {
                    $login_existant = 1;
                }
            }
        }


        $smarty->assign('login_existant', $login_existant);
        $smarty->assign('titre', 'Inscription sur le site de la LAG');
        $smarty->assign('form', $form);
        $smarty->display('inscription/inscriptionMembre.tpl');
    }

    public function inscriptionlanAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('joueur')) {
            $smarty = Zend_Registry::get('view');
            $request = $this->getRequest();
            $modelLan = $this->_getModelLan();
            $modelCompte = $this->_getModelCompte();
            $modelLanJeux = $this->_getModelLanJeux();
            $modelLanJoueur = $this->_getModelLanJoueur();
            $modelLanJeuxJoueurTeam = $this->_getModelLanJeuxJoueurTeam();
            $modelTeam = $this->_getModelTeam();
            $id = $log->_getUser();
            $lan = $modelLan->fetchEntryOuverte();
            $joueur = $modelCompte->fetchEntry($id);
            $jeux = $modelLanJeux->fetchEntriesByLan($lan['idLan']);
            $teams = $modelLanJeuxJoueurTeam->fetchTeam($lan['idLan']);

            foreach ($jeux as $j) {
                if ($j['tournoi'])
                    $tournoi = true;
                else
                    $tournoi = false;
            }

            $form = $this->_getInscriptionLanForm();

            $form->RemplirJeux($jeux);
            $form->RemplirTeam($teams);

            if ($this->getRequest()->isPost()) {
                if ($form->isValid($request->getPost())) {
                    $dataform = $form->getValues();
                    // Sauvegarde Team si n'existe pas
                    if ($dataform['team'] == '0') {
                        $t['nom'] = utf8_decode($dataform['newteam']);
                        $ljjt['idTeam'] = $modelTeam->save(0, $t);
                    } else {
                        $ljjt['idTeam'] = $dataform['team'];
                    }

                    // Sauvegarde joueur pour la lan ouverte
                    $insc['idLan'] = $lan['idLan'];
                    $insc['idCompte'] = $joueur['idCompte'];
                    $insc['paiement'] = 0;
                    $insc['validation'] = false;
                    $ljjt['idLanJoueur'] = $modelLanJoueur->save(0, $insc);

                    // Sauvegarde les jeux choisis pour cette lan
                    foreach ($dataform['jeux'] as $j) {
                        $ljjt['idJeux'] = $j;
                        $modelLanJeuxJoueurTeam->save(0, $ljjt);
                    }

                    if ($lan['prepaiement'] == 1)
                        return $this->_helper->redirector('paiement', 'inscription');
                    else
                        return $this->_helper->redirector('index', 'accueil');
                }
            }


            $smarty->assign('form', $form);

            $smarty->assign('lan', $lan);
            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('teams', $teams);
            $smarty->assign('jeux', $jeux);
            $smarty->assign('tournoi', $tournoi);
            $smarty->assign('joueur', $joueur);
            $smarty->display('inscription/inscriptionlan.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function ajoutjeuAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('joueur')) {

            $request = $this->getRequest();
            $modelLan = $this->_getModelLan();
            $modelLanJoueur = $this->_getModelLanJoueur();
            $modelLanJeuxJoueurTeam = $this->_getModelLanJeuxJoueurTeam();

            $id = $log->_getUser();
            $lan = $modelLan->fetchEntryOuverte();
            $lanjoueur = $modelLanJoueur->fetchEntriesByLanAndJoueur($lan['idLan'], $id);

            $jeux = $modelLanJeuxJoueurTeam->fetchEntriesJeuxNonRattaches($lanjoueur['idLanJoueur']);

            $team = $modelLanJeuxJoueurTeam->fetchEntriesByLanJoueur($lanjoueur['idLanJoueur']);
            $smarty->assign('test', $team);

            $form = $this->_getModificationInscriptionLanForm();

            $jeux_libres = $modelLanJeuxJoueurTeam->fetchEntriesJeuxLibresByLanJoueur($lan['idLan'], $log->_getUser());
            if (sizeof($jeux_libres) > 0)
                $form->RemplirJeux($jeux, true);
            else
                $form->RemplirJeux($jeux, false);


            if ($this->getRequest()->isPost()) {
                if ($form->isValid($request->getPost())) {
                    $dataform = $form->getValues();

                    $team = $modelLanJeuxJoueurTeam->fetchEntriesByLanJoueur($lanjoueur['idLanJoueur']);

                    $ljjt['idLanJoueur'] = $lanjoueur['idLanJoueur'];
                    $ljjt['idTeam'] = $team[0]['idTeam'];

                    // Sauvegarde les jeux choisis pour cette lan
                    foreach ($dataform['jeux'] as $j) {
                        $ljjt['idJeux'] = $j;
                        $modelLanJeuxJoueurTeam->save(0, $ljjt);
                    }

                    return $this->_helper->redirector('indexjoueur', 'lan', '', array('id' => $lan['idLan']));
                }
            }

            $smarty->assign('jeux', $jeux);
            $smarty->assign('form', $form);
            $smarty->assign('lan', $lan);


            $smarty->display('inscription/ajoutjeu.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    protected function sendMailInscriptionLan() {
        
    }

    protected function sendMailInscriptionMembre($membre) {
        $destinataire = $membre['email'];
        $subject = "Activation Compte Local Arena Games";
        $from = "From: Local Arena Games <contact@asso-lag.fr>\n";
        $from .= "MIME-version: 1.0\n";
        $from .= "Content-type: text/html; charset=iso-8859-1\n";
        $msg = "<html><head></head><body>
				<div style='font: normal 12px Arial;'>
				<b>Association - Local Arena Games</b><br />
				<b>Email :</b> contact@asso-lag.fr<br />
				<b>Site  :</b> <a href='http://www.asso-lag.fr' target='_blank'>www.asso-lag.fr</a><br /><br />

				Cher Gamer ou Gameuse,<br /><br />
				
				Vous venez de vous cr�er votre compte sur le site de l'assocation Local Arena Games.<br /> Il vous permettra de vous inscrire aux lans de l'association et de participer � la vie du site tel que le forum.<br /> Nous vous rappelons que vos informations resteront confidentielles.<br /><br />
				
				Pour <b>activer votre compte</b> cliquez sur le lien suivant : <br />
				<a href='http://www.asso-lag.fr/inscription/validationmembre/?key=" . $membre['keyvalidation'] . "'>ACTIVATION ICI</a>
				<br /><br />
				
				<b>Votre login :</b> " . $membre['login'] . "<br />
				<b>Votre mot de passe :</b> " . $membre['passwordsave'] . "<br /><br />
				
				Au plaisir de vous voir bient�t.<br /><br />
				
				L'�quipe Local Arena Games.<br /><br />
				
				<div style='font: normal 11px Arial;'>Petit rappel : <a href='http://www.asso-lag.fr' target='_blank'>www.asso-lag.fr</a></div>
				</body></html>";
        mail($destinataire, $subject, $msg, $from);
    }

    protected function _getModelCompte() {
        if (null === $this->_modelCompte) {
            require_once APPLICATION_PATH_COMMONS . '/models/Compte.php';
            $this->_modelCompte = new Model_Compte();
        }
        return $this->_modelCompte;
    }

    protected function _getModelLan() {
        if (null === $this->_modelLan) {
            require_once APPLICATION_PATH_COMMONS . '/models/Lan.php';
            $this->_modelLan = new Model_Lan();
        }
        return $this->_modelLan;
    }

    protected function _getModelTeam() {
        if (null === $this->_modelTeam) {
            require_once APPLICATION_PATH_COMMONS . '/models/Team.php';
            $this->_modelTeam = new Model_Team();
        }
        return $this->_modelTeam;
    }

    protected function _getModelLanJeuxJoueurTeam() {
        if (null === $this->_modelLanJeuxJoueurTeam) {
            require_once APPLICATION_PATH_COMMONS . '/models/LanJeuxJoueurTeam.php';
            $this->_modelLanJeuxJoueurTeam = new Model_LanJeuxJoueurTeam();
        }
        return $this->_modelLanJeuxJoueurTeam;
    }

    protected function _getModelLanJeux() {
        if (null === $this->_modelLanJeux) {
            require_once APPLICATION_PATH_COMMONS . '/models/LanJeux.php';
            $this->_modelLanJeux = new Model_LanJeux();
        }
        return $this->_modelLanJeux;
    }

    protected function _getModelCharte() {
        if (null === $this->_modelCharte) {
            require_once APPLICATION_PATH_COMMONS . '/models/Charte.php';
            $this->_modelCharte = new Model_Charte();
        }
        return $this->_modelCharte;
    }

    public function _getLogForm() {
        require_once APPLICATION_PATH_COMMONS . '/forms/Log.php';
        $form = new Form_Log();
        $form->setAction($this->_helper->url('inscription'));
        return $form;
    }

    protected function _getModelFonctionCompte() {
        if (null === $this->_modelFonctionCompte) {
            require_once APPLICATION_PATH_COMMONS . '/models/FonctionCompte.php';
            $this->_modelFonctionCompte = new Model_FonctionCompte();
        }
        return $this->_modelFonctionCompte;
    }

    protected function _getModelLanJoueur() {
        if (null === $this->_modelLanJoueur) {
            require_once APPLICATION_PATH_COMMONS . '/models/LanJoueur.php';
            $this->_modelLanJoueur = new Model_LanJoueur();
        }
        return $this->_modelLanJoueur;
    }

    protected function _getModelNewsletterMail() {
        if (null === $this->_modelNewslettermail) {
            require_once APPLICATION_PATH_COMMONS . '/models/NewsletterMail.php';
            $this->_modelNewslettermail = new Model_NewsletterMail();
        }
        return $this->_modelNewslettermail;
    }

    protected function _getModelNewsletterMailType() {
        if (null === $this->_modelNewslettermailtype) {
            require_once APPLICATION_PATH_COMMONS . '/models/NewsletterMailType.php';
            $this->_modelNewslettermailtype = new Model_NewsletterMailType();
        }
        return $this->_modelNewslettermailtype;
    }

    protected function _getCompteForm() {
        require_once APPLICATION_PATH_COMMONS . '/forms/Compte.php';
        Zend_Registry::set('modeform', 'inscription');
        $form = new Form_Compte();
        $form->setAction($this->_helper->url('inscriptionmembre'));
        return $form;
    }

    protected function _getInscriptionLanForm() {
        require_once APPLICATION_PATH_COMMONS . '/forms/InscriptionLan.php';
        $form = new Form_InscriptionLan();
        $form->setAction($this->_helper->url('inscriptionlan'));
        return $form;
    }

    protected function _getModificationInscriptionLanForm() {
        require_once APPLICATION_PATH_COMMONS . '/forms/ModificationInscriptionLan.php';
        $form = new Form_ModificationInscriptionLan();
        $form->setAction($this->_helper->url('ajoutjeu'));
        return $form;
    }

}
