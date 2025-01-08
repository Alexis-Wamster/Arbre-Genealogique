with Arbre_Binaire;
with Individu;

package Arbre_Genealogique is

    -- Déclaration de T_Liste pour représenter une liste d'individus
   type T_Liste is array (Natural range <>) of Individu.T_Individu;

   -- Redéfinition de T_Arbre_Genealogique comme un arbre binaire de T_Individu
   type T_Arbre_Genealogique is new Arbre_Binaire.T_Arbre_Bin (Individu.T_Individu);

   -- Création de l'arbre généalogique avec un humain initial
   procedure CreerArbre (
      Arbre : in out T_Arbre_Genealogique;
      Humain : in Individu.T_Humain
   );
   -- Precondition : Arbre = null
   -- Postcondition : Arbre contient un noeud racine avec l'humain fourni

   -- Ajout du père d'un individu identifié
   procedure AddPere (
      Arbre       : in out T_Arbre_Genealogique;
      Identifiant : in Individu.T_Identifiant;
      Humain      : in Individu.T_Humain
   );
   -- Precondition : Identifiant existe dans l'arbre et le noeud père est vide
   -- Postcondition : Le père est ajouté comme sous-arbre gauche du noeud cible

   -- Ajout de la mère d'un individu identifié
   procedure AddMere (
      Arbre       : in out T_Arbre_Genealogique;
      Identifiant : in Individu.T_Identifiant;
      Humain      : in Individu.T_Humain
   );
   -- Precondition : Identifiant existe dans l'arbre et le noeud mère est vide
   -- Postcondition : La mère est ajoutée comme sous-arbre droit du noeud cible

   -- Affichage de l'arbre généalogique
   procedure PrintArbre (
      Arbre       : in T_Arbre_Genealogique;
      Identifiant : in Individu.T_Identifiant
   );
   -- Precondition : Identifiant existe dans l'arbre
   -- Postcondition : L'arbre est affiché à partir du noeud identifié

   -- Suppression d'un individu et de son sous-arbre
   procedure Delete (
      Arbre       : in out T_Arbre_Genealogique;
      Identifiant : in Individu.T_Identifiant
   );
   -- Precondition : Identifiant existe dans l'arbre
   -- Postcondition : Le noeud et son sous-arbre sont supprimés

   -- Calcul du nombre d'ancêtres d'un individu
   function GetNbAncetre (
      Arbre       : in T_Arbre_Genealogique;
      Identifiant : in Individu.T_Identifiant
   ) return Natural;
   -- Precondition : Identifiant existe dans l'arbre
   -- Postcondition : Retourne le nombre d'ancêtres connus de l'individu

   -- Récupération des individus d'une génération donnée
   function GetGen (
      Arbre       : in T_Arbre_Genealogique;
      Identifiant : in Individu.T_Identifiant;
      EquartGen   : in Integer
   ) return T_Liste;
   -- Precondition : Identifiant existe dans l'arbre et EquartGen >= 0
   -- Postcondition : Retourne une liste d'individus de la génération correspondante

   -- Récupération des individus selon un nombre de parents connus
   function GetGroupe (
      Arbre          : in T_Arbre_Genealogique;
      NbParentConnu  : in Natural
   ) return T_Liste;
   -- Precondition : Arbre non vide
   -- Postcondition : Retourne une liste d'individus avec exactement NbParentConnu parents connus

   -- Récupération d'un noeud par identifiant
   function GetNoeud (
      Arbre       : in T_Arbre_Genealogique;
      Identifiant : in Individu.T_Identifiant
   ) return Individu.T_Individu;
   -- Precondition : Identifiant existe dans l'arbre
   -- Postcondition : Retourne le noeud correspondant à l'identifiant

end Arbre_Genealogique;