with Ada.Text_IO; use Ada.Text_IO;
with Arbre_Binaire;

procedure Test_Arbre_Binaire is

   -- Instanciation du package générique avec un type concret (ici, Integer)
   package Arbre_Integer is new Arbre_Binaire(T_Contenu => Integer);
   use Arbre_Integer;

   -- Variables de test
   Arbre_Racine : T_Arbre;
   Arbre_Gauche : T_Arbre;
   Arbre_Droit  : T_Arbre;
   Arbre_Vide   : T_Arbre;

begin
   -- Initialisation de l'arbre racine
   Init(Arbre_Racine, 10);
   Put_Line("Arbre Racine initialisé avec contenu: " & Integer'Image(Get_Contenu(Arbre_Racine)));

   -- Test de l'ajout d'un sous-arbre gauche
   Set_Left(Arbre_Racine, 5);
   Put_Line("Sous-arbre gauche ajouté avec contenu: " & Integer'Image(Get_Contenu(Get_Left(Arbre_Racine))));

   -- Test de l'ajout d'un sous-arbre droit
   Set_Right(Arbre_Racine, 15);
   Put_Line("Sous-arbre droit ajouté avec contenu: " & Integer'Image(Get_Contenu(Get_Right(Arbre_Racine))));

   -- Test de la vérification des sous-arbres
   if Has_Left(Arbre_Racine) then
      Put_Line("L'arbre racine a un sous-arbre gauche.");
   else
      Put_Line("Erreur: L'arbre racine devrait avoir un sous-arbre gauche.");
   end if;

   if Has_Right(Arbre_Racine) then
      Put_Line("L'arbre racine a un sous-arbre droit.");
   else
      Put_Line("Erreur: L'arbre racine devrait avoir un sous-arbre droit.");
   end if;

   -- Test de la suppression du sous-arbre gauche
   Remove_Left(Arbre_Racine);
   if not Has_Left(Arbre_Racine) then
      Put_Line("Sous-arbre gauche supprimé avec succès.");
   else
      Put_Line("Erreur: Le sous-arbre gauche n'a pas été supprimé.");
   end if;

   -- Test de la suppression du sous-arbre droit
   Remove_Right(Arbre_Racine);
   if not Has_Right(Arbre_Racine) then
      Put_Line("Sous-arbre droit supprimé avec succès.");
   else
      Put_Line("Erreur: Le sous-arbre droit n'a pas été supprimé.");
   end if;

   -- Test de l'ajout d'un sous-arbre gauche avec un noeud existant
   Init(Arbre_Gauche, 3);
   Set_Noeud_Left(Arbre_Racine, Arbre_Gauche);
   Put_Line("Sous-arbre gauche ajouté avec un noeud existant: " & Integer'Image(Get_Contenu(Get_Left(Arbre_Racine))));

   -- Test de l'ajout d'un sous-arbre droit avec un noeud existant
   Init(Arbre_Droit, 7);
   Set_Noeud_Right(Arbre_Racine, Arbre_Droit);
   Put_Line("Sous-arbre droit ajouté avec un noeud existant: " & Integer'Image(Get_Contenu(Get_Right(Arbre_Racine))));

   -- Test de la modification du contenu de l'arbre racine
   Set_Contenu(Arbre_Racine, 20);
   Put_Line("Contenu de l'arbre racine modifié: " & Integer'Image(Get_Contenu(Arbre_Racine)));

   -- Test de la vérification d'un arbre vide
   Arbre_Vide := Get_Arbre_Vide;
   if Est_Vide_Arbre(Arbre_Vide) then
      Put_Line("L'arbre vide a été correctement créé.");
   else
      Put_Line("Erreur: L'arbre vide n'a pas été correctement créé.");
   end if;

   -- Test de la vérification d'un arbre non vide
   if not Est_Vide_Arbre(Arbre_Racine) then
      Put_Line("L'arbre racine n'est pas vide.");
   else
      Put_Line("Erreur: L'arbre racine devrait ne pas être vide.");
   end if;

   -- Test de la précondition sur les fonctions Get_Left et Get_Right
   declare
      Temp_Arbre : T_Arbre;
   begin
      Temp_Arbre := Get_Left(Arbre_Vide); -- Doit lever une exception
      Put_Line("Erreur: Get_Left n'a pas levé d'exception sur un arbre vide.");
   exception
      when others =>
         Put_Line("Exception correctement levée pour Get_Left sur un arbre vide.");
   end;

   declare
      Temp_Arbre : T_Arbre;
   begin
      Temp_Arbre := Get_Right(Arbre_Vide); -- Doit lever une exception
      Put_Line("Erreur: Get_Right n'a pas levé d'exception sur un arbre vide.");
   exception
      when others =>
         Put_Line("Exception correctement levée pour Get_Right sur un arbre vide.");
   end;

end Test_Arbre_Binaire;