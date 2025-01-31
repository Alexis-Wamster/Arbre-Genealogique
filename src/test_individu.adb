with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Individu;                    use Individu;

procedure Test_Individu is


    Noeud_David : T_Individu;
    Noeud_Alexis : T_Individu;
    Id : T_Identifiant;
    David : T_Humain;
    Alexis : T_Humain;
    Date : T_Date;

begin
    pragma Assert (True);
    Alexis := creer_Humain_Vide;
    Set_Sexe(Alexis, Homme);
    Set_Prenom(Alexis, "Alexis");
    Set_Nom(Alexis, "Wamster");
    Date := Creer_Date(28,5,2004);
    Set_Date_Naissance(Alexis, Date);

    Noeud_Alexis := creer_Individu_Source(Alexis);

    Date := Creer_Date(14,4,1975);
    David := creer_Humain_Vivant("David", "Wamster", Homme, Date, "Mulhouse");
    Id := Get_Identifiant(Noeud_Alexis);
    Noeud_David := creer_Individu_Pere(David, Id);
    
end Test_Individu;