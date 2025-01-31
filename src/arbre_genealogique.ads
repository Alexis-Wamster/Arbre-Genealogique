with Arbre_Binaire;
with Liste;
with Individu;       use Individu;

package Arbre_Genealogique is

   -- Types instanciés à partir des packages
   type T_Liste_Individu is private;
   type T_Arbre_Genealogique is private;

   type T_Branche is (Pere, Mere, Inconnu);

--------------------------------------------------- AUTRES -----------------------------------------------

   --- @brief Vérifie si l'arbre est vide.
   --- @param Arbre L'arbre généalogique à tester.
   --- @return True si l'arbre est vide, False sinon.
   function Est_Vide_Arbre_Genealogique (
      Arbre       : in T_Arbre_Genealogique
   ) return Boolean;

   --- @brief Affiche l'arbre généalogique de manière récursive.
   --- @param Arbre L'arbre généalogique à afficher.
   --- @param Parent Indique si l'on affiche un père, une mère ou un inconnu.
   --- @param Equart_Gen Indique le décalage générationnel.
   procedure Print_Arbre(
      Arbre      : in T_Arbre_Genealogique;
      Parent : in T_Branche;
      Equart_Gen : in Natural
   );

   --- @brief Affiche une liste d'individus.
   --- @param Liste La liste d'individus à afficher.
   procedure Print_Liste_Individu (Liste : in T_Liste_Individu);

   --- @brief Vérifie si un identifiant est présent dans l'arbre généalogique.
   --- @param Arbre L'arbre dans lequel rechercher l'identifiant.
   --- @param Identifiant L'identifiant à rechercher.
   --- @return True si l'identifiant est présent, False sinon.
   function Est_Identifiant_Dans_Arbre (
      Arbre       : in T_Arbre_Genealogique;
      Identifiant : in T_Identifiant
   ) return Boolean;

------------------------------------------------------- GET ---------------------------------------------------

   --- @brief Renvoie un arbre généalogique vide.
   --- @return Un arbre vide.
   function Get_Arbre_Genealogique_Vide return T_Arbre_Genealogique;

   --- @brief Récupère le fils d'un noeud parent et indique si c'est un père ou une mère.
   --- @param Noeud_Racine L'arbre complet.
   --- @param Noeud_Parent Le noeud parent dont on cherche le fils.
   --- @param Noeud_Fils Retourne le fils trouvé.
   --- @return Indique si le parent est un père ou une mère.
   function Get_Fils(Noeud_Racine : in T_Arbre_Genealogique; Noeud_Parent: in T_Arbre_Genealogique; Noeud_Fils : out T_Arbre_Genealogique) return T_Branche with
   PRE => Est_Vide_Arbre_Genealogique(Noeud_Parent) = False,
   Post => Get_Fils'Result /= Inconnu AND Get_Identifiant_Noeud(Noeud_Fils) = Get_Identifiant_Noeud(Noeud_Parent)/2;

   --- @brief Calcule le nombre d'ancêtres d'un individu donné.
   --- @param Arbre L'arbre généalogique.
   --- @return Le nombre d'ancêtres trouvés.
   function Get_Nb_Ancetre (
      Arbre       : in T_Arbre_Genealogique
   ) return Natural;

   --- @brief Récupère les individus d'une génération donnée.
   --- @param Resultat Liste d'individus de la génération cible.
   --- @param Arbre Arbre généalogique où chercher.
   --- @param Equart_Gen Le nombre de générations de décalage.
   procedure Get_Gen (
      Resultat : in out T_Liste_Individu;
      Arbre       : in T_Arbre_Genealogique;
      Equart_Gen   : in Integer
   ) with
   PRE => Equart_Gen >= 0;


   -- Récupération des individus selon un nombre de parents connus
   -- un arbre null renvoie une liste vide
   procedure Get_Groupe (
      Resultat : in out T_Liste_Individu;
      Arbre          : in T_Arbre_Genealogique;
      Nb_Parent_Connu  : in Natural
   )with
   PRE => Nb_Parent_Connu >= 0 AND Nb_Parent_Connu <= 2;

   -- Récupération d'un noeud par identifiant
   -- un identifiant invalide ou un arbre null renvoie un arbre null
   function Get_Noeud (
      Arbre       : in T_Arbre_Genealogique;
      Identifiant : in T_Identifiant
   ) return T_Arbre_Genealogique;

   -- Récupération d'un des parent d'un noeud
   -- un arbre null renvoie un arbre null
   function Get_Parent (
      Arbre       : in T_Arbre_Genealogique;
      Parent : in T_Branche
   ) return T_Arbre_Genealogique;

   -- Récupération des caracteristiques humaines d'un noeud
   function Get_Humain_Noeud (
      Arbre       : in T_Arbre_Genealogique
   ) return T_Humain with
   PRE => Est_Vide_Arbre_Genealogique(Arbre) = False;

   -- Récupération de l'identifiant d'un noeud
   function Get_Identifiant_Noeud (
      Arbre       : in T_Arbre_Genealogique
   ) return T_Identifiant with
   PRE => Est_Vide_Arbre_Genealogique(Arbre) = False;

   -- compte les parents direct d'un noeud
   -- un arbre null renvoie un arbre null
   function Get_Nb_Parent (
      Arbre       : in T_Arbre_Genealogique
   ) return Natural with
   POST => Get_Nb_Parent'Result <= 2;

------------------------------------------------------- SET ---------------------------------------------------

   --- @brief Crée un arbre généalogique avec un individu initial.
   --- @param Arbre L'arbre généalogique en sortie.
   --- @param Humain L'individu initial.
   procedure Creer_Arbre (
      Arbre : in out T_Arbre_Genealogique;
      Humain : in T_Humain
   ) with
   POST =>
         Est_Egal_Humain(Get_Humain_Noeud(Arbre), Humain) AND
         Get_Nb_Parent(Arbre) = 0;
   
   --- @brief Supprime toute l'arborescence d'un arbre.
   --- @param Arbre L'arbre à libérer.
   procedure Free_Arbre_Genealogique (
      Arbre : in out T_Arbre_Genealogique
   );

   --- @brief Ajoute un parent à un individu dans l'arbre.
   --- @param Fils L'individu qui reçoit un parent.
   --- @param Humain Le parent à ajouter.
   --- @param Branche Indique si c'est un père ou une mère.
   procedure Add_Parent (
      Fils       : in out T_Arbre_Genealogique;
      Humain      : in T_Humain;
      Branche : in T_Branche
   ) with
   PRE => Branche /= Inconnu AND Fils /= Get_Arbre_Genealogique_Vide,
   POST => Est_Egal_Humain(Get_Humain_Noeud(Get_Parent(Fils, Branche)), Humain);

   --- @brief Modifie les données d'un humain dans un noeud donné.
   --- @param Arbre Le noeud à modifier.
   --- @param Humain Les nouvelles données de l'individu.
   procedure Set_Humain_Noeud (
      Arbre : in out T_Arbre_Genealogique;
      Humain : in T_Humain
   ) with
   POST => Est_Egal_Humain(Get_Humain_Noeud(Arbre), Humain);

   --- @brief Suppression d'un individu et de son sous-arbre
   --- @param Racine Le noeud racine (un ancetre de Noeud_Parent). un noeud null ne fait rien
   --- @param Noeud_Parent Le noeud à supprimer. un noeud null ne fait rien
   procedure Delete (
      Racine: in out T_Arbre_Genealogique;
      Noeud_Parent       : in out T_Arbre_Genealogique
   );

--------------------------------------------------- PRIVATE -----------------------------------------------

   private

      package Arbre_Binaire_Individu is
         new Arbre_Binaire (T_Contenu => T_Individu);
      use Arbre_Binaire_Individu;

      package Liste_Individu is
         new Liste (T_Type => T_Individu, Capacite => 100);
      use Liste_Individu;

      package Liste_Branche is
         new Liste (T_Type => T_Branche, Capacite => 100);
      use Liste_Branche;

      type T_Arbre_Genealogique is new Arbre_Binaire_Individu.T_Arbre;
      type T_Liste_Individu is new Liste_Individu.T_Liste with null record;
      type T_Liste_Branche is new Liste_Branche.T_Liste with null record;

      procedure Get_Parcours (Arbre : in T_Arbre_Genealogique; Identifiant : in T_Identifiant; Parcours : out T_Liste_Branche);

   -- affiche un noeud avec un certain nombre d'espace devant
   procedure Afficher_Noeud(
      N : in Natural;
      Parent : in T_Branche;
      Individu : in T_Individu
   );

   -- Change un lien de parenté d'un noeud. (en supprimant l'ancienne arborescence)
   procedure Set_Parent (
      Arbre       : in out T_Arbre_Genealogique;
      Parent : in T_Branche;
      Valeur       : in T_Arbre_Genealogique
   ) with
   PRE => Est_Vide_Arbre_Genealogique(Arbre) = False,
   POST => Get_Parent(Arbre, Parent) = Valeur;

   -- supprime un lien de parenté d'un noeud.
   -- un arbre null ne fait rien
   procedure Remove_Parent (
      Arbre       : in out T_Arbre_Genealogique;
      Parent : in T_Branche
   ) with
   POST => Get_Parent(Arbre, Parent) = Get_Arbre_Genealogique_Vide;


end Arbre_Genealogique;