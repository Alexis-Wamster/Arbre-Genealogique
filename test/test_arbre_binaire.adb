with Arbre_Binaire;
with Ada.Text_IO; use Ada.Text_IO;

procedure Test_Arbre_Binaire is

   package Int_Arbre_Binaire is new Arbre_Binaire (Integer);
   use Int_Arbre_Binaire;

   Tree, Left_Subtree, Right_Subtree : T_Arbre;
   Empty_Tree                        : T_Arbre := Get_Arbre_Vide;
   Content                           : Integer;

begin
   -- Test 1: Initialisation
   Put_Line("Test 1: Initialisation");
   Init(Tree, 10);
   if Est_Vide_Arbre(Tree) then
      Put_Line("Échec: L'arbre initialisé ne devrait pas être vide.");
   else
      Put_Line("Succès: L'arbre a été correctement initialisé.");
   end if;

   -- Test 2: Ajout de sous-arbres gauche et droit
   Put_Line("Test 2: Ajout de sous-arbres");
   Set_Left(Tree, 20);
   Set_Right(Tree, 30);
   if Get_Contenu(Get_Left(Tree)) /= 20 or else Get_Contenu(Get_Right(Tree)) /= 30 then
      Put_Line("Échec: Les sous-arbres gauche et droit n'ont pas été correctement ajoutés.");
   else
      Put_Line("Succès: Les sous-arbres ont été correctement ajoutés.");
   end if;

   -- Test 3: Modification du contenu
   Put_Line("Test 3: Modification du contenu");
   Set_Contenu(Tree, 15);
   if Get_Contenu(Tree) /= 15 then
      Put_Line("Échec: Le contenu n'a pas été modifié correctement.");
   else
      Put_Line("Succès: Le contenu a été modifié correctement.");
   end if;

   -- Test 4: Suppression des sous-arbres
   Put_Line("Test 4: Suppression des sous-arbres");
   Remove_Left(Tree);
   if Has_Left(Tree) then
      Put_Line("Échec: Le sous-arbre gauche n'a pas été supprimé.");
   else
      Put_Line("Succès: Le sous-arbre gauche a été supprimé.");
   end if;

   -- Test 5: Vérification des fonctions booléennes
   Put_Line("Test 5: Vérifications booléennes");
   if not Has_Right(Tree) then
      Put_Line("Échec: Le sous-arbre droit devrait exister.");
   else
      Put_Line("Succès: La vérification du sous-arbre droit est correcte.");
   end if;

   -- Test 6: Scénarios d'erreur
   Put_Line("Test 6: Scénarios d'erreur");
   begin
      Set_Left(Empty_Tree, 40); -- Devrait lever une exception
      Put_Line("Échec: Aucune exception n'a été levée pour Set_Left sur un arbre vide.");
   exception
      when others =>
         Put_Line("Succès: Une exception a été correctement levée pour Set_Left sur un arbre vide.");
   end;

end Test_Arbre_Binaire;
