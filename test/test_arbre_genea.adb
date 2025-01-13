-- Methodologie de la programmation - Projet 2024/2025
-- Arbre généalogique
-- Ken TIZEN DJONGUE, WAMSTER Alexis
-- FICHIER DE TESTS DU PAQUETAGE arbre_genealogique.adb

with Ada.Text_IO; use Ada.Text_IO;
with Arbre_Genealogique;
with Individu;
with Arbre_Binaire;

procedure Test_Arbre_Genealogique is
   package IO_Integer is new Ada.Integer_Text_IO;
   use Arbre_Genealogique;
   use Individu;

   -- Déclarations des variables pour les tests
   Arbre_test                         : T_Arbre_Genealogique;
   Humain1, Humain2, Humain3, Humain4 : T_Humain;

   procedure Afficher_Ligne (Description : String) is
   begin
      Put_Line ("--- " & Description & " ---");
   end Afficher_Ligne;

begin
   -- Initialisation des individus
   Humain1 :=
     creer_Humain_Vivant
       (Nom => "Dupont", Prenom => "Jean", Sexe => Homme,
        Creer_Date (28, 5, 2_004), "Melun");
   Humain2 :=
     creer_Humain_Default (Nom => "Martin", Prenom => "Pierre", Sexe => Homme);
   Humain3 :=
     creer_Humain_Default
       (Nom => "Lemoine", Prenom => "Claire", Sexe => Femme);
   Humain4 :=
     creer_Humain_Default (Nom => "Dubois", Prenom => "Anne", Sexe => Femme);

   -- Test 1 : Création de l'arbre
   Afficher_Ligne ("Création de l'arbre avec Jean Dupont");
   Creer_Arbre (Arbre_test, Humain1);
   Print_Arbre (Arbre_test, Get_Identifiant (Humain1));

   -- Test 2 : Ajout d'un père
   Afficher_Ligne ("Ajout de Pierre Martin comme père de Jean Dupont");
   Add_Pere (Arbre_test, Get_Identifiant (Humain1), Humain2);
   Print_Arbre (Arbre_test, Get_Identifiant (Humain1));

   -- Test 3 : Ajout d'une mère
   Afficher_Ligne ("Ajout de Claire Lemoine comme mère de Jean Dupont");
   Add_Mere (Arbre_test, Get_Identifiant (Humain1), Humain3);
   Print_Arbre (Arbre_test, Get_Identifiant (Humain1));

   -- Test 4 : Suppression d'un nœud
   Afficher_Ligne ("Suppression du père (Pierre Martin)");
   Delete (Arbre_test, Get_Identifiant (Humain2));
   Print_Arbre (Arbre_test, Get_Identifiant (Humain1));

   -- Test 5 : Nombre d'ancêtres
   Afficher_Ligne ("Calcul du nombre d'ancêtres de Jean Dupont");
   declare
      Nb_Ancetres : Natural;
   begin
      Nb_Ancetres := Get_Nb_Ancetre (Arbre_test, Get_Identifiant (Humain1));
      Put_Line ("Nombre d'ancêtres connus : " & Natural'Image (Nb_Ancetres));
   end;

   -- Test 6 : Individus d'une génération donnée
   Afficher_Ligne ("Récupération des individus de génération 1 (parents)");
   declare
      Gen_1 : T_Liste_Individu;
   begin
      Gen_1 := Get_Gen (Arbre_test, Get_Identifiant (Humain1), 1);
      Put_Line ("Individus génération 1 :");
      Print_Liste (Gen_1);
   end;

   -- Test 7 : Récupération des individus avec deux parents connus
   Afficher_Ligne ("Individus avec deux parents connus");
   declare
      Deux_Parents : T_Liste_Individu;
   begin
      Deux_Parents := Get_Groupe (Arbre_test, 2);
      Put_Line ("Individus avec deux parents connus :");
      Print_Liste (Deux_Parents);
   end;

end Test_Arbre_Genealogique;
