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
   procedure Ajouter_Sexe(Humain : in out T_Humain; Sexe : in T_Sexe);

   -- Ajoute ou modifie le nom d'un humain
   procedure Ajouter_Nom(Humain : in out T_Humain; Nom : in String);

   -- Ajoute ou modifie le prenom d'un humain
   procedure Ajouter_Prenom(Humain : in out T_Humain; Prenom : in String);

   -- Ajoute ou modifie la date de naissance d'un humain
   procedure Ajouter_Date_Naissance(Humain : in out T_Humain; Date_Naissance : in T_Date);

   -- Ajoute ou modifie la date de décès d'un humain
   procedure Ajouter_Date_Mort(Humain : in out T_Humain; Date_Mort : in T_Date);

   -- Ajoute ou modifie le lieu de naissance d'un humain
   procedure Ajouter_Lieu_Naissance(Humain : in out T_Humain; Lieu_Naissance : in String);

   -- Ajoute ou modifie le lieu de décès d'un humain
   procedure Ajouter_Lieu_Mort(Humain : in out T_Humain; Lieu_Mort : in String);

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


   ---------------------------------------------- OPERATION T_IDENTIFIANT -------------------------------------------

   -- Génère un identifiant pour un père à partir d'une graine (l'identifiant du fils)
   function Creer_Identifiant_Pere (Id_Fils : Natural) return T_Identifiant with
   Pre => Id_Fils > 0;

   -- Génère un identifiant pour une mère à partir d'une graine (l'identifiant du fils)
   function Creer_Identifiant_Mere (Id_Fils : Natural) return T_Identifiant with
   Pre => Id_Fils > 0;

   ---------------------------------------------- OPERATION T_INDIVIDU -------------------------------------------

   
   -- Genere un individu à la racine (sans fils)
   function creer_Individu_Source (Humain : in out T_Humain) return T_Individu;

   -- Genere le pere de quelqu'un
   function creer_Individu_Pere (Humain : in out T_Humain; idFils : in out T_Identifiant) return T_Individu;

   -- Genere la mere de quelqu'un
   function creer_Individu_Mere (Humain : in out T_Humain; idFils : in out T_Identifiant) return T_Individu;

   -- Renvoie l'identifiant d'un individu
   function Get_Identifiant (Individu : in T_Individu) return T_Identifiant;

   -- Renvoie les caracteristiques humaines d'un individu
   function Get_Humain (Individu : in T_Individu) return T_Humain;

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


   ---------------------------------------------- DEFINITION TYPE -------------------------------------------

   private

   -- Définition du type T_Date
   type T_Date is record
      Jour  : Natural := 1;
      Mois  : Natural := 1;
      Annee : Natural := 0;
   end record;

   -- Définition du type T_Humain
   type T_Humain is record
      Sexe           : T_Sexe := Inconnu;
      Date_Naissance : T_Date := Creer_Date(1, 1, 0);
      Date_Mort      : T_Date := Creer_Date(1, 1, 0);
      Lieu_Naissance : String(1..100) := (others => ' ');
      Lieu_Mort      : String(1..100) := (others => ' ');
      Nom            : String(1..30) := (others => ' ');
      Prenom         : String(1..30) := (others => ' ');
   end record;

   -- Définition du type T_Individu
   type T_Individu is record
      Identifiant : T_Identifiant;
      Humain      : T_Humain;
   end record;


end Individu;