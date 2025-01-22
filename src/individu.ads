with Ada.Strings.Unbounded;       use Ada.Strings.Unbounded;

package Individu is

   -- Déclaration des types publique
   type T_Date is private;
   type T_Humain is private;
   type T_Individu is private;

   -- Déclaration des types privée
   subtype T_Identifiant is Natural;
   type T_Sexe is (Homme, Femme, Inconnu);

---------------------------------------------- OPERATION T_HUMAIN -------------------------------------------

   -- Ajoute ou modifie l'attribut sexe d'un humain
   procedure Set_Sexe(Humain : in out T_Humain; Sexe : in T_Sexe) with
      POST => Get_Sexe(Humain) = Sexe;

   -- Ajoute ou modifie le nom d'un humain
   procedure Set_Nom(Humain : in out T_Humain; Nom : in String) with
      POST => Get_Nom(Humain) = Nom;

   -- Ajoute ou modifie le prenom d'un humain
   procedure Set_Prenom(Humain : in out T_Humain; Prenom : in String) with
      POST => Get_Prenom(Humain) = Prenom;

   -- Ajoute ou modifie la date de naissance d'un humain
   procedure Set_Date_Naissance(Humain : in out T_Humain; Date_Naissance : in T_Date) with
      POST => Get_Date_Naissance(Humain) = Date_Naissance;

   -- Ajoute ou modifie la date de décès d'un humain
   procedure Set_Date_Mort(Humain : in out T_Humain; Date_Mort : in T_Date) with
      POST => Get_Date_Mort(Humain) = Date_Mort;

   -- Ajoute ou modifie le lieu de naissance d'un humain
   procedure Set_Lieu_Naissance(Humain : in out T_Humain; Lieu_Naissance : in String) with
      POST => Get_Lieu_Naissance(Humain) = Lieu_Naissance;

   -- Ajoute ou modifie le lieu de décès d'un humain
   procedure Set_Lieu_Mort(Humain : in out T_Humain; Lieu_Mort : in String) with
      POST => Get_Lieu_Mort(Humain) = Lieu_Mort;

   -- Creer un humain sans caracteristiques
   function creer_Humain_Vide return T_Humain;

   -- Creer un humain avec les attributs nom, prénom, sexe
   function creer_Humain_Default (Nom : in String; Prenom : in String; Sexe : in T_Sexe) return T_Humain;

   -- Creer un humain avec toutes les caracteristiques sauf la date et lieu de décès
   function creer_Humain_Vivant (Nom : in String; Prenom : in String; Sexe : in T_Sexe; Date_Naissance : in T_Date; Lieu_Naissance : in String) return T_Humain;

   -- Creer un humain avec toutes les caracteristiques
   function creer_Humain_Complet (Nom : in String; Prenom : in String; Sexe : in T_Sexe; Date_Naissance : in T_Date; Lieu_Naissance : in String; Date_Mort : in T_Date; Lieu_Mort : in String) return T_Humain;

   -- Renvoie la valeur de l'attribut sexe d'un humain
   function Get_Sexe (Humain : in T_Humain) return T_Sexe;

   -- Renvoie le Nom d'un humain
   function Get_Nom (Humain : in T_Humain) return String;

   -- Renvoie le prénom d'un humain
   function Get_Prenom (Humain : in T_Humain) return String;

   -- Renvoie la date de naissance d'un humain
   function Get_Date_Naissance (Humain : in T_Humain) return T_Date;

   -- Renvoie le lieu de naissance d'un humain
   function Get_Lieu_Naissance (Humain : in T_Humain) return String;

   -- Renvoie la date de décès d'un humain
   function Get_Date_Mort (Humain : in T_Humain) return T_Date;

   -- Renvoie le lieu de décès d'un humain
   function Get_Lieu_Mort (Humain : in T_Humain) return String;

   -- Renvoie un Humain sous forme de chaine de caractere
   function To_String_Humain(Humain : in T_Humain) return String;

   -- Verifie si deux humains sont identique
   function Est_Egal_Humain(Humain1 : in T_Humain; Humain2 : in T_Humain) return Boolean;


---------------------------------------------- OPERATION T_IDENTIFIANT -------------------------------------------

   -- Génère un identifiant pour un père à partir d'une graine (l'identifiant du fils)
   function Creer_Identifiant_Pere (Id_Fils : Natural) return T_Identifiant with
   PRE => Id_Fils > 0,
   POST => Creer_Identifiant_Pere'Result >= 2*Id_Fils;

   -- Génère un identifiant pour une mère à partir d'une graine (l'identifiant du fils)
   function Creer_Identifiant_Mere (Id_Fils : Natural) return T_Identifiant with
   PRE => Id_Fils > 0,
   POST => Creer_Identifiant_Mere'Result >= 2*Id_Fils;

   -- Renvoie l'identifiant sous forme de String
   function To_String_Identifiant(Identifiant : in T_Identifiant) return String;

---------------------------------------------- OPERATION T_INDIVIDU -------------------------------------------
   
   -- Remplace l'humain qui se trouve dans l'objet Individu
   procedure Set_Humain(Individu : in out T_Individu; Humain : in T_Humain) with
   POST => Get_Humain(Individu) = Humain;
   
   -- Genere un individu à la racine (sans fils)
   function creer_Individu_Source (Humain : in T_Humain) return T_Individu with
   POST =>
      Get_Identifiant(creer_Individu_Source'Result) = 1 AND
      Get_Humain(creer_Individu_Source'Result) = Humain;

   -- Genere le pere de quelqu'un
   function creer_Individu_Pere (Humain : in T_Humain; idFils : in T_Identifiant) return T_Individu with
      POST =>
         Get_Humain(creer_Individu_Pere'Result) = Humain AND
         Get_Identifiant(creer_Individu_Pere'Result) /= idFils;

   -- Genere la mere de quelqu'un
   function creer_Individu_Mere (Humain : in T_Humain; idFils : in T_Identifiant) return T_Individu with
      POST => Get_Humain(creer_Individu_Mere'Result) = Humain;

   -- Renvoie l'identifiant d'un individu
   function Get_Identifiant (Individu : in T_Individu) return T_Identifiant;

   -- Renvoie les caracteristiques humaines d'un individu
   function Get_Humain (Individu : in T_Individu) return T_Humain;

   -- Renvoie un Individu sous forme de String
   function To_String_Individu(Individu : in T_Individu) return String;

---------------------------------------------- OPERATION T_DATE -------------------------------------------

   -- Creer un objet de type date a partir de 3 entiers
   function Creer_Date (Jour : Natural; Mois : Natural; Annee : Natural) return T_Date with
   Pre =>
   (Mois = 2 AND 
      (Jour <= 28 OR
      (Jour <= 29 AND Annee mod 4 = 0 AND (Annee mod 100 /= 0 OR Annee mod 400 = 0)))
   ) OR
   ((Mois = 4 OR Mois = 6 OR Mois = 9 OR Mois = 11) AND Jour <= 30) OR
   ((Mois = 1 OR Mois = 3 OR Mois = 5 OR Mois = 7 OR Mois = 8 OR Mois = 10 OR Mois = 12) AND Jour <= 31);
   
   -- Creer une date par default (invalide)
   function Creer_Date_Null return T_Date;

   -- Verifie si une date est valide
   function Is_Date_Null (Date : in T_Date) return Boolean;

   -- Creer une date a partir d'une chaine de caractere
   function Create_Date_From_Text(Texte : String) return T_Date;

   -- Renvoie une date sous forme de String
   function To_String_Date(Date : in T_Date) return String;

   -- Verifie si deux dates sont identique
   function Est_Egal_Date(Date1 : in T_Date; Date2 : in T_Date) return Boolean;

   ---------------------------------------------- DEFINITION TYPE -------------------------------------------

   private

   -- Renvoie l'entier qui se trouve au milieu d'une chaine de caractere
   function Substring_To_Natural(Texte : in String; Start_Index : in Natural; End_Index : in Natural) return Natural with
   PRE => Start_Index >= Texte'First AND End_Index <= Texte'Last;

   -- Retrouve la position d'un caractere dans une chaine de caractere
   function Find(Texte : in String; Char : in Character) return Natural with
   POST => Find'Result <= Texte'Last;

   -- Définition du type T_Date
   type T_Date is record
      Jour  : Natural := 1;
      Mois  : Natural := 1;
      Annee : Natural := 0;
   end record;

   -- Définition du type T_Humain
   type T_Humain is record
      Sexe           : T_Sexe := Inconnu;
      Date_Naissance : T_Date := Creer_Date(0, 1, 0);
      Date_Mort      : T_Date := Creer_Date(0, 1, 0);
      Lieu_Naissance : Unbounded_String := Null_Unbounded_String;
      Lieu_Mort      : Unbounded_String := Null_Unbounded_String;
      Nom            : Unbounded_String := Null_Unbounded_String;
      Prenom         : Unbounded_String := Null_Unbounded_String;
   end record;

   -- Définition du type T_Individu
   type T_Individu is record
      Identifiant : T_Identifiant;
      Humain      : T_Humain;
   end record;


end Individu;