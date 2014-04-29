<?php

class LanController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelLanJeux;
    protected $_modelLanJoueur;
    protected $_modelLanJeuxJoueurTeam;
    protected $_modelCompte;
    protected $_modelConfig;

    public function indexAction() {
        $smarty = Zend_Registry::get('view');
        $model = $this->_getModel();
        $modelLanJeux = $this->_getModelLanJeux();
        $modelConfig = $this->_getModelConfig();
        $request = $this->getRequest();

        $mode = $request->getParam('m', '');

        $lan_ouverte_date = $model->fetchEntryOuverteDateField(array('idLan'));
        $lan_ouverte = $model->fetchEntryOuverteField(array('idLan'));
        $map = null;
        $map_google = 0;

        if ($lan_ouverte_date == -1 || $mode == "histo") {
            //pointe vers l'affichage de l'ensemble des lans
            $lans = $model->fetchEntriesorderByDateField(array('idLan', 'nom', 'datedeb', 'datefin', 'adresse', 'cp', 'ville', 'extra', 'description', 'prix', 'prix_prepaiement_paypal', 'prix_prepaiement', 'telethon'));

            foreach ($lans as $lan) {
                $chiffre[$lan['idLan']]['insc'] = $model->fetchEntriesCountValide($lan['idLan']);
                $chiffre[$lan['idLan']]['present'] = $model->fetchEntriesCountPresent($lan['idLan']);
                if ($lan['idLan'] == $lan_ouverte['idLan'])
                    $chiffre[$lan['idLan']]['pre_inscrit'] = $model->fetchEntriesCountPreInscrits($lan['idLan']);

                $jeux[$lan['idLan']] = $modelLanJeux->fetchEntriesByLanField($lan['idLan'], array(''), array(''), array('nom'));
            }




            $smarty->assign('lan_ouverte', $lan_ouverte);
            $smarty->assign('lans', $lans);
            $smarty->assign('chiffre', $chiffre);
            $smarty->assign('jeux', $jeux);
            $smarty->assign('titre', 'Lans');
            $smarty->assign('base_url', $request->getBaseUrl());

            $smarty->display('lan/index.tpl');
        } else {
            //poite vers la prochaine et unique lan

            $lan = $model->fetchEntry($lan_ouverte_date);

            $jeux[$lan['idLan']] = $modelLanJeux->fetchEntriesByLanField($lan['idLan'], array(''), array(''), array('nom'));

            $chiffre['insc'] = $model->fetchEntriesCountValide($lan['idLan']);
            $chiffre['present'] = $model->fetchEntriesCountPresent($lan['idLan']);
            if ($lan['idLan'] == $lan_ouverte['idLan'])
                $chiffre['pre_inscrit'] = $model->fetchEntriesCountPreInscrits($lan['idLan']);



            if ($lan['datedeb'] < date('YYYY-MM-DD')) {
                try {
                    $key_google = $modelConfig->fetchEntrySetting('key_google');
                    // API Google Map
                    require('../library/My/GoogleMapAPI.class.php');
                    $map = new GoogleMapAPI('map', 'driving_directions');
                    $map->setMapType('map');
                    $map->setAPIKey($key_google['valeur']);
                    // fixe les dimensions de la carte
                    $map->setHeight("350");
                    $map->setWidth("400");
                    // gestion des services
                    $map->DisableTypeControls();
                    $map->DisableDirections();
                    $map->disableZoomEncompass();
                    $map->disableOverviewControl();
                    $map->disableScaleControl();
                    $map->setControlSize('small');
                    $map->disableMapControls();
                    // definition du zoom
                    $map->setZoomLevel(8);
                    // ajout du marqueur lan sur la carte
                    $map->addMarkerByAddress($lan['adresse'] . '-' . $lan['ville'] . '-' . $lan['cp'], $lan['nom'], "<span class='rouge'><strong>$lan[nom]</strong></span><br/>$lan[adresse]<br/>$lan[ville] ($lan[cp])", $lan['nom']);
                    // utilisation d'un icone different pour la lan
                    $map->addMarkerIcon($request->getBaseUrl() . '/images/admin/computer_gmap.png', $request->getBaseUrl() . '/images/admin/computer_gmap.png', 0, 0, 10, 10);
                    $smarty->assign('map', $map);
                    $map_google = 1;
                } catch (Exception $e) {
                    $map_google = 2;
                    $map_error = "Probleme Map Google";
                    $smarty->assign('map_error', $map_error);
                }
            }



            $smarty->assign('lan_ouverte', $lan_ouverte);
            $smarty->assign('lan', $lan);
            $smarty->assign('chiffre', $chiffre);
            $smarty->assign('jeux', $jeux);
            $smarty->assign('map_google', $map_google);
            $smarty->assign('titre', 'Lans');
            $smarty->assign('base_url', $request->getBaseUrl());

            $smarty->display('lan/index_ouverte.tpl');
        }
    }

    public function indexjoueurAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('joueur')) {
            $request = $this->getRequest();
            $smarty->assign('baseurl', $request->getBaseUrl());
            $modelLanJoueur = $this->_getModelLanJoueur();
            $model = $this->_getModel();
            $id = $request->getParam('id', 0);

            if ($id == 0) {
                $lans = $modelLanJoueur->fetchEntriesByJoueur($log->_getUser());

                $smarty->assign('lans', $lans);
                $smarty->assign('title', 'Mes Lans');
                $smarty->display('lan/indexJoueur.tpl');
            } else {

                $modelLanJeux = $this->_getModelLanJeux();
                $modelLanJeuxJoueurTeam = $this->_getModelLanJeuxJoueurTeam();
                $modelCompte = $this->_getModelCompte();
                $modelConfig = $this->_getModelConfig();

                $lan = $model->fetchEntryField($id, array('idLan', 'nom', 'adresse', 'ville', 'cp', 'adresse'));
                $joueur = $modelCompte->fetchEntryField($log->_getUser(), array('ville', 'cp'));
                // recuperation des jeus o� le joueur s'est inscrit
                $jeux = $modelLanJeuxJoueurTeam->fetchEntriesJeuxByLan($id, $log->_getUser());
                $jeux_libres = $modelLanJeuxJoueurTeam->fetchEntriesJeuxLibresByLanJoueur($id, $log->_getUser());
                if (sizeof($jeux_libres) > 0)
                    $jeuxlibres = 1;
                else
                    $jeuxlibres = 0;


                //$key_google = $modelConfig->fetchEntrySetting('key_google');
                $key_google = 'ABQIAAAAZa-MrYLCTveVxtzzB_ndBhQWCLFO9fZBImejaIh1nL6hobfpIxT475dhQ9njIa4kZ3IA8dcMdQYcig';
                // API Google Map
                require('../library/My/GoogleMapAPI.class.php');
                $map = new GoogleMapAPI('map', 'driving_directions');
                $map->setMapType('map');
                $map->setAPIKey($key_google);
                // fixe les dimensions de la carte
                $map->setHeight("500");
                $map->setWidth("500");
                $map->setDirWidth("300");
                // gestion des services
                $map->disableTypeControls();
                $map->disableDirections();
                $map->disableZoomEncompass();
                $map->disableOverviewControl();
                // definition du zoom
                // $map->setZoomLevel(5);
                // gestion de l'itineraire
                $map->enableDrivingDirections();
                $map->setDrivingDirection(array($joueur['ville'] . ' ' . $joueur['cp'], $lan['adresse'] . ' ' . $lan['ville'] . ' ' . $lan['cp']));

                $smarty->assign('jeux_libres', $jeuxlibres);
                $smarty->assign('title', 'Lan ' . $lan['nom']);
                $smarty->assign('map', $map);
                $smarty->assign('lan', $lan);
                $smarty->assign('jeux', $jeux);
                $smarty->assign('urladdjeu', $request->getBaseUrl() . '/inscription/ajoutjeu');

                $smarty->display('lan/indexJoueurLan.tpl');
            }
        } else {
            $smarty->assign('message', 'Erreur Connexion');
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function viewinscritsAction() {
        $smarty = Zend_Registry::get('view');
        $request = $this->getRequest();
        $id = (int) $request->getParam('id', 0);
        if ($id > 0) {

            $model = $this->_getModel();
            $modelConfig = $this->_getModelConfig();
            $modelLanJoueur = $this->_getModelLanJoueur();
            $modelLanJeuxJoueurTeam = $this->_getModelLanJeuxJoueurTeam();

            $lan = $model->fetchEntryField($id, array('idLan', 'nom', 'adresse', 'ville', 'cp'));

            $key_google = $modelConfig->fetchEntrySetting('key_google');

            //$key_google = 'ABQIAAAAbaa4Yr0CaJRPmvTyPQokuxRDhYTaHn_Vp0BC9wWY8yz-he3QcRRezsmIaqc3J92gSQrbOfVH_NsVrA';
            // API Google Map
            require('../library/My/GoogleMapAPI.class.php');
            $map = new GoogleMapAPI('map');
            $map->setMapType('map');
            $map->setAPIKey($key_google['valeur']);
            // fixe les dimensions de la carte
            $map->setHeight("500");
            $map->setWidth("830");
            // gestion des services
            $map->disableTypeControls();
            $map->disableDirections();
            $map->enableZoomEncompass();
            $map->disableOverviewControl();
            // definition du zoom
            $map->setZoomLevel(8);

            if (true) {
                $villes = $modelLanJoueur->fetchEntriesVille($id);
                foreach ($villes as $v) {
                    $joueurs = $modelLanJoueur->fetchEntriesByLanVilleField($id, $v['ville'], array('idCompte', 'login', 'cp', 'ville', 'img'));

                    if (sizeof($joueurs) > 1) {
                        $logins = "";
                        foreach ($joueurs as $j) {
                            $logins .= $j['login'] . "<br/>";
                        }
                        // ajout d'un marqueur joueur sur la carte
                        $map->addMarkerByAddress($j['ville'] . ' ' . $j['cp'], "Joueurs", "<span class='rouge'><strong>$j[ville] ($j[cp])</strong></span><br/>$logins", "Joueurs de $j[ville]");
                        // met cet icone pour le dernier marqueur pos�
                        $map->addMarkerIcon($request->getBaseUrl() . '/images/comptes/thumb/no_logo.png', $request->getBaseUrl() . '/images/comptes/thumb/no_logo.png', 0, 0, 10, 10);
                    } else {
                        // ajout d'un marqueur joueur sur la carte
                        $map->addMarkerByAddress($joueurs[0]['ville'] . ' ' . $joueurs[0]['cp'], $joueurs[0]['login'], "<span class='rouge'><strong>" . $joueurs[0]['login'] . "</strong></span><br/>" . $joueurs[0]['ville'] . " (" . $joueurs[0]['cp'] . ")", $joueurs[0]['login']);
                        // met cet icone pour le dernier marqueur pos�
                        $map->addMarkerIcon($request->getBaseUrl() . '/images/comptes/thumb/' . $joueurs[0]['img'], $request->getBaseUrl() . '/images/comptes/thumb/' . $joueurs[0]['img'], 0, 0, 10, 10);
                    }
                }
                // ajout du marqueur lan sur la carte
                $map->addMarkerByAddress($lan['adresse'] . ' ' . $lan['ville'] . ' ' . $lan['cp'], $lan['nom'], "<span class='rouge'><strong>$lan[nom]</strong></span><br/>$lan[adresse]<br/>$lan[ville] ($lan[cp])", $lan['nom']);
                // utilisation d'un icone different pour la lan
                $map->addMarkerIcon($request->getBaseUrl() . '/images/admin/computer_gmap.png', $request->getBaseUrl() . '/images/admin/computer_gmap.png', 0, 0, 10, 10);
            }
            $joueurs = $modelLanJoueur->fetchEntriesByLanField($id, array('idCompte', 'login', 'cp', 'ville', 'img', 'prenom', 'datenaissance'));


            $date = new Zend_Date();

            $smarty->assign('datedujour', $date->toString('YYYY-M-dd'));
            $smarty->assign('lan', $lan);
            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('joueurs', $joueurs);
            $smarty->assign('map', $map);
            $smarty->assign('title', 'Inscrits de la lan ' . $lan['nom']);
            $smarty->display('lan/viewinscrits.tpl');
        } else {
            return $this->_helper->redirector('index');
        }
    }

    public function viewpresentsAction() {
        $smarty = Zend_Registry::get('view');
        $request = $this->getRequest();
        $id = (int) $request->getParam('id', 0);
        if ($id > 0) {

            $model = $this->_getModel();
            $modelConfig = $this->_getModelConfig();
            $modelLanJoueur = $this->_getModelLanJoueur();
            $modelLanJeuxJoueurTeam = $this->_getModelLanJeuxJoueurTeam();

            $lan = $model->fetchEntryField($id, array('idLan', 'nom', 'adresse', 'ville', 'cp'));

            $key_google = $modelConfig->fetchEntrySetting('key_google');

            //$key_google = 'ABQIAAAAbaa4Yr0CaJRPmvTyPQokuxRDhYTaHn_Vp0BC9wWY8yz-he3QcRRezsmIaqc3J92gSQrbOfVH_NsVrA';
            // API Google Map
            require('../library/My/GoogleMapAPI.class.php');
            $map = new GoogleMapAPI('map');
            $map->setMapType('map');
            $map->setAPIKey($key_google['valeur']);
            // fixe les dimensions de la carte
            $map->setHeight("500");
            $map->setWidth("830");
            // gestion des services
            $map->disableTypeControls();
            $map->disableDirections();
            $map->enableZoomEncompass();
            $map->disableOverviewControl();
            // definition du zoom
            $map->setZoomLevel(8);

            if (true) {
                $villes = $modelLanJoueur->fetchEntriesVillePresents($id);
                foreach ($villes as $v) {
                    $joueurs = $modelLanJoueur->fetchEntriesByLanVillePresentsField($id, $v['ville'], array('idCompte', 'login', 'cp', 'ville', 'img'));

                    if (sizeof($joueurs) > 1) {
                        $logins = "";
                        foreach ($joueurs as $j) {
                            $logins .= $j['login'] . "<br/>";
                        }
                        // ajout d'un marqueur joueur sur la carte
                        $map->addMarkerByAddress($j['ville'] . ' ' . $j['cp'], "Joueurs", "<span class='rouge'><strong>$j[ville] ($j[cp])</strong></span><br/>$logins", "Joueurs de $j[ville]");
                        // met cet icone pour le dernier marqueur pos�
                        $map->addMarkerIcon($request->getBaseUrl() . '/images/comptes/thumb/no_logo.png', $request->getBaseUrl() . '/images/comptes/thumb/no_logo.png', 0, 0, 10, 10);
                    } else {
                        // ajout d'un marqueur joueur sur la carte
                        $map->addMarkerByAddress($joueurs[0]['ville'] . ' ' . $joueurs[0]['cp'], $joueurs[0]['login'], "<span class='rouge'><strong>" . $joueurs[0]['login'] . "</strong></span><br/>" . $joueurs[0]['ville'] . " (" . $joueurs[0]['cp'] . ")", $joueurs[0]['login']);
                        // met cet icone pour le dernier marqueur pos�
                        $map->addMarkerIcon($request->getBaseUrl() . '/images/comptes/thumb/' . $joueurs[0]['img'], $request->getBaseUrl() . '/images/comptes/thumb/' . $joueurs[0]['img'], 0, 0, 10, 10);
                    }
                }


                // ajout du marqueur lan sur la carte
                $map->addMarkerByAddress($lan['adresse'] . ' ' . $lan['ville'] . ' ' . $lan['cp'], $lan['nom'], "<span class='rouge'><strong>$lan[nom]</strong></span><br/>$lan[adresse]<br/>$lan[ville] ($lan[cp])", $lan['nom']);
                // utilisation d'un icone different pour la lan
                $map->addMarkerIcon($request->getBaseUrl() . '/images/admin/computer_gmap.png', $request->getBaseUrl() . '/images/admin/computer_gmap.png', 0, 0, 10, 10);
            }


            $joueurs = $modelLanJoueur->fetchEntriesByLanPresentField($id, array('idCompte', 'login', 'cp', 'ville', 'img', 'prenom', 'datenaissance'));



            $date = new Zend_Date();

            $smarty->assign('datedujour', $date->toString('YYYY-M-dd'));
            $smarty->assign('lan', $lan);
            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('joueurs', $joueurs);
            $smarty->assign('map', $map);
            $smarty->assign('title', 'Pr&eacute;sents de la lan ' . $lan['nom']);
            $smarty->display('lan/viewinscrits.tpl');
        } else {
            return $this->_helper->redirector('index');
        }
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Lan.php';
            $this->_model = new Model_Lan();
        }
        return $this->_model;
    }

    protected function _getModelLanJoueur() {
        if (null === $this->_modelLanJoueur) {
            require_once APPLICATION_PATH_COMMONS . '/models/LanJoueur.php';
            $this->_modelLanJoueur = new Model_LanJoueur();
        }
        return $this->_modelLanJoueur;
    }

    protected function _getModelLanJeux() {
        if (null === $this->_modelLanJeux) {
            require_once APPLICATION_PATH_COMMONS . '/models/LanJeux.php';
            $this->_modelLanJeux = new Model_LanJeux();
        }
        return $this->_modelLanJeux;
    }

    protected function _getModelCompte() {
        if (null === $this->_modelCompte) {
            require_once APPLICATION_PATH_COMMONS . '/models/Compte.php';
            $this->_modelCompte = new Model_Compte();
        }
        return $this->_modelCompte;
    }

    protected function _getModelConfig() {
        if (null === $this->_modelConfig) {
            require_once APPLICATION_PATH_COMMONS . '/models/Config.php';
            $this->_modelConfig = new Model_Config();
        }
        return $this->_modelConfig;
    }

    protected function _getModelLanJeuxJoueurTeam() {
        if (null === $this->_modelLanJeuxJoueurTeam) {
            require_once APPLICATION_PATH_COMMONS . '/models/LanJeuxJoueurTeam.php';
            $this->_modelLanJeuxJoueurTeam = new Model_LanJeuxJoueurTeam();
        }
        return $this->_modelLanJeuxJoueurTeam;
    }

}
