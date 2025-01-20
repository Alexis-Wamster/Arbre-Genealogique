with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;

package body Arbre_Binaire is

   -- Procédure pour initialiser un noeud avec un contenu
   procedure Init (Tree : out T_Arbre; Contenu : in T_Contenu) is
   begin
      Tree := new T_Noeud'(Left => null, Right => null, Contenu => Contenu);
   end Init;

   function Get_Arbre_Vide return T_Arbre is
   begin
      return null;
   end Get_Arbre_Vide;

   -- Procédure pour ajouter ou écraser un élément à gauche
   procedure Set_Left (Tree : T_Arbre; Contenu : in T_Contenu) is
   begin
      Tree.Left := new T_Noeud'(Left => null, Right => null, Contenu => Contenu);
   end Set_Left;

   -- Procédure pour ajouter ou écraser un élément à droite
   procedure Set_Right (Tree : T_Arbre; Contenu : in T_Contenu) is
   begin
      Tree.Right := new T_Noeud'(Left => null, Right => null, Contenu => Contenu);
   end Set_Right;

   -- Ajoute ou remplace le sous-arbre gauche avec un nouveau sous-arbre
   procedure Set_Noeud_Left (Tree : T_Arbre; Noeud : in T_Arbre) is
   begin
      Tree.Left := Noeud;
   end Set_Noeud_Left;

   -- Ajoute ou remplace le sous-arbre droit avec un nouveau sous-arbre
   procedure Set_Noeud_Right (Tree : T_Arbre; Noeud : in T_Arbre) is
   begin
      Tree.Right := Noeud;
   end Set_Noeud_Right;

   -- Procédure pour supprimer le noeud de gauche
   procedure Remove_Left (Tree : T_Arbre) is
   begin
      Tree.Left := null;
   end Remove_Left;

   -- Procédure pour supprimer le noeud de droite
   procedure Remove_Right (Tree : T_Arbre) is
   begin
      Tree.Right := null;
   end Remove_Right;

   procedure Set_Contenu (Tree : in out T_Arbre; Contenu : in T_Contenu) is
   begin
      Tree.Contenu := Contenu;
   end Set_Contenu;

   -- Fonction pour obtenir le noeud de gauche
   function Get_Left (Tree : in T_Arbre) return T_Arbre is
   begin
      return Tree.Left;
   end Get_Left;

   -- Fonction pour obtenir le noeud de droite
   function Get_Right (Tree : in T_Arbre) return T_Arbre is
   begin
      return Tree.Right;
   end Get_Right;

   -- Fonction pour obtenir le contenu d'un noeud
   function Get_Contenu (Tree : in T_Arbre) return T_Contenu is
   begin
      return Tree.Contenu;
   end Get_Contenu;

   -- Fonction qui verifie si il existe un sous-arbre droit
   function Has_Right (Tree : in T_Arbre) return Boolean is
   begin
      return Tree.Right /= null;
   end Has_Right;

   -- Fonction qui verifie si il existe un sous-arbre gauche
   function Has_Left (Tree : in T_Arbre) return Boolean is
   begin
      return Tree.Left /= null;
   end Has_Left;

   -- Fonction qui verifie si l'arbre est vide (est null)
   function Est_Vide_Arbre (Tree : in T_Arbre) return Boolean is
   begin
      return Tree = null;
   end Est_Vide_Arbre;

end Arbre_Binaire;
