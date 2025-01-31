with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Arbre_Binaire;
with Liste;
with Individu;       use Individu;

package body Arbre_Genealogique is

------------------------------------------------------- SET ---------------------------------------------------

   -- Création de l'arbre généalogique avec un humain initial
   procedure Creer_Arbre (
      Arbre : in out T_Arbre_Genealogique;
      Humain : in T_Humain
   ) is
   begin
      Init(Arbre, Creer_Individu_Source(Humain));
   end Creer_Arbre;

   -- supprime toute l'arborescence d'un arbre
   procedure Free_Arbre_Genealogique (
      Arbre : in out T_Arbre_Genealogique
   ) is
   begin
      Free_Arbre(Arbre);
   end Free_Arbre_Genealogique;

   -- Ajout du père d'un individu identifié
   procedure Add_Parent (
      Fils       : in out T_Arbre_Genealogique;
      Humain      : in T_Humain;
      Branche : in T_Branche
   ) is
      Identifiant_Fils : T_Identifiant;
      Noeud_Parent : T_Arbre_Genealogique;
   begin
      Identifiant_Fils := Get_Identifiant_Noeud(Fils);
      if Est_Vide_Arbre(Fils) = False then
         case Branche is
            when Pere =>
               Init(Noeud_Parent, creer_Individu_Pere(Humain, Identifiant_Fils));
               Set_Parent(Fils, Pere, Noeud_Parent);
            when Mere =>
               Init(Noeud_Parent, creer_Individu_Mere(Humain, Identifiant_Fils));
               Set_Parent(Fils, Mere, Noeud_Parent);
            when others =>
               null;
         end case;
      end if;
   end Add_Parent;

   -- Suppression d'un individu et de son sous-arbre
   procedure Delete (
      Racine: in out T_Arbre_Genealogique;
      Noeud_Parent       : in out T_Arbre_Genealogique
   ) is
      Noeud_Fils : T_Arbre_Genealogique;
      Parent : T_Branche;
   begin
      Parent := Get_Fils(Racine, Noeud_Parent, Noeud_Fils);
      if Est_Vide_Arbre(Noeud_Fils) = False then
         Remove_Parent(Noeud_Fils, Parent);
      end if;
   end Delete;

   -- Modification d'un sous arbre d'un noeud
   procedure Set_Parent (
      Arbre       : in out T_Arbre_Genealogique;
      Parent : in T_Branche;
      Valeur       : in T_Arbre_Genealogique
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
      Humain : in T_Humain
   ) is
      Individu : T_Individu;
   begin
      Individu := Get_Contenu(Arbre);
      Set_Humain(Individu, Humain);
      Set_Contenu(Arbre, Individu);
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

