generic
   type T_Contenu is private;
package Arbre_Binaire is

   type T_Arbre is private;

   ------------------------------------------------ INIT -------------------------------------------------

   -- Initialise un noeud avec un contenu
   procedure Init (Tree : out T_Arbre; Contenu : in T_Contenu);

   ------------------------------------------------ SET -------------------------------------------------

   -- Ajoute ou remplace le sous-arbre gauche avec un contenu
   procedure Set_Left (Tree : T_Arbre; Contenu : in T_Contenu) with
      pre => Est_Vide_Arbre(Tree);

   -- Ajoute ou remplace le sous-arbre droit avec un contenu
   procedure Set_Right (Tree : T_Arbre; Contenu : in T_Contenu) with
      pre => Est_Vide_Arbre(Tree);

   -- Ajoute ou remplace le sous-arbre gauche avec un nouveau sous-arbre
   procedure Set_Noeud_Left (Tree : T_Arbre; Noeud : in T_Arbre) with
      pre => Est_Vide_Arbre(Tree);

   -- Ajoute ou remplace le sous-arbre droit avec un nouveau sous-arbre
   procedure Set_Noeud_Right (Tree : T_Arbre; Noeud : in T_Arbre) with
      pre => Est_Vide_Arbre(Tree);

   -- Ajoute ou remplace le le contenu d'un noeud
   procedure Set_Contenu (Tree : in out T_Arbre; Contenu : in T_Contenu);

   -- Supprime le sous-arbre gauche (:= null)
   procedure Remove_Left (Tree : T_Arbre) with
      pre => Est_Vide_Arbre(Tree);

   -- Supprime le sous-arbre droit (:= null)
   procedure Remove_Right (Tree : T_Arbre) with
      pre => Est_Vide_Arbre(Tree);

   ------------------------------------------------ GET -------------------------------------------------

   -- Retourne le sous-arbre gauche
   function Get_Left (Tree : in T_Arbre) return T_Arbre with
      pre => Est_Vide_Arbre(Tree);

   -- Retourne le sous-arbre droit
   function Get_Right (Tree : in T_Arbre) return T_Arbre with
      pre => Est_Vide_Arbre(Tree);

   -- Renvoie le contenu d'un noeud
   function Get_Contenu (Tree : in T_Arbre) return T_Contenu with
      pre => Est_Vide_Arbre(Tree);

   -- Renvoie un Arbre_Vide (null)
   function Get_Arbre_Vide return T_Arbre;

   ------------------------------------------------ BOOLEAN -------------------------------------------------

   -- Verifie si il existe un sous-arbre droit
   function Has_Right (Tree : in T_Arbre) return Boolean with
      pre => Est_Vide_Arbre(Tree);

   -- Verifie si il existe un sous-arbre gauche
   function Has_Left (Tree : in T_Arbre) return Boolean with
      pre => Est_Vide_Arbre(Tree);
   
   -- Verifie si l'arbre est vide (est null)
   function Est_Vide_Arbre (Tree : in T_Arbre) return Boolean;

   private

   ------------------------------------------------ TYPE -------------------------------------------------

      type T_Noeud;
      type T_Arbre is access T_Noeud;

      type T_Noeud is limited record
         Left   : T_Arbre := null;
         Right  : T_Arbre := null;
         Contenu : T_Contenu;
      end record;

end Arbre_Binaire;