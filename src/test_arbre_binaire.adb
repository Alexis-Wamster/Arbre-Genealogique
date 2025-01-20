with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Arbre_Binaire;

procedure Test_Arbre_Binaire is

    package Arbre_Char is
		new Arbre_Binaire (T_Contenu => Character);
	use Arbre_Char;

    Arbre : Arbre_Char.T_Arbre;
    Arbre2 : Arbre_Char.T_Arbre;

begin
    Init (Arbre, 'f');
    Init (Arbre2, 'a');
    Set_Left (Arbre, 'l');
    Set_Noeud_Right (Arbre, Arbre2);
    pragma Assert (Get_Contenu(Get_Left(Arbre)) = 'l');
    pragma Assert (Get_Contenu(Get_Right(Arbre)) = 'r');
    Remove_Left (Arbre);
    Remove_Right (Arbre);
    pragma Assert (Has_Left(Arbre) = False);
    pragma Assert (Has_Right(Arbre) = False);
end Test_Arbre_Binaire;