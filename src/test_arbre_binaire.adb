with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Arbre_Binaire;

procedure Test_Arbre_Binaire is

    package Arbre_Char is
		new Arbre_Binaire (T_Contenu => Character);
	use Arbre_Char;

    Arbre : T_Arbre;

begin
    Init (Arbre, 'f');
    AddLeft (Arbre, 'l');
    AddRight (Arbre, 'r');
    pragma Assert (GetContenu(GetLeft(Arbre)) = 'l');
    pragma Assert (GetContenu(GetRight(Arbre)) = 'r');
    RemoveLeft (Arbre);
    RemoveRight (Arbre);
    pragma Assert (HasLeft(Arbre) = False);
    pragma Assert (HasRight(Arbre) = False);
end Test_Arbre_Binaire;