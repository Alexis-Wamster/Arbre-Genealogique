with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;

package body Arbre_Binaire is

   -- Procédure pour initialiser un noeud avec un contenu
   procedure Init (Tree : out T_Arbre; Contenu : in T_Contenu) is
   begin
      Tree := new T_Noeud'(Left => null, Right => null, Contenu => Contenu);
   end Init;

   -- Procédure pour ajouter ou écraser un élément à gauche
   procedure AddLeft (Tree : T_Arbre; Contenu : in T_Contenu) is
   begin
      Tree.Left := new T_Noeud'(Left => null, Right => null, Contenu => Contenu);
   end AddLeft;

   -- Procédure pour ajouter ou écraser un élément à droite
   procedure AddRight (Tree : T_Arbre; Contenu : in T_Contenu) is
   begin
      Tree.Right := new T_Noeud'(Left => null, Right => null, Contenu => Contenu);
   end AddRight;

   -- Procédure pour supprimer le noeud de gauche
   procedure RemoveLeft (Tree : T_Arbre) is
   begin
      Tree.Left := null;
   end RemoveLeft;

   -- Procédure pour supprimer le noeud de droite
   procedure RemoveRight (Tree : T_Arbre) is
   begin
      Tree.Right := null;
   end RemoveRight;

   -- Fonction pour obtenir le noeud de gauche
   function GetLeft (Tree : in T_Arbre) return T_Arbre is
   begin
      return Tree.Left;
   end GetLeft;

   -- Fonction pour obtenir le noeud de droite
   function GetRight (Tree : in T_Arbre) return T_Arbre is
   begin
      return Tree.Right;
   end GetRight;

   -- Fonction pour obtenir le contenu d'un noeud
   function GetContenu (Tree : in T_Arbre) return T_Contenu is
   begin
      return Tree.Contenu;
   end GetContenu;

   -- Fonction qui verifie si il existe un sous-arbre droit
   function HasRight (Tree : in T_Arbre) return Boolean is
   begin
      return Tree.Right /= null;
   end HasRight;

   -- Fonction qui verifie si il existe un sous-arbre gauche
   function HasLeft (Tree : in T_Arbre) return Boolean is
   begin
      return Tree.Left /= null;
   end HasLeft;

   -- Fonction qui verifie si l'arbre est vide (est null)
   function EstVide (Tree : in T_Arbre) return Boolean is
   begin
      return Tree = null;
   end EstVide;

end Arbre_Binaire;