---------------------------------------------------- GET -----------------------------------------------------

   function Get_Fils(Noeud_Racine : in T_Arbre_Genealogique; Noeud_Parent: in T_Arbre_Genealogique; Noeud_Fils : out T_Arbre_Genealogique) return T_Branche is
      Identifiant_Parent : T_Identifiant;
      Reste : Natural;
   begin
      Identifiant_Parent := Get_Identifiant_Noeud(Noeud_Parent);
      Reste := Identifiant_Parent mod 2;
      Noeud_Fils := Get_Noeud(Noeud_Racine, (Identifiant_Parent-Reste)/2);
      case Reste is
         when 0 => return Pere;
         when others => return Mere;
      end case;
   end Get_Fils;
   
   -- Calcul du nombre d'ancêtres d'un individu
   function Get_Nb_Ancetre (
      Arbre       : in T_Arbre_Genealogique
   ) return Natural is
   begin
      if Est_Vide_Arbre(Arbre) then
         return 0;
      else
         return 1 + Get_Nb_Ancetre(Get_Parent(Arbre, Pere)) + Get_Nb_Ancetre(Get_Parent(Arbre, Mere));
      end if;
   end Get_Nb_Ancetre;

   -- Récupération des individus d'une génération donnée par rapport à un noeud donné
   procedure Get_Gen (
      Resultat : in out T_Liste_Individu;
      Arbre       : in T_Arbre_Genealogique;
      Equart_Gen   : in Integer
   ) is
   begin
      if Est_Vide_Arbre(Arbre) OR Est_Pleine(Resultat) then
         return;
      end if;
      if (Equart_Gen > 0) then
         Get_Gen(Resultat, Get_Parent(Arbre, Pere), Equart_Gen-1);
         Get_Gen(Resultat, Get_Parent(Arbre, Mere), Equart_Gen-1);
      elsif (Equart_Gen = 0) then
         Ajouter(Resultat, Get_Contenu(Arbre));
      end if;
   end Get_Gen;

   -- Récupération des individus selon un nombre de parents connus
   procedure Get_Groupe (
      Resultat : in out T_Liste_Individu;
      Arbre          : in T_Arbre_Genealogique;
      Nb_Parent_Connu  : in Natural
   )is
   begin
      if Est_Vide_Arbre(Arbre) or Est_Pleine(Resultat) then
         return;
      end if;
      if (Get_Nb_Parent(Arbre) = Nb_Parent_Connu) then
         Ajouter(Resultat, Get_Contenu(Arbre));
      end if;
      Get_Groupe(Resultat, Get_Parent(Arbre, Pere), Nb_Parent_Connu);
      Get_Groupe(Resultat, Get_Parent(Arbre, Mere), Nb_Parent_Connu);
   end Get_Groupe;

   -- Récupération d'un noeud par identifiant
   function Get_Noeud (
      Arbre       : in T_Arbre_Genealogique;
      Identifiant : in T_Identifiant
   ) return T_Arbre_Genealogique is
    Parcours : T_Liste_Branche;
    Equart_Gen : Natural;
    Resultat : T_Arbre_Genealogique;
   begin
      begin
         Get_Parcours(Arbre, Identifiant, Parcours);
      exception
         when Constraint_Error => return Get_Arbre_Vide;
      end;
      -- parcourir l'arbre selon le chemin trouver
      Resultat := Arbre;
      Equart_Gen := Taille(Parcours);
      for I in reverse 1..Equart_Gen loop
         Resultat := Get_Parent(Resultat, Obtenir(Parcours, I));
         if Est_Vide_Arbre(Arbre) then
            return Get_Arbre_Vide; -- l'identifiant n'existe pas ou plus
         end if;
      end loop;
      return Resultat;
      
   end Get_Noeud;

   -- Recupere un arbre vide (null)
   function Get_Arbre_Genealogique_Vide return T_Arbre_Genealogique is
   begin
      return Get_Arbre_Vide;
   end Get_Arbre_Genealogique_Vide;

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

   procedure Get_Parcours (Arbre : in T_Arbre_Genealogique; Identifiant : in T_Identifiant; Parcours : out T_Liste_Branche) is
      Identifiant_Courant : T_Identifiant;
      Indentifiant_Racine : T_Identifiant;
   begin
      if (Identifiant < 1 or Est_Vide_Arbre_Genealogique(Arbre)) then
         raise Constraint_Error;
      end if;
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
         raise Constraint_Error; -- l'identifiant ne se trouve pas dans le sous-arbre "Arbre"
      end if;
   end Get_Parcours;

--------------------------------------------- PRINT ------------------------------------------

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

      -- Affichage de l'arbre généalogique
   procedure Print_Arbre(
      Arbre      : in T_Arbre_Genealogique;
      Parent : in T_Branche;
      Equart_Gen : in Natural
   ) is
   begin
      if Est_Vide_Arbre(Arbre) = False then
         Afficher_Noeud(Equart_Gen, Parent, Get_Contenu(Arbre));
         Print_Arbre(Get_Parent(Arbre, Pere), Pere, Equart_Gen + 1);
         Print_Arbre(Get_Parent(Arbre, Mere), Mere, Equart_Gen + 1);
      end if;
   end Print_Arbre;

   -- Affiche N espaces, suivi de \"---\", le prénom, le nom et le sexe.
   procedure Afficher_Noeud(N : in Natural; Parent : in T_Branche; Individu : in T_Individu) is
   begin
      Put(Item => (1 .. N*12 => ' '));
      Put("\--- ");
      if (Parent /= Inconnu) then
         Put(Parent'Image);
         Put(" :");
      end if;
      Put_Line(To_String_Individu(Individu));
   end Afficher_Noeud;


end Arbre_Genealogique;