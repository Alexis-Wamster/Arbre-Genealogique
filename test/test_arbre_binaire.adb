with Ada.Text_IO; use Ada.Text_IO;
with Ada.Assertions; use Ada.Assertions;
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
   -- Test de la fonction Get_Arbre_Vide
   Arbre_Vide := Get_Arbre_Vide;
   Assert(Est_Vide_Arbre(Arbre_Vide), "Erreur : Get_Arbre_Vide ne retourne pas un arbre vide.");

   -- Test de la procédure Init
   Init(Arbre_Racine, 10);
   Assert(Get_Contenu(Arbre_Racine) = 10, "Erreur : Init n'a pas correctement initialisé le contenu.");
   Assert(Get_Left(Arbre_Racine) = Get_Arbre_Vide, "Erreur : Init n'a pas initialisé le sous-arbre gauche à vide.");
   Assert(Get_Right(Arbre_Racine) = Get_Arbre_Vide, "Erreur : Init n'a pas initialisé le sous-arbre droit à vide.");

   -- Test de la procédure Set_Left
   Set_Left(Arbre_Racine, 5);
   Assert(Get_Contenu(Get_Left(Arbre_Racine)) = 5, "Erreur : Set_Left n'a pas correctement ajouté le sous-arbre gauche.");

   -- Test de la procédure Set_Right
   Set_Right(Arbre_Racine, 15);
   Assert(Get_Contenu(Get_Right(Arbre_Racine)) = 15, "Erreur : Set_Right n'a pas correctement ajouté le sous-arbre droit.");

   -- Test des fonctions Has_Left et Has_Right
   Assert(Has_Left(Arbre_Racine), "Erreur : Has_Left n'a pas détecté le sous-arbre gauche.");
   Assert(Has_Right(Arbre_Racine), "Erreur : Has_Right n'a pas détecté le sous-arbre droit.");

   -- Test de la procédure Set_Noeud_Left
   Init(Arbre_Gauche, 3);
   Set_Noeud_Left(Arbre_Racine, Arbre_Gauche);
   Assert(Get_Left(Arbre_Racine) = Arbre_Gauche, "Erreur : Set_Noeud_Left n'a pas correctement ajouté le sous-arbre gauche.");

   -- Test de la procédure Set_Noeud_Right
   Init(Arbre_Droit, 7);
   Set_Noeud_Right(Arbre_Racine, Arbre_Droit);
   Assert(Get_Right(Arbre_Racine) = Arbre_Droit, "Erreur : Set_Noeud_Right n'a pas correctement ajouté le sous-arbre droit.");

   -- Test de la procédure Set_Contenu
   Set_Contenu(Arbre_Racine, 20);
   Assert(Get_Contenu(Arbre_Racine) = 20, "Erreur : Set_Contenu n'a pas correctement modifié le contenu.");

   -- Test de la procédure Remove_Left
   Remove_Left(Arbre_Racine);
   Assert(Get_Left(Arbre_Racine) = Get_Arbre_Vide, "Erreur : Remove_Left n'a pas correctement supprimé le sous-arbre gauche.");

   -- Test de la procédure Remove_Right
   Remove_Right(Arbre_Racine);
   Assert(Get_Right(Arbre_Racine) = Get_Arbre_Vide, "Erreur : Remove_Right n'a pas correctement supprimé le sous-arbre droit.");

   -- Test des préconditions (doivent lever des exceptions)
   begin
      -- Test de Get_Left sur un arbre vide
      declare
         Temp_Arbre : T_Arbre := Get_Left(Arbre_Vide);
      begin
         Assert(False, "Erreur : Get_Left n'a pas levé d'exception sur un arbre vide.");
      end;
   exception
      when others =>
         Put_Line("Précondition vérifiée : Get_Left a levé une exception sur un arbre vide.");
   end;

   begin
      -- Test de Get_Right sur un arbre vide
      declare
         Temp_Arbre : T_Arbre := Get_Right(Arbre_Vide);
      begin
         Assert(False, "Erreur : Get_Right n'a pas levé d'exception sur un arbre vide.");
      end;
   exception
      when others =>
         Put_Line("Précondition vérifiée : Get_Right a levé une exception sur un arbre vide.");
   end;

   begin
      -- Test de Set_Left sur un arbre vide
      declare
         Temp_Arbre : T_Arbre := Get_Arbre_Vide;
      begin
         Set_Left(Temp_Arbre, 5);
         Assert(False, "Erreur : Set_Left n'a pas levé d'exception sur un arbre vide.");
      end;
   exception
      when others =>
         Put_Line("Précondition vérifiée : Set_Left a levé une exception sur un arbre vide.");
   end;

   begin
      -- Test de Set_Right sur un arbre vide
      declare
         Temp_Arbre : T_Arbre := Get_Arbre_Vide;
      begin
         Set_Right(Temp_Arbre, 5);
         Assert(False, "Erreur : Set_Right n'a pas levé d'exception sur un arbre vide.");
      end;
   exception
      when others =>
         Put_Line("Précondition vérifiée : Set_Right a levé une exception sur un arbre vide.");
   end;

   -- Affichage final
   Put_Line("Tous les tests ont été exécutés avec succès.");

end Test_Arbre_Binaire;