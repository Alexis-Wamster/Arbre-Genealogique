with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Arbre_Genealogique;          use Arbre_Genealogique;
with Commandes_Main;              use Commandes_Main;

procedure Main_Arbre_Genealogique is
    -- main
    Execution : Boolean := True;
    Arbre : T_Arbre_Genealogique;
begin
    Put_Line("----------------------------------------");
    Put_Line("Bienvenue dans 'Arbre Généalogique' !");
    Put_Line("L'application qui permet de recreer votre arbre généalogique.");

    while (Execution) loop
        Afficher_Actions;
        Execution := Lire_Action(Arbre);
    end loop;    
    
end Main_Arbre_Genealogique;