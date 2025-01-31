generic
   type T_Contenu is private;
package Arbre_Binaire is

   type T_Arbre is private;

------------------------------------------------ GET -------------------------------------------------

--- @brief Retourne le sous-arbre gauche d'un arbre donné
--- @param Tree L'arbre dont on veut obtenir le sous-arbre gauche
--- @return Le sous-arbre gauche de l'arbre donné
--- @pre L'arbre ne doit pas être vide
function Get_Left (Tree : in T_Arbre) return T_Arbre with
   PRE => Est_Vide_Arbre(Tree) = False;

--- @brief Retourne le sous-arbre droit d'un arbre donné
--- @param Tree L'arbre dont on veut obtenir le sous-arbre droit
--- @return Le sous-arbre droit de l'arbre donné
--- @pre L'arbre ne doit pas être vide
function Get_Right (Tree : in T_Arbre) return T_Arbre with
   PRE => Est_Vide_Arbre(Tree) = False;

--- @brief Retourne le contenu du noeud racine d'un arbre
--- @param Tree L'arbre dont on veut obtenir le contenu du noeud racine
--- @return Le contenu du noeud racine
--- @pre L'arbre ne doit pas être vide
function Get_Contenu (Tree : in T_Arbre) return T_Contenu with
   PRE => Est_Vide_Arbre(Tree) = False;

--- @brief Retourne un arbre vide
--- @return Un arbre vide
function Get_Arbre_Vide return T_Arbre;

------------------------------------------------ INIT -------------------------------------------------

--- @brief Initialise un arbre avec un contenu donné
--- @param Tree L'arbre à initialiser
--- @param Contenu Le contenu à insérer dans le noeud racine
--- @post L'arbre contient le contenu donné et a des sous-arbres vides
procedure Init (Tree : out T_Arbre; Contenu : in T_Contenu) with
   POST =>
      Get_Contenu(Tree) = Contenu AND
      Get_Left(Tree) = Get_Arbre_Vide AND
      Get_Right(Tree) = Get_Arbre_Vide;

--- @brief Supprime un arbre et libère ses ressources
--- @param Tree L'arbre à libérer
--- @post L'arbre est vide
procedure Free_Arbre(Tree : in out T_Arbre);

------------------------------------------------ BOOLEAN -------------------------------------------------

--- @brief Vérifie la présence d'un sous-arbre droit
--- @param Tree L'arbre à vérifier
--- @return True si un sous-arbre droit existe, False sinon
--- @pre L'arbre ne doit pas être vide
function Has_Right (Tree : in T_Arbre) return Boolean with
   PRE => Est_Vide_Arbre(Tree) = False;

--- @brief Vérifie la présence d'un sous-arbre gauche
--- @param Tree L'arbre à vérifier
--- @return True si un sous-arbre gauche existe, False sinon
--- @pre L'arbre ne doit pas être vide
function Has_Left (Tree : in T_Arbre) return Boolean with
   PRE => Est_Vide_Arbre(Tree) = False;

--- @brief Vérifie si l'arbre est vide
--- @param Tree L'arbre à vérifier
--- @return True si l'arbre est vide, False sinon
function Est_Vide_Arbre (Tree : in T_Arbre) return Boolean;

------------------------------------------------ SET -------------------------------------------------

--- @brief Modifie le sous-arbre gauche avec un nouveau contenu
--- @param Tree L'arbre dont on modifie le sous-arbre gauche
--- @param Contenu Le contenu à insérer
--- @pre L'arbre ne doit pas être vide
--- @post Le contenu du sous-arbre gauche est mis à jour
procedure Set_Left (Tree : T_Arbre; Contenu : in T_Contenu) with
   PRE => Est_Vide_Arbre(Tree) = False,
   POST => Get_Contenu(Get_Left(Tree)) = Contenu;

--- @brief Modifie le sous-arbre droit avec un nouveau contenu
--- @param Tree L'arbre dont on modifie le sous-arbre droit
--- @param Contenu Le contenu à insérer
--- @pre L'arbre ne doit pas être vide
--- @post Le contenu du sous-arbre droit est mis à jour
procedure Set_Right (Tree : T_Arbre; Contenu : in T_Contenu) with
   PRE => Est_Vide_Arbre(Tree) = False,
   POST => Get_Contenu(Get_Right(Tree)) = Contenu;

--- @brief Remplace le sous-arbre gauche par un autre arbre
--- @param Tree L'arbre dont on modifie le sous-arbre gauche
--- @param Noeud Le nouvel arbre à insérer
--- @pre L'arbre ne doit pas être vide
--- @post Le sous-arbre gauche est remplacé par le nouvel arbre
procedure Set_Noeud_Left (Tree : T_Arbre; Noeud : in T_Arbre) with
   PRE => Est_Vide_Arbre(Tree) = False,
   POST => Get_Left(Tree) = Noeud;

--- @brief Remplace le sous-arbre droit par un autre arbre
--- @param Tree L'arbre dont on modifie le sous-arbre droit
--- @param Noeud Le nouvel arbre à insérer
--- @pre L'arbre ne doit pas être vide
--- @post Le sous-arbre droit est remplacé par le nouvel arbre
procedure Set_Noeud_Right (Tree : T_Arbre; Noeud : in T_Arbre) with
   PRE => Est_Vide_Arbre(Tree) = False,
   POST => Get_Right(Tree) = Noeud;

--- @brief Change le contenu du noeud racine
--- @param Tree L'arbre dont on modifie le contenu
--- @param Contenu Le nouveau contenu
--- @post Le contenu de l'arbre est mis à jour
procedure Set_Contenu (Tree : in out T_Arbre; Contenu : in T_Contenu) with
   POST => Get_Contenu(Tree) = Contenu;

--- @brief Supprime le sous-arbre gauche d'un arbre
--- @param Tree L'arbre à modifier
--- @post Le sous-arbre gauche est vide
procedure Remove_Left (Tree : T_Arbre) with
   POST => Get_Left(Tree) = Get_Arbre_Vide;

--- @brief Supprime le sous-arbre droit d'un arbre
--- @param Tree L'arbre à modifier
--- @post Le sous-arbre droit est vide
procedure Remove_Right (Tree : T_Arbre) with
   POST => Get_Right(Tree) = Get_Arbre_Vide;

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