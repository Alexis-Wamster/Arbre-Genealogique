with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;

package body Individu is

    ---------------------------------------------OPERATION STRING-------------------------------------------

    -- Méthode qui retourne la chaîne Entree avec la taille souhaiter (la fin est remplis par des espaces vides)
   function Gonfler_Chaine(Entree : in String; Len_Sortie : in Integer) return String is
      Len_Entree : Integer := Entree'Length;
      Sortie : String(1..Len_Sortie) := (others => ' ');
   begin
    if (Len_Sortie < Len_Entree) then
        Len_Entree := Len_Sortie;
    end if;
      Sortie(1..Len_Entree) := Entree;
      return Sortie;
   end Gonfler_Chaine;

   -- Méthode qui retourne la chaîne sans les espaces vides à la fin
   function Degonfler_Chaine(Entree : in String) return String is
      Dernier_Caractere : Integer := Entree'First;
   begin
      -- Calculer la longueur de la chaîne sans espaces à la fin
      for I in Entree'Range loop
         if Entree(I) /= ' ' then
            Dernier_Caractere := I;
         end if;
      end loop;

      -- Créer une chaîne de la longueur correcte sans les espaces
      return (Entree(Entree'First..Dernier_Caractere));
   end Degonfler_Chaine;

    ---------------------------------------------- OPERATION T_HUMAIN -------------------------------------------

   -- Ajoute ou modifie l'attribut sexe d'un humain
   procedure Ajouter_Sexe(Humain : in out T_Humain; Sexe : in T_Sexe) is
   begin
    Humain.Sexe := Sexe;
   end Ajouter_Sexe;

   -- Ajoute ou modifie le nom d'un humain
   procedure Ajouter_Nom(Humain : in out T_Humain; Nom : in String) is
   begin
    Humain.Nom := Gonfler_Chaine(Nom, Humain.Nom'length);
   end Ajouter_Nom;

   -- Ajoute ou modifie le prenom d'un humain
   procedure Ajouter_Prenom(Humain : in out T_Humain; Prenom : in String) is
   begin
    Humain.Prenom := Gonfler_Chaine(Prenom, Humain.Prenom'length);
   end Ajouter_Prenom;

   -- Ajoute ou modifie la date de naissance d'un humain
   procedure Ajouter_Date_Naissance(Humain : in out T_Humain; Date_Naissance : in T_Date) is
   begin
    Humain.Date_Naissance := Date_Naissance;
   end Ajouter_Date_Naissance;

   -- Ajoute ou modifie la date de décès d'un humain
   procedure Ajouter_Date_Mort(Humain : in out T_Humain; Date_Mort : in T_Date) is
   begin
    Humain.Date_Mort := Date_Mort;
   end Ajouter_Date_Mort;

   -- Ajoute ou modifie le lieu de naissance d'un humain
   procedure Ajouter_Lieu_Naissance(Humain : in out T_Humain; Lieu_Naissance : in String) is
   begin
    Humain.Lieu_Naissance := Gonfler_Chaine(Lieu_Naissance, Humain.Lieu_Naissance'length);
   end Ajouter_Lieu_Naissance;

   -- Ajoute ou modifie le lieu de décès d'un humain
   procedure Ajouter_Lieu_Mort(Humain : in out T_Humain; Lieu_Mort : in String) is
   begin
    Humain.Lieu_Mort := Gonfler_Chaine(Lieu_Mort, Humain.Lieu_Mort'length);
   end Ajouter_Lieu_Mort;

   -- Creer un humain sans caracteristiques
   function creer_Humain_Vide return T_Humain is
   begin
    return T_Humain'(
        Sexe           => Inconnu,
        Date_Naissance => Creer_Date_Null,
        Date_Mort      => Creer_Date_Null,
        Lieu_Naissance => (others => ' '),
        Lieu_Mort      => (others => ' '),
        Nom            => (others => ' '),
        Prenom         => (others => ' ')
    );
   end creer_Humain_Vide;

   -- Creer un humain avec les attributs nom, prénom, sexe
   function creer_Humain_Default (Nom : in String; Prenom : in String; Sexe : in T_Sexe) return T_Humain is
    Resultat : T_Humain;
   begin
    Resultat := creer_Humain_Vide;
    Ajouter_Sexe(Resultat, Sexe);
    Ajouter_Nom(Resultat, Nom);
    Ajouter_Prenom(Resultat, Prenom);
    return Resultat;
   end creer_Humain_Default;

   -- Creer un humain avec toutes les caracteristiques sauf la date et lieu de décès
   function creer_Humain_Vivant (Nom : in String; Prenom : in String; Sexe : in T_Sexe; Date_Naissance : in T_Date; Lieu_Naissance : in String) return T_Humain is
    Resultat : T_Humain;
   begin
    Resultat := creer_Humain_Default(Nom, Prenom, Sexe);
    Ajouter_Date_Naissance(Resultat, Date_Naissance);
    Ajouter_Lieu_Naissance(Resultat, Lieu_Naissance);
    return Resultat;
   end creer_Humain_Vivant;

   -- Creer un humain avec toutes les caracteristiques
   function creer_Humain_Complet (Nom : in String; Prenom : in String; Sexe : in T_Sexe; Date_Naissance : in T_Date; Lieu_Naissance : in String; Date_Mort : in T_Date; Lieu_Mort : in String) return T_Humain is
    Resultat : T_Humain;
   begin
    Resultat := creer_Humain_Vivant(Nom, Prenom, Sexe, Date_Naissance, Lieu_Naissance);
    Ajouter_Date_Mort(Resultat, Date_Mort);
    Ajouter_Lieu_Mort(Resultat, Lieu_Mort);
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
    return Degonfler_Chaine(Humain.Nom);
   end Get_Nom;

   -- Renvoie le prénom d'un humain
   function Get_Prenom (Humain : in T_Humain) return String is
   begin
    return Degonfler_Chaine(Humain.Prenom);
   end Get_Prenom;

   -- Renvoie la date de naissance d'un humain
   function Get_Date_Naissance (Humain : in T_Humain) return T_Date is
   begin
    return Humain.Date_Naissance;
   end Get_Date_Naissance;

   -- Renvoie le lieu de naissance d'un humain
   function Get_Lieu_Naissance (Humain : in T_Humain) return String is
   begin
    return Degonfler_Chaine(Humain.Lieu_Naissance);
   end Get_Lieu_Naissance;

   -- Renvoie la date de décès d'un humain
   function Get_Date_Mort (Humain : in T_Humain) return T_Date is
   begin
    return Humain.Date_Mort;
   end Get_Date_Mort;

   -- Renvoie le lieu de décès d'un humain
   function Get_Lieu_Mort (Humain : in T_Humain) return String is
   begin
    return Degonfler_Chaine(Humain.Lieu_Mort);
   end Get_Lieu_Mort;


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

   function Creer_Date_Null return T_Date is
   begin
    return T_Date'(
        Jour => 0,
        Mois => 1,
        Annee => 0
    );
   end Creer_Date_Null;

    function Is_Date_Null (Date : in T_Date) return Boolean is
    begin
        return Date.Jour <= 0;
    end Is_Date_Null;

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