with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Liste;

procedure Test_Liste is
    package Liste_Char is
		new Liste (T_Type => Character, Capacite => 3);
	use Liste_Char;

    Mot : Liste_Char.T_Liste;
begin
    Initialiser(Mot);
    Pragma Assert(Est_Vide(Mot));
    Ajouter(Mot, 'A');
    Ajouter(Mot, 'E');
    Inserer(Mot, 'L', 2);
    Pragma Assert(Est_Pleine(Mot));
    Supprimer(Mot, 1);
    Pragma Assert(Obtenir(Mot, 1) = 'L');
    Pragma Assert(Taille(Mot) = 2);
end Test_Liste;