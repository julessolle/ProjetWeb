<?php

// Si la page est appelée directement par son adresse, on redirige en passant pas la page index
if (basename($_SERVER["PHP_SELF"]) != "index.php")
{
    header("Location:../index.php?view=echanges");
    die("");


}

include_once("libs/modele.php");
include_once("libs/maLibUtils.php"); // tprint
include_once("libs/maLibForms.php");

?>

<h1>Liste des échanges de la base </h1>




<?php //Utilisation du code équivalent du tp tiny mvc

echo "liste des 10 derniers échanges de la base :"; //Q2 à Q4
$echanges = listerEchanges("tout",$_SESSION['idUser']);
tprint($echanges);


echo "<hr />"; //Q1 et Q1bis
$login = $_SESSION['pseudo'];
echo "liste des 10 derniers échanges avec $login comme consommateur :";
$echanges = listerEchanges("consommateur",$_SESSION['idUser']);
tprint($echanges);

echo "<hr />";
$login = $_SESSION['pseudo'];
echo "liste des 10 derniers échanges avec $login comme fournisseur :";
$echanges = listerEchanges("fournisseur",$_SESSION['idUser']);
tprint($echanges);

echo "liste des 10 derniers échanges de la base :"; //Q2 à Q4
$echanges = listerEchanges("tout",$_SESSION['idUser']);
mkTable($echanges);


echo "<hr />";
$login = $_SESSION['pseudo'];
echo "liste des 10 derniers échanges avec $login comme consommateur :";
$echanges = listerEchanges("consommateur",$_SESSION['idUser']);
mkTable($echanges);

echo "<hr />";
$login = $_SESSION['pseudo'];
echo "liste des 10 derniers échanges avec $login comme fournisseur :";
$echanges = listerEchanges("fournisseur",$_SESSION['idUser']);
mkTable($echanges);

?>
<!-- La suite du code a été développer à l'aide du tp TINY MVC pour la partie de code équivalente -->
<hr />

<h2>Création d'échanges</h2>

<form action="controleur.php">

    <select name="idEchange">
        <?php
        $talents = listerTalents();

        // préférer un appel à mkSelect("idUser",$users, ...)

        foreach ($talents as $dataTalent)
        {
            echo "<option value=\"$dataTalent[id]\">\n";

            echo  $dataTalent["NOM_COMPETENCE"]."(" .$dataTalent["NOM_FOURNISSEUR"] .")"  ;
            echo "\n</option>\n";
        }
        ?>
    </select>

    <input type="submit" name="action" value="Demander" />
</form>
