with Arbre_Binaire;
with Liste;
with Individu;       use Individu;


package Arbre_Genealogique is

   -- Types instanciés à partir des packages
   type T_Liste_Individu is private;
   type T_Arbre_Genealogique is private;

   type T_Branche is (Pere, Mere, Inconnu);

------------------------------------------------------- SET ---------------------------------------------------

   -- Création de l'arbre généalogique avec un humain initial
   procedure Creer_Arbre (
      Arbre : in out T_Arbre_Genealogique;
      Humain : in T_Humain
   );

   -- Ajout d'un parent à un individu identifié
   procedure Add_Parent (
      Fils       : in out T_Arbre_Genealogique;
      Humain      : in T_Humain;
      Branche : in T_Branche
   );

   -- Suppression d'un individu et de son sous-arbre
   procedure Delete (
      Racine: in out T_Arbre_Genealogique;
      Parent       : in out T_Arbre_Genealogique
   );

   -- Ecrase les ancienne données d'un humain par d'autre pour un noeud donnée
   procedure Set_Humain_Noeud (
      Arbre : in out T_Arbre_Genealogique;
      Humain : T_Humain);

   ------------------------------------------------------- GET ---------------------------------------------------
   
   -- Renvoie un arbre genealogique vide (null)
   function Get_Arbre_Genealogique_Vide return T_Arbre_Genealogique;

   -- Calcul du nombre d'ancêtres d'un individu
   function Get_Nb_Ancetre (
      Arbre       : in T_Arbre_Genealogique
   ) return Natural;

   -- Récupération des individus d'une génération donnée
   procedure Get_Gen (
      Resultat : in out T_Liste_Individu;
      Arbre       : in T_Arbre_Genealogique;
      Equart_Gen   : in Integer
   ) ;

   -- Récupération des individus selon un nombre de parents connus
   function Get_Groupe (
      Arbre          : in T_Arbre_Genealogique;
      Nb_Parent_Connu  : in Natural
   ) return T_Liste_Individu;

   -- Récupération d'un noeud par identifiant
   function Get_Noeud (
      Arbre       : in T_Arbre_Genealogique;
      Identifiant : in T_Identifiant
   ) return T_Arbre_Genealogique;

   -- Récupération d'un des parent d'un noeud
   function Get_Parent (
      Arbre       : in T_Arbre_Genealogique;
      Parent : in T_Branche
   ) return T_Arbre_Genealogique;

   -- Récupération des caracteristiques humaines d'un noeud
   function Get_Humain_Noeud (
      Arbre       : in T_Arbre_Genealogique
   ) return T_Humain;

   -- Récupération de l'identifiant d'un noeud
   function Get_Identifiant_Noeud (
      Arbre       : in T_Arbre_Genealogique
   ) return T_Identifiant;

--------------------------------------------------- AUTRES -----------------------------------------------

   -- Verifie si l'arbre est vide (=null)
   function Est_Vide_Arbre_Genealogique (
      Arbre       : in T_Arbre_Genealogique
   ) return Boolean;

   -- Affichage de l'arbre généalogique
   procedure Print_Arbre(
      Arbre      : in T_Arbre_Genealogique;
      Parent : in T_Branche;
      Equart_Gen : in Natural
   );

   -- Affiche une liste d'individu
   procedure Print_Liste_Individu (Liste : in T_Liste_Individu);

   -- Verifie si un identifiant est present dans l'arbre
   function Est_Identifiant_Dans_Arbre (
      Arbre       : in T_Arbre_Genealogique;
      Identifiant : in T_Identifiant
   ) return Boolean;

--------------------------------------------------- PRIVATE -----------------------------------------------

   private

      package Arbre_Binaire_Individu is
         new Arbre_Binaire (T_Contenu => T_Individu);
      use Arbre_Binaire_Individu;

      package Liste_Individu is
         new Liste (T_Type => T_Individu, Capacite => 100);
      use Liste_Individu;

      type T_Arbre_Genealogique is new Arbre_Binaire_Individu.T_Arbre;
      type T_Liste_Individu is new Liste_Individu.T_Liste with null record;

   procedure Afficher_Noeud(
      N : Natural;
      Parent : T_Branche;
      Individu : T_Individu
   );

   procedure Set_Parent (
      Arbre       : in out T_Arbre_Genealogique;
      Parent : in T_Branche;
      Valeur       : in out T_Arbre_Genealogique
   );

   procedure Remove_Parent (
      Arbre       : in out T_Arbre_Genealogique;
      Parent : in T_Branche
   );

   function Get_Nb_Parent (
      Arbre       : in T_Arbre_Genealogique
   ) return Natural;


end Arbre_Genealogique;