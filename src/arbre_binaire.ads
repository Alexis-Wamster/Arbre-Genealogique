generic
   type T_Contenu is private;
package Arbre_Binaire is

   type T_Arbre is limited private;

   -- Initialise un noeud avec un contenu
   procedure Init (Tree : out T_Arbre; Contenu : in T_Contenu);

   -- Ajoute ou remplace le sous-arbre gauche avec un contenu
   procedure AddLeft (Tree : T_Arbre; Contenu : in T_Contenu) with
      pre => EstVide(Tree);

   -- Ajoute ou remplace le sous-arbre droit avec un contenu
   procedure AddRight (Tree : T_Arbre; Contenu : in T_Contenu) with
      pre => EstVide(Tree);

   -- Supprime le sous-arbre gauche
   procedure RemoveLeft (Tree : T_Arbre) with
      pre => EstVide(Tree);

   -- Supprime le sous-arbre droit
   procedure RemoveRight (Tree : T_Arbre) with
      pre => EstVide(Tree);

   -- Retourne le sous-arbre gauche
   function GetLeft (Tree : in T_Arbre) return T_Arbre with
      pre => EstVide(Tree);

   -- Retourne le sous-arbre droit
   function GetRight (Tree : in T_Arbre) return T_Arbre with
      pre => EstVide(Tree);

   -- Renvoie le contenu d'un noeud
   function GetContenu (Tree : in T_Arbre) return T_Contenu with
      pre => EstVide(Tree);

   -- Verifie si il existe un sous-arbre droit
   function HasRight (Tree : in T_Arbre) return Boolean with
      pre => EstVide(Tree);

   -- Verifie si il existe un sous-arbre gauche
   function HasLeft (Tree : in T_Arbre) return Boolean with
      pre => EstVide(Tree);
   
   -- Verifie si l'arbre est vide (est null)
   function EstVide (Tree : in T_Arbre) return Boolean;

   private

      type T_Noeud;
      type T_Arbre is access T_Noeud;

      type T_Noeud is limited record
         Left   : T_Arbre := null;
         Right  : T_Arbre := null;
         Contenu : T_Contenu;
      end record;

end Arbre_Binaire;