<?php

/*
Dans ce fichier, on définit diverses fonctions permettant de récupérer des données utiles pour notre TP d'identification. Deux parties sont à compléter, en suivant les indications données dans le support de TP
*/

// inclure ici la librairie faciliant les requêtes SQL (en veillant à interdire les inclusions multiples)
include_once("maLibSQL.pdo.php");

function isAdmin($idUser)
{
	// vérifie si l'utilisateur est un administrateur
}
function verifUserBdd($login,$passe)
{
	// Vérifie l'identité d'un utilisateur 
	// dont les identifiants sont passes en paramètre
	// renvoie faux si user inconnu
	// renvoie l'id de l'utilisateur si succès
	$SQL = "SELECT ID_MEMBRE FROM MEMBRE WHERE LOGIN='$login' AND MDP='$passe'";
	//die($SQL);
	return SQLGetChamp($SQL);

	// On utilise SQLGetCHamp
	// si on avait besoin de plus d'un champ
	// on aurait du utiliser SQLSelect
}

function listerEchanges($mode="tout",$idUser) //Utilisation de la fonction équvalente du tp tiny MVC
{
	// Liste tous les échanges prévus à compter de la date courante
	// dans l'ordre anti-chrono
	// On se limite à 10 échanges maximum
	$SQL = "select DATE_DEMANDE,DATE_ECHANGE,CONSOMMATEUR,FOURNISSEUR,NOM_COMPETENCE,DESCRIPTION_COMPETENCE,ETAT_ECHANGE from V_ECHANGES ORDER BY DATE_ECHANGE DESC limit 10";
	if ($mode == "consommateur") $SQL = "select DATE_DEMANDE,DATE_ECHANGE,CONSOMMATEUR,FOURNISSEUR,NOM_COMPETENCE,DESCRIPTION_COMPETENCE,ETAT_ECHANGE from V_ECHANGES WHERE ID_CONSOMMATEUR=$idUser ORDER BY DATE_ECHANGE DESC limit 10";
	if ($mode == "fournisseur") $SQL = "select DATE_DEMANDE,DATE_ECHANGE,CONSOMMATEUR,FOURNISSEUR,NOM_COMPETENCE,DESCRIPTION_COMPETENCE,ETAT_ECHANGE from V_ECHANGES WHERE ID_FOURNISSEUR=$idUser ORDER BY DATE_ECHANGE DESC limit 10";
	return parcoursRs(SQLSelect($SQL));
	// mode = tout ==> tous les échanges en base
	// mode = fournisseur ==> Tous les échanges prévus pour lesquels l'utilisateur courant est fournisseur
	// mode = consommateur ==> tous les échnages prévus pour elsquels l'utilisateur courant est consommateur
	// Cette fonction peut exploiter la vue mise à disposition dans le modèle relationnel
	// fourni avec l'exercice V_ECHANGES
}
function listerCompetences()
{

}
function listerTalents()
{
	// Liste tous les talents mis à disposition dans le SEL
	// Cette fonction peut exploiter la vue mise à disposition dans le modèle relationnel
	// fourni avec l'exercice V_TALENTS
	$SQL = "select * from V_TALENTS";
	return parcoursRs(SQLSelect($SQL));
}
function creerEchange($laDateSouhaitee,$idTalent)
{
	//La variable DATE_DEMANDE n'a pas de valeur par défault
	//Le code SQL renvoie donc ERREUR si cette valeur n'est pas précisée
	//Il en va de même avec DATE_ECHANGE, ID_TALENT et CONSOMMATEUR

	// J'ai donc modifié les valeurs par défault de DATE_ECHANGE, ID_TALENT et CONSOMMATEUR pour éviter de créer des erreurs
	// J'ai mis leur valeur par défault à NULL
	$SQL ="INSERT INTO ECHANGE(`ID_TALENT`,`DATE_DEMANDE`) VALUES('$idTalent','$laDateSouhaitee')";
	return SQLInsert($SQL);
}
function accepterEchange()
{

}
function terminerEchange()
{

}
?>
