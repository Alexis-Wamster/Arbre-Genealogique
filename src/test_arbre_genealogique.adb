with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Arbre_Genealogique;          use Arbre_Genealogique;
with Individu;       use Individu;

procedure Test_Arbre_Genealogique is


    David : T_Humain;
    Alexis : T_Humain;
    Mere : T_Humain;
    Arbre : T_Arbre_Genealogique;

begin
    pragma Assert (True);
    Alexis := creer_Humain_Vivant("Alexis", "Wamster", Homme, Creer_Date(28,5,2004), "Melun");
    David := creer_Humain_Vivant("David", "Wamster", Homme, Creer_Date(14,4,1975), "Mulhouse");
    Mere := creer_Humain_Vide;
    Creer_Arbre(Arbre, Alexis);
    Add_Pere(Arbre, Get_Identifiant_Noeud(Arbre), David);
    Add_Mere(Arbre, Get_Identifiant_Noeud(Arbre), Mere);
    Print_Arbre(Arbre, Get_Identifiant_Noeud(Arbre));
    
end Test_Arbre_Genealogique;