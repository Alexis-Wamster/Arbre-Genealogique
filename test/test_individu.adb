with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Individu; use Individu;

procedure Test_Individu is

   -- Variables de test
   Date_Naissance : T_Date;
   Date_Mort : T_Date;
   Humain_Vide : T_Humain;
   Humain_Default : T_Humain;
   Humain_Vivant : T_Humain;
   Humain_Complet : T_Humain;
   Individu_Source : T_Individu;
   Individu_Pere : T_Individu;
   Individu_Mere : T_Individu;
   Identifiant_Pere : T_Identifiant;
   Identifiant_Mere : T_Identifiant;

begin
   -- Initialisation des dates
   Date_Naissance := Creer_Date(15, 8, 1990);
   Date_Mort := Creer_Date(20, 10, 2050);

   -- Test de la création d'un humain vide
   Humain_Vide := creer_Humain_Vide;
   Put_Line("Humain Vide: " & To_String_Humain(Humain_Vide));

   -- Test de la création d'un humain avec des attributs par défaut
   Humain_Default := creer_Humain_Default("Doe", "John", Homme);
   Put_Line("Humain Default: " & To_String_Humain(Humain_Default));

   -- Test de la création d'un humain vivant
   Humain_Vivant := creer_Humain_Vivant("Smith", "Jane", Femme, Date_Naissance, "Paris");
   Put_Line("Humain Vivant: " & To_String_Humain(Humain_Vivant));

   -- Test de la création d'un humain complet
   Humain_Complet := creer_Humain_Complet("Brown", "Alice", Femme, Date_Naissance, "Lyon", Date_Mort, "Marseille");
   Put_Line("Humain Complet: " & To_String_Humain(Humain_Complet));

   -- Test de la création d'un individu source
   Individu_Source := creer_Individu_Source(Humain_Complet);
   Put_Line("Individu Source: " & To_String_Individu(Individu_Source));

   -- Test de la création d'un individu père
   Identifiant_Pere := Creer_Identifiant_Pere(1);
   Individu_Pere := creer_Individu_Pere(Humain_Default, Identifiant_Pere);
   Put_Line("Individu Pere: " & To_String_Individu(Individu_Pere));

   -- Test de la création d'un individu mère
   Identifiant_Mere := Creer_Identifiant_Mere(1);
   Individu_Mere := creer_Individu_Mere(Humain_Vivant, Identifiant_Mere);
   Put_Line("Individu Mere: " & To_String_Individu(Individu_Mere));

   -- Test des getters
   Put_Line("Nom de l'individu source: " & Get_Nom(Get_Humain(Individu_Source)));
   Put_Line("Prenom de l'individu source: " & Get_Prenom(Get_Humain(Individu_Source)));
   Put_Line("Sexe de l'individu source: " & T_Sexe'Image(Get_Sexe(Get_Humain(Individu_Source))));
   Put_Line("Date de naissance de l'individu source: " & To_String_Date(Get_Date_Naissance(Get_Humain(Individu_Source))));
   Put_Line("Lieu de naissance de l'individu source: " & Get_Lieu_Naissance(Get_Humain(Individu_Source)));
   Put_Line("Date de mort de l'individu source: " & To_String_Date(Get_Date_Mort(Get_Humain(Individu_Source))));
   Put_Line("Lieu de mort de l'individu source: " & Get_Lieu_Mort(Get_Humain(Individu_Source)));

   -- Test des setters
   Set_Sexe(Humain_Vide, Femme);
   Set_Nom(Humain_Vide, "Taylor");
   Set_Prenom(Humain_Vide, "Emma");
   Set_Date_Naissance(Humain_Vide, Date_Naissance);
   Set_Lieu_Naissance(Humain_Vide, "Berlin");
   Set_Date_Mort(Humain_Vide, Date_Mort);
   Set_Lieu_Mort(Humain_Vide, "Hamburg");
   Put_Line("Humain Vide après modifications: " & To_String_Humain(Humain_Vide));

   -- Test de la création d'une date invalide
   declare
      Date_Invalide : T_Date := Creer_Date(31, 2, 2023); -- Doit lever une exception
   begin
      Put_Line("Date Invalide: " & To_String_Date(Date_Invalide));
   exception
      when others =>
         Put_Line("Erreur: Date invalide détectée.");
   end;

   -- Test de la fonction Is_Date_Null
   declare
      Date_Null : T_Date := Creer_Date_Null;
   begin
      if Is_Date_Null(Date_Null) then
         Put_Line("Date Null détectée.");
      else
         Put_Line("Erreur: Date Null non détectée.");
      end if;
   end;

   -- Test de la création d'une date à partir d'une chaîne de caractères
   declare
      Date_From_Text : T_Date := Create_Date_From_Text("25-12-2023");
   begin
      Put_Line("Date créée à partir de texte: " & To_String_Date(Date_From_Text));
   end;

end Test_Individu;