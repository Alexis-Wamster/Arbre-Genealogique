with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;       use Ada.Strings.Unbounded;
with Arbre_Genealogique;    use Arbre_Genealogique;
with Individu;              use Individu;

package Commandes_Main is

    -- @brief Affiche les différentes actions disponibles
    procedure Afficher_Actions;

    -- @brief Convertit une chaîne en un nombre naturel
    -- @param Texte La chaîne à convertir
    -- @param Valeur_Erreur La valeur à retourner en cas d'erreur
    -- @return La valeur convertie ou Valeur_Erreur en cas d'échec
    function String_To_Natural(Texte : in String; Valeur_Erreur : Natural) return Natural;

    -- @brief Remplit les informations d'un individu via saisie utilisateur
    -- @param Humain L'individu à modifier
    procedure Demmander_Personne(Humain : in out T_Humain);

    -- @brief Demande un identifiant à l'utilisateur et retourne le nœud correspondant
    -- @param Arbre L'arbre généalogique
    -- @param Identifiant L'identifiant récupéré
    -- @return Le nœud correspondant ou un nœud vide si invalide
    function Demmander_Identifiant(Arbre : in T_Arbre_Genealogique; Identifiant : out T_Identifiant) return T_Arbre_Genealogique;

    -- @brief Supprime une personne et ses ancêtres
    -- @param Racine L'arbre généalogique
    -- @param Noeud Le nœud à supprimer
    procedure Supprimer(Racine : in out T_Arbre_Genealogique; Noeud : in out T_Arbre_Genealogique);

    -- @brief Modifie une personne de l'arbre
    -- @param Arbre L'arbre contenant la personne
    procedure Modifier(Arbre : in out T_Arbre_Genealogique);

    -- @brief Affiche l'arbre généalogique
    -- @param Arbre L'arbre à afficher
    procedure Afficher(Arbre : in T_Arbre_Genealogique);

    -- @brief Ajoute un individu à l'arbre
    -- @param Racine L'arbre où ajouter l'individu
    procedure Ajouter(Racine : in out T_Arbre_Genealogique);

    -- @brief Affiche le nombre d'ancêtres connus d'un individu
    -- @param Arbre L'arbre généalogique
    procedure Nb_Ancetres_Connu(Arbre : in T_Arbre_Genealogique);

    -- @brief Affiche les ancêtres ayant un certain nombre de parents connus
    -- @param Arbre L'arbre généalogique
    procedure Ancetres_Parents_Connu(Arbre : in T_Arbre_Genealogique);

    -- @brief Affiche les ancêtres situés à une certaine génération d'un individu
    -- @param Arbre L'arbre généalogique
    procedure Ancetres_Separes_Generation(Arbre : in T_Arbre_Genealogique);

    -- @brief Lit et exécute l'action saisie par l'utilisateur
    -- @param Arbre L'arbre généalogique
    -- @return Vrai si le programme doit continuer, Faux pour quitter
    function Lire_Action(Arbre : in out T_Arbre_Genealogique) return Boolean;

end Commandes_Main;