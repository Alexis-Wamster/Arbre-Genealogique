with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;       use Ada.Strings.Unbounded;

package body Individu is

    ---------------------------------------------OPERATION STRING-------------------------------------------

    -- Fonction pour extraire une sous-chaîne en tant que Natural
   function Substring_To_Natural(Texte : in String; Start_Index : in Natural; End_Index : in Natural) return Natural is
        Substring_Value : String := Texte(Start_Index .. End_Index);
        Converted_Value : Natural;
    begin
        Converted_Value := Natural'Value(Substring_Value);
        return Converted_Value;
    exception
        when others =>
            raise Constraint_Error with "Invalid numeric value: " & Substring_Value;
   end Substring_To_Natural;

    -- Trouve la position d'un caractere dans une chaine
   function Find(Texte : in String; Char : in Character) return Natural is
   begin
        for I in Texte'Range loop
            if (Texte(I) = Char) then
                return I;
            end if;
        end loop;
        return 0;
   end Find;

    ---------------------------------------------- OPERATION T_HUMAIN -------------------------------------------

   -- Ajoute ou modifie l'attribut sexe d'un humain
   procedure Set_Sexe(Humain : in out T_Humain; Sexe : in T_Sexe) is
   begin
    Humain.Sexe := Sexe;
   end Set_Sexe;

   -- Ajoute ou modifie le nom d'un humain
   procedure Set_Nom(Humain : in out T_Humain; Nom : in String) is
   begin
    Humain.Nom := To_Unbounded_String(Nom);
   end Set_Nom;

   -- Ajoute ou modifie le prenom d'un humain
   procedure Set_Prenom(Humain : in out T_Humain; Prenom : in String) is
   begin
    Humain.Prenom := To_Unbounded_String(Prenom);
   end Set_Prenom;

   -- Ajoute ou modifie la date de naissance d'un humain
   procedure Set_Date_Naissance(Humain : in out T_Humain; Date_Naissance : in T_Date) is
   begin
    Humain.Date_Naissance := Date_Naissance;
   end Set_Date_Naissance;

   -- Ajoute ou modifie la date de décès d'un humain
   procedure Set_Date_Mort(Humain : in out T_Humain; Date_Mort : in T_Date) is
   begin
    Humain.Date_Mort := Date_Mort;
   end Set_Date_Mort;

   -- Ajoute ou modifie le lieu de naissance d'un humain
   procedure Set_Lieu_Naissance(Humain : in out T_Humain; Lieu_Naissance : in String) is
   begin
    Humain.Lieu_Naissance := To_Unbounded_String(Lieu_Naissance);
   end Set_Lieu_Naissance;

   -- Ajoute ou modifie le lieu de décès d'un humain
   procedure Set_Lieu_Mort(Humain : in out T_Humain; Lieu_Mort : in String) is
   begin
    Humain.Lieu_Mort := To_Unbounded_String(Lieu_Mort);
   end Set_Lieu_Mort;

   -- Creer un humain sans caracteristiques
   function creer_Humain_Vide return T_Humain is
   begin
    return T_Humain'(
        Sexe           => Inconnu,
        Date_Naissance => Creer_Date_Null,
        Date_Mort      => Creer_Date_Null,
        Lieu_Naissance => Null_Unbounded_String,
        Lieu_Mort      => Null_Unbounded_String,
        Nom            => Null_Unbounded_String,
        Prenom         => Null_Unbounded_String
    );
   end creer_Humain_Vide;

   -- Creer un humain avec les attributs nom, prénom, sexe
   function creer_Humain_Default (Nom : in String; Prenom : in String; Sexe : in T_Sexe) return T_Humain is
    Resultat : T_Humain;
   begin
    Resultat := creer_Humain_Vide;
    Set_Sexe(Resultat, Sexe);
    Set_Nom(Resultat, Nom);
    Set_Prenom(Resultat, Prenom);
    return Resultat;
   end creer_Humain_Default;

   -- Creer un humain avec toutes les caracteristiques sauf la date et lieu de décès
   function creer_Humain_Vivant (Nom : in String; Prenom : in String; Sexe : in T_Sexe; Date_Naissance : in T_Date; Lieu_Naissance : in String) return T_Humain is
    Resultat : T_Humain;
   begin
    Resultat := creer_Humain_Default(Nom, Prenom, Sexe);
    Set_Date_Naissance(Resultat, Date_Naissance);
    Set_Lieu_Naissance(Resultat, Lieu_Naissance);
    return Resultat;
   end creer_Humain_Vivant;

   -- Creer un humain avec toutes les caracteristiques
   function creer_Humain_Complet (Nom : in String; Prenom : in String; Sexe : in T_Sexe; Date_Naissance : in T_Date; Lieu_Naissance : in String; Date_Mort : in T_Date; Lieu_Mort : in String) return T_Humain is
    Resultat : T_Humain;
   begin
    Resultat := creer_Humain_Vivant(Nom, Prenom, Sexe, Date_Naissance, Lieu_Naissance);
    Set_Date_Mort(Resultat, Date_Mort);
    Set_Lieu_Mort(Resultat, Lieu_Mort);
    return Resultat;
   end creer_Humain_Complet;

   -- Renvoie la valeur de l'attribut sexe d'un humain
   function Get_Sexe (Humain : in T_Humain) return T_Sexe is
   begin
    return Humain.Sexe;
   end Get_Sexe;

   -- Renvoie le Nom d'un humain
   function Get_Nom (Humain : in T_Humain) return String is
   begin
    return To_String(Humain.Nom);
   end Get_Nom;

   -- Renvoie le prénom d'un humain
   function Get_Prenom (Humain : in T_Humain) return String is
   begin
    return To_String(Humain.Prenom);
   end Get_Prenom;

   -- Renvoie la date de naissance d'un humain
   function Get_Date_Naissance (Humain : in T_Humain) return T_Date is
   begin
    return Humain.Date_Naissance;
   end Get_Date_Naissance;

   -- Renvoie le lieu de naissance d'un humain
   function Get_Lieu_Naissance (Humain : in T_Humain) return String is
   begin
    return To_String(Humain.Lieu_Naissance);
   end Get_Lieu_Naissance;

   -- Renvoie la date de décès d'un humain
   function Get_Date_Mort (Humain : in T_Humain) return T_Date is
   begin
    return Humain.Date_Mort;
   end Get_Date_Mort;

   -- Renvoie le lieu de décès d'un humain
   function Get_Lieu_Mort (Humain : in T_Humain) return String is
   begin
    return To_String(Humain.Lieu_Mort);
   end Get_Lieu_Mort;

    function To_String_Humain(Humain : in T_Humain) return String is
    -- Variables pour construire la chaîne finale
    Nom_Complet : Unbounded_String;
    Section_Naissance : Unbounded_String;
    Section_Naissance_Titre : Unbounded_String;
    Section_Naissance_Date : Unbounded_String;
    Section_Naissance_Lieu : Unbounded_String;
    Section_Mort : Unbounded_String;
    Section_Mort_Titre : Unbounded_String;
    Section_Mort_Date : Unbounded_String;
    Section_Mort_Lieu : Unbounded_String;
    begin

        -- Gestion du prénom et nom
        if Get_Prenom(Humain)'Length = 0 and then Get_Nom(Humain)'Length = 0 then
            Nom_Complet := Null_Unbounded_String;
        else
            Nom_Complet := To_Unbounded_String(" | " & Get_Prenom(Humain) & " " & Get_Nom(Humain));
        end if;

        -- Gestion de la section "Né(e)"
        if Is_Date_Null(Humain.Date_Naissance) and then Get_Lieu_Naissance(Humain)'Length = 0 then
            Section_Naissance := Null_Unbounded_String;
        else
            if Humain.Sexe = Femme then
                Section_Naissance_titre := To_Unbounded_String(" | Né");
            else
                Section_Naissance_titre := To_Unbounded_String(" | Née");
            end if;
            if Is_Date_Null(Humain.Date_Naissance) then
                Section_Naissance_Date := Null_Unbounded_String;
            else
                Section_Naissance_Date := To_Unbounded_String(" le " & To_String_Date(Humain.Date_Naissance));
            end if;
            if Get_Lieu_Naissance(Humain) = "" then
                Section_Naissance_Lieu := Null_Unbounded_String;
            else
                Section_Naissance_Lieu := To_Unbounded_String(" à " & Get_Lieu_Naissance(Humain));
            end if;
            Section_Naissance := Section_Naissance_titre & Section_Naissance_Date & Section_Naissance_Lieu;
        end if;

        -- Gestion de la section "Décédé(e)"
        if Is_Date_Null(Humain.Date_Mort) and then Get_Lieu_Mort(Humain)'Length = 0 then
            Section_Mort := Null_Unbounded_String;
        else
            if Humain.Sexe = Femme then
                Section_Mort_titre := To_Unbounded_String(" | Décédé");
            else
                Section_Mort_titre := To_Unbounded_String(" | Décédée");
            end if;
            if Is_Date_Null(Humain.Date_Mort) then
                Section_Mort_Date := Null_Unbounded_String;
            else
                Section_Mort_Date := To_Unbounded_String(" le " & To_String_Date(Humain.Date_Mort));
            end if;
            if Get_Lieu_Mort(Humain) = "" then
                Section_Mort_Lieu := Null_Unbounded_String;
            else
                Section_Mort_Lieu := To_Unbounded_String(" à " & Get_Lieu_Mort(Humain));
            end if;
            Section_Mort := Section_Mort_titre & Section_Mort_Date & Section_Mort_Lieu;            
        end if;

        -- Construire la chaîne finale

        return To_String(To_Unbounded_String("[ " & Humain.Sexe'Image) & Nom_Complet & Section_Naissance & Section_Mort & To_Unbounded_String(" ]"));
    end To_String_Humain;


   ---------------------------------------------- OPERATION T_IDENTIFIANT -------------------------------------------

    -- Génère un identifiant pour un père à partir de l'identifiant du fils
   function Creer_Identifiant_Pere (Id_Fils : Natural) return T_Identifiant is
    begin
        return Id_Fils*2;
    end Creer_Identifiant_Pere;


    -- Génère un identifiant pour une mère à partir de l'identifiant du fils
    function Creer_Identifiant_Mere (Id_Fils : Natural) return T_Identifiant is
    begin
        return Id_Fils*2+1;
    end Creer_Identifiant_Mere;

    function To_String_Identifiant (Identifiant : in T_Identifiant) return String is
    begin
        return Natural'Image(Identifiant);
    end To_String_Identifiant;

   ---------------------------------------------- OPERATION T_INDIVIDU -------------------------------------------
   
   -- Genere un individu à la racine (sans fils)
   function creer_Individu_Source (Humain : in T_Humain) return T_Individu is
   begin
    return T_Individu'(
        Identifiant => 1,
        Humain => Humain    
    );
   end creer_Individu_Source;

   -- Genere le pere de quelqu'un
   function creer_Individu_Pere (Humain : in T_Humain; idFils : in T_Identifiant) return T_Individu is
   begin
    return T_Individu'(
        Identifiant => Creer_Identifiant_Pere(idFils),
        Humain => Humain
    );
   end creer_Individu_Pere;

   -- Genere la mere de quelqu'un
   function creer_Individu_Mere (Humain : in T_Humain; idFils : in T_Identifiant) return T_Individu is
   begin
    return T_Individu'(
        Identifiant => Creer_Identifiant_Mere(idFils),
        Humain => Humain
    );
   end creer_Individu_Mere;

    -- Renvoie l'identifiant d'un individu
    function Get_Identifiant (Individu : in T_Individu) return T_Identifiant is
    begin
        return Individu.Identifiant;
    end Get_Identifiant;

    -- Renvoie les caracteristiques humaines d'un individu
    function Get_Humain (Individu : in T_Individu) return T_Humain is
    begin
        return Individu.Humain;
    end Get_Humain;

    procedure Set_Humain(Individu : in out T_Individu; Humain : in T_Humain) is
    begin
        Individu.Humain := Humain;
    end Set_Humain;

    function To_String_Individu (Individu : in T_Individu) return String is
    begin
        return To_String_Identifiant(Get_Identifiant(Individu)) & " " & To_String_Humain(Get_Humain(Individu));
    end To_String_Individu;

   ---------------------------------------------- OPERATION T_DATE -------------------------------------------

   -- Creer un objet de type date a partir de 3 entiers
   function Creer_Date (Jour : Natural; Mois : Natural; Annee : Natural) return T_Date is
   begin
    return T_Date'(
        Jour => Jour,
        Mois => Mois,
        Annee => Annee
    );
   end Creer_Date;

   function Create_Date_From_Text(Texte : String) return T_Date is
        Jour  : Natural;
        Mois  : Natural;
        Annee : Natural;

        Pos1  : Positive; -- Position du premier '/'
        Pos2  : Positive; -- Position du deuxième '/'

    begin
        -- Recherche des positions des caractères '/'
        Pos1 := Find(Texte, '/'); -- Trouver le premier '/'
        if Pos1 = 0 then
            raise Constraint_Error with "Invalid date format. Missing '/' separator.";
        end if;

        Pos2 := Find(Texte(Pos1 + 1..Texte'Last), '/'); -- Trouver le deuxième '/'
        if Pos2 = 0 then
            raise Constraint_Error with "Invalid date format. Missing second '/' separator.";
        end if;

        -- Vérifier que les positions trouvées permettent une extraction valide
        if Pos1 < 2 or else Pos2 - Pos1 <= 1 or else Pos2 >= Texte'Length then
            raise Constraint_Error with "Invalid date format. Unexpected positions of '/' separators.";
        end if;

        -- Extraction des parties jour, mois et année
        Jour  := Substring_To_Natural(Texte, 1, Pos1 - 1);
        Mois  := Substring_To_Natural(Texte, Pos1 + 1, Pos2 - 1);
        Annee := Substring_To_Natural(Texte, Pos2 + 1, Texte'Length);

        -- Création et validation de la date
        return Creer_Date(Jour, Mois, Annee);
        exception
        when Constraint_Error =>
            -- En cas d'erreur, retourner une date nulle
            return Creer_Date_Null;
        end Create_Date_From_Text;

    -- creer une date null
   function Creer_Date_Null return T_Date is
   begin
    return T_Date'(
        Jour => 0,
        Mois => 1,
        Annee => 0
    );
   end Creer_Date_Null;

    -- verifie si la date est valide ou non
    function Is_Date_Null (Date : in T_Date) return Boolean is
    begin
        return Date.Jour <= 0;
    end Is_Date_Null;

    -- renvoie une date sous forme de chaine de caractere "jour/mois/annee"
   function To_String_Date(Date : in T_Date) return String is
   begin
    if (Is_Date_Null(Date)) then
        return "";
    else
        return Natural'Image(Date.Jour)(2 .. Natural'Image(Date.Jour)'Last) & "/"
     & Natural'Image(Date.Mois)(2 .. Natural'Image(Date.Mois)'Last) & "/"
     & Natural'Image(Date.Annee)(2 .. Natural'Image(Date.Annee)'Last);
    end if;
   end To_String_Date;

end Individu;