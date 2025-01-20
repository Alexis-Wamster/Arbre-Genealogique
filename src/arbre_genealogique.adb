with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Arbre_Binaire;
with Liste;
with Individu;       use Individu;

package body Arbre_Genealogique is

   -- Création de l'arbre généalogique avec un humain initial
   procedure Creer_Arbre (
      Arbre : in out T_Arbre_Genealogique;
      Humain : in T_Humain
   ) is
   begin
      Init(Arbre, Creer_Individu_Source(Humain));
   end Creer_Arbre;

   -- Ajout du père d'un individu identifié
   procedure Add_Pere (
      Arbre       : in out T_Arbre_Genealogique;
      Identifiant : in T_Identifiant;
      Humain      : in T_Humain
   ) is
      Fils : T_Arbre_Genealogique;
      Noeud_Pere : T_Arbre_Genealogique;
   begin
      Fils := Get_Noeud(Arbre, Identifiant);
      if Est_Vide_Arbre(Fils) = False then
         Init(Noeud_Pere, creer_Individu_Pere(Humain, Identifiant));
         Set_Parent(Fils, Pere, Noeud_Pere);
      end if;
   end Add_Pere;

   -- Ajout de la mère d'un individu identifié
   procedure Add_Mere (
      Arbre       : in out T_Arbre_Genealogique;
      Identifiant : in T_Identifiant;
      Humain      : in T_Humain
   ) is
      Fils : T_Arbre_Genealogique;
      Noeud_Mere : T_Arbre_Genealogique;
   begin
      Fils := Get_Noeud(Arbre, Identifiant);
      if Est_Vide_Arbre(Fils) = False then
         Init(Noeud_Mere, creer_Individu_Mere(Humain, Identifiant));
         Set_Parent(Fils, Mere, Noeud_Mere);
      end if;
   end Add_Mere;

   -- Affichage de l'arbre généalogique
   procedure Print_Arbre (
      Arbre       : in T_Arbre_Genealogique;
      Identifiant : in T_Identifiant
   ) is
      Noeud_Source : T_Arbre_Genealogique;
   begin
      Noeud_Source := Get_Noeud(Arbre, Identifiant);
      Print_Arbre_Recursif(Noeud_Source, Inconnu, 0);
   end Print_Arbre;

   -- Affichage de l'arbre généalogique
   procedure Print_Arbre_Recursif(
      Arbre      : in T_Arbre_Genealogique;
      Parent : in T_Branche;
      Equart_Gen : in Natural
   ) is
   begin
      if Est_Vide_Arbre(Arbre) = False then
         Afficher_Noeud(Equart_Gen, Parent, Get_Contenu(Arbre));
         Print_Arbre_Recursif(Get_Parent(Arbre, Pere), Pere, Equart_Gen + 1);
         Print_Arbre_Recursif(Get_Parent(Arbre, Mere), Mere, Equart_Gen + 1);
      end if;
   end Print_Arbre_Recursif;

   -- Affiche N espaces, suivi de \"---\", le prénom, le nom et le sexe.
   procedure Afficher_Noeud(N : Natural; Parent : T_Branche; Individu : T_Individu) is
   begin
      Put(Item => (1 .. N*12 => ' '));
      Put("\--- ");
      if (Parent /= Inconnu) then
         Put(Parent'Image);
         Put(" :");
      end if;
      Put_Line(To_String_Individu(Individu));
   end Afficher_Noeud;

   -- Suppression d'un individu et de son sous-arbre
   procedure Delete (
      Arbre       : in out T_Arbre_Genealogique;
      Identifiant : in T_Identifiant
   ) is
      Fils : T_Arbre_Genealogique;
   begin
      if (Identifiant mod 2 = 0) then
         Fils := Get_Noeud(Arbre, Identifiant/2);
         if Est_Vide_Arbre(Fils) = False then
            Remove_Parent(Fils, Pere);
         end if;
      else
         Fils := Get_Noeud(Arbre, (Identifiant-1)/2);
         if Est_Vide_Arbre(Fils) = False then
            Remove_Parent(Fils, Mere);
         end if;
      end if;
   end Delete;

   -- Calcul du nombre d'ancêtres d'un individu
   function Get_Nb_Ancetre (
      Arbre       : in T_Arbre_Genealogique;
      Identifiant : in T_Identifiant
   ) return Natural is
      Noeud_Source : T_Arbre_Genealogique;
   begin
      Noeud_Source := Get_Noeud(Arbre, Identifiant);
      return Get_Nb_Ancetre_Recursive(Noeud_Source);
   end Get_Nb_Ancetre;

   -- Calcul du nombre d'ancêtres d'un individu
   function Get_Nb_Ancetre_Recursive (
      Arbre       : in T_Arbre_Genealogique
   ) return Natural is
   begin
      if Est_Vide_Arbre(Arbre) then
         return 0;
      else
         return 1 + Get_Nb_Ancetre_Recursive(Get_Parent(Arbre, Pere)) + Get_Nb_Ancetre_Recursive(Get_Parent(Arbre, Mere));
      end if;
   end Get_Nb_Ancetre_Recursive;

   -- Récupération des individus d'une génération donnée par rapport à un identifiant située dans un arbre
   function Get_Gen (
      Arbre       : in T_Arbre_Genealogique;
      Identifiant : in T_Identifiant;
      Equart_Gen   : in Integer
   ) return T_Liste_Individu is
      Noeud_Source : T_Arbre_Genealogique;
      Resultat : T_Liste_Individu;
   begin
      Noeud_Source := Get_Noeud(Arbre, Identifiant);
      Initialiser(Resultat);
      Get_Gen_Recursive(Resultat, Noeud_Source, Equart_Gen);
      return Resultat;
   end Get_Gen;

   -- Récupération des individus d'une génération donnée par rapport à un noeud donné
   procedure Get_Gen_Recursive (
      Resultat : in out T_Liste_Individu;
      Arbre       : in T_Arbre_Genealogique;
      Equart_Gen   : in Integer
   ) is
   begin
      if Est_Vide_Arbre(Arbre) then
         return;
      end if;
      if (Equart_Gen = 0) then
         Ajouter(Resultat, Get_Contenu(Arbre));
         return;
      end if;
      Get_Gen_Recursive(Resultat, Get_Parent(Arbre, Pere), Equart_Gen-1);
      Get_Gen_Recursive(Resultat, Get_Parent(Arbre, Mere), Equart_Gen-1);
      return;
   end Get_Gen_Recursive;

   -- Récupération des individus selon un nombre de parents connus
   function Get_Groupe (
      Arbre          : in T_Arbre_Genealogique;
      Nb_Parent_Connu  : in Natural
   ) return T_Liste_Individu is
      Resultat : T_Liste_Individu;
   begin
      Initialiser(Resultat);
      if Est_Vide_Arbre(Arbre) then
         return Resultat;
      end if;
      if (Get_Nb_Parent(Arbre) = Nb_Parent_Connu) then
         Ajouter(Resultat, Get_Contenu(Arbre));
      end if;
      Concatener(Resultat, Get_Groupe(Get_Parent(Arbre, Pere), Nb_Parent_Connu));
      Concatener(Resultat, Get_Groupe(Get_Parent(Arbre, Mere), Nb_Parent_Connu));
      return Resultat;
   end Get_Groupe;

   -- Récupération d'un noeud par identifiant
   function Get_Noeud (
      Arbre       : in T_Arbre_Genealogique;
      Identifiant : in T_Identifiant
   ) return T_Arbre_Genealogique is
      package Liste_Branche is
		   new Liste (T_Type => T_Branche, Capacite => 100);
	   use Liste_Branche;

    Parcours : Liste_Branche.T_Liste;
    Equart_Gen : Natural;
    Indentifiant_Racine : T_Identifiant;
    Identifiant_Courant : T_IDENTIFIANT;
    Resultat : T_Arbre_Genealogique;
   begin
      if (Identifiant < 1 or Est_Vide_Arbre_Genealogique(Arbre)) then
         return Get_Arbre_Vide;
      end if;
      -- 1 trouver le chemin d'acces le plus court a partir de l'identifiant
      Identifiant_Courant := Identifiant;
      Indentifiant_Racine := Get_Identifiant_Noeud(Arbre);
      Initialiser(Parcours);
      while (Identifiant_Courant > Indentifiant_Racine) loop
         if (Identifiant_Courant mod 2 = 0) then
            Identifiant_Courant := Identifiant_Courant / 2;
            Ajouter(Parcours, Pere);
         else
            Identifiant_Courant := (Identifiant_Courant - 1) / 2;
            Ajouter(Parcours, Mere);
         end if;
      end loop;
      if (Identifiant_Courant /= Indentifiant_Racine) then
         return Get_Arbre_Vide; -- l'identifiant ne se trouve pas dans le sous-arbre "Arbre"
      else
         -- 2 parcourir l'arbre selon le chemin trouver
         Resultat := Arbre;
         Equart_Gen := Taille(Parcours);
         for I in reverse 1..Equart_Gen loop
            Resultat := Get_Parent(Resultat, Obtenir(Parcours, I));
            if Est_Vide_Arbre(Arbre) then
               return Get_Arbre_Vide; -- l'identifiant n'existe pas ou plus
            end if;
         end loop;
         return Resultat;
      end if;
      
   end Get_Noeud;

   function Get_Arbre_Genealogique_Vide return T_Arbre_Genealogique is
   begin
      return Get_Arbre_Vide;
   end Get_Arbre_Genealogique_Vide;

   -- Modification d'un sous arbre d'un noeud
   procedure Set_Parent (
      Arbre       : in out T_Arbre_Genealogique;
      Parent : in T_Branche;
      Valeur       : in out T_Arbre_Genealogique
   ) is
   begin
      case Parent is
         when Pere => Set_Noeud_Left(Arbre, Valeur);
         when Mere => Set_Noeud_Right(Arbre, Valeur);
         when others => null;
      end case;
   end Set_Parent;

   procedure Set_Humain_Noeud (
      Arbre : in out T_Arbre_Genealogique;
      Humain : T_Humain
   ) is
      Individu : T_Individu;
   begin
      Individu := Get_Contenu(Arbre);
      Put_Line(To_String_Individu(Individu));
      Set_Humain(Individu, Humain);
      Set_Contenu(Arbre, Individu);
      Put_Line(To_String_Humain(Humain));
      Put_Line(To_String_Individu(Individu));
   end Set_Humain_Noeud;

   procedure Remove_Parent (
      Arbre       : in out T_Arbre_Genealogique;
      Parent : in T_Branche
   ) is
   begin
      case Parent is
         when Pere => Remove_Left(Arbre);
         when Mere => Remove_Right(Arbre);
         when others => null;
      end case;
   end Remove_Parent;

   -- Récupération d'un des parent d'un noeud
   function Get_Parent (
      Arbre       : in T_Arbre_Genealogique;
      Parent : in T_Branche
   ) return T_Arbre_Genealogique is
   begin
      if (Est_Vide_Arbre(Arbre)) then
         return Get_Arbre_Vide;
      else
         case Parent is
            when Pere => return Get_Left(Arbre);
            when Mere => return Get_Right(Arbre);
            when others => return Get_Arbre_Vide;
         end case;
      end if;
   end Get_Parent;

   -- Récupération du nombre de parent connu d'un noeud
   function Get_Nb_Parent (
      Arbre       : in T_Arbre_Genealogique
   ) return Natural is
      Resultat : Natural;
   begin
      Resultat := 0;
      if Est_Vide_Arbre(Get_Parent(Arbre, Pere)) = False then
         Resultat := Resultat + 1;
      end if;
      if Est_Vide_Arbre(Get_Parent(Arbre, Mere)) = False then
         Resultat := Resultat + 1;
      end if;
      return Resultat;
   end Get_Nb_Parent;

   -- Récupération des caracteristiques humaines d'un noeud
   function Get_Humain_Noeud (
      Arbre       : in T_Arbre_Genealogique
   ) return T_Humain is
   begin
      return Get_Humain(Get_Contenu(Arbre));
   end Get_Humain_Noeud;

   -- Récupération de l'identifiant d'un noeud
   function Get_Identifiant_Noeud (
      Arbre       : in T_Arbre_Genealogique
   ) return T_Identifiant is
   begin
      return Get_Identifiant(Get_Contenu(Arbre));
   end Get_Identifiant_Noeud;

   function Est_Vide_Arbre_Genealogique (
      Arbre       : in T_Arbre_Genealogique
   ) return Boolean is
   begin
      return Est_Vide_Arbre(Arbre);
   end Est_Vide_Arbre_Genealogique;

   -- Verifie si un identifiant est présent dans l'arbre
   function Est_Identifiant_Dans_Arbre (
      Arbre       : in T_Arbre_Genealogique;
      Identifiant : in T_Identifiant
   ) return Boolean is
   begin
      return (Get_Noeud(Arbre, Identifiant) = Get_Arbre_Genealogique_Vide) = False;
   end Est_Identifiant_Dans_Arbre;

   -- Ecrit dans le terminal, la liste des individus
   procedure Print_Liste_Individu (Liste : in T_Liste_Individu) is
   begin
      for I in 1..Taille(Liste) loop
         Put_Line(To_String_Individu(Obtenir(Liste, I)));
      end loop;
   end Print_Liste_Individu;


end Arbre_Genealogique;