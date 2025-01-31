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

   --- @param Humain L'humain dont on modifie le sexe
   --- @param Sexe Le nouveau sexe de l'humain
   --- @brief Modifie le sexe de l'humain donné
   procedure Set_Sexe(Humain : in out T_Humain; Sexe : in T_Sexe) with
      POST => Get_Sexe(Humain) = Sexe;

   --- @param Humain L'humain dont on modifie le nom
   --- @param Nom Le nouveau nom de l'humain
   --- @brief Modifie le nom de l'humain donné
   procedure Set_Nom(Humain : in out T_Humain; Nom : in String) with
      POST => Get_Nom(Humain) = Nom;

   --- @param Humain L'humain dont on modifie le prénom
   --- @param Prenom Le nouveau prénom de l'humain
   --- @brief Modifie le prénom de l'humain donné
   procedure Set_Prenom(Humain : in out T_Humain; Prenom : in String) with
      POST => Get_Prenom(Humain) = Prenom;

   --- @param Humain L'humain dont on modifie la date de naissance
   --- @param Date_Naissance La nouvelle date de naissance de l'humain
   --- @brief Modifie la date de naissance de l'humain donné
   procedure Set_Date_Naissance(Humain : in out T_Humain; Date_Naissance : in T_Date) with
      POST => Get_Date_Naissance(Humain) = Date_Naissance;

   --- @param Humain L'humain dont on modifie la date de décès
   --- @param Date_Mort La nouvelle date de décès de l'humain
   --- @brief Modifie la date de décès de l'humain donné
   procedure Set_Date_Mort(Humain : in out T_Humain; Date_Mort : in T_Date) with
      POST => Get_Date_Mort(Humain) = Date_Mort;

   --- @param Humain L'humain dont on modifie le lieu de naissance
   --- @param Lieu_Naissance Le nouveau lieu de naissance
   --- @brief Modifie le lieu de naissance de l'humain donné
   procedure Set_Lieu_Naissance(Humain : in out T_Humain; Lieu_Naissance : in String) with
      POST => Get_Lieu_Naissance(Humain) = Lieu_Naissance;

   --- @param Humain L'humain dont on modifie le lieu de décès
   --- @param Lieu_Mort Le nouveau lieu de décès
   --- @brief Modifie le lieu de décès de l'humain donné
   procedure Set_Lieu_Mort(Humain : in out T_Humain; Lieu_Mort : in String) with
      POST => Get_Lieu_Mort(Humain) = Lieu_Mort;

   ----- @brief Retourne un humain vide avec des valeurs par défaut
   --- @return Un humain avec des attributs non définis
   function creer_Humain_Vide return T_Humain with
      POST =>
         Get_Sexe(creer_Humain_Vide'Result) = Inconnu AND
         Get_Nom(creer_Humain_Vide'Result) = "" AND
         Get_Prenom(creer_Humain_Vide'Result) = "" AND
         Get_Lieu_Mort(creer_Humain_Vide'Result) = "" AND
         Get_Lieu_Naissance(creer_Humain_Vide'Result) = "" AND
         Is_Date_Null(Get_Date_Mort(creer_Humain_Vide'Result)) AND
         Is_Date_Null(Get_Date_Naissance(creer_Humain_Vide'Result));

   --- @brief Renvoie la valeur de l'attribut sexe d'un humain.
   --- @param Humain L'humain dont on récupère le sexe.
   --- @return Le sexe de l'humain.
   function Get_Sexe (Humain : in T_Humain) return T_Sexe;

   --- @brief Renvoie le Nom d'un humain.
   --- @param Humain L'humain dont on récupère le nom.
   --- @return Le nom de l'humain.
   function Get_Nom (Humain : in T_Humain) return String;

   --- @brief Renvoie le prénom d'un humain.
   --- @param Humain L'humain dont on récupère le prénom.
   --- @return Le prénom de l'humain.
   function Get_Prenom (Humain : in T_Humain) return String;

   --- @brief Renvoie la date de naissance d'un humain.
   --- @param Humain L'humain dont on récupère la date de naissance.
   --- @return La date de naissance de l'humain.
   function Get_Date_Naissance (Humain : in T_Humain) return T_Date;

   --- @brief Renvoie le lieu de naissance d'un humain.
   --- @param Humain L'humain dont on récupère le lieu de naissance.
   --- @return Le lieu de naissance de l'humain.
   function Get_Lieu_Naissance (Humain : in T_Humain) return String;

   --- @brief Renvoie la date de décès d'un humain.
   --- @param Humain L'humain dont on récupère la date de décès.
   --- @return La date de décès de l'humain.
   function Get_Date_Mort (Humain : in T_Humain) return T_Date;

   --- @brief Renvoie le lieu de décès d'un humain.
   --- @param Humain L'humain dont on récupère le lieu de décès.
   --- @return Le lieu de décès de l'humain.
   function Get_Lieu_Mort (Humain : in T_Humain) return String;

   --- @brief Convertit un humain en une chaîne de caractères.
   --- @param Humain L'humain à convertir.
   --- @return Chaîne de caractères représentant l'humain.
   function To_String_Humain(Humain : in T_Humain) return String;

   --- @brief Vérifie si deux humains sont identiques.
   --- @param Humain1 Premier humain à comparer.
   --- @param Humain2 Deuxième humain à comparer.
   --- @return Vrai si les humains sont identiques, faux sinon.
   function Est_Egal_Humain(Humain1 : in T_Humain; Humain2 : in T_Humain) return Boolean;


---------------------------------------------- OPERATION T_IDENTIFIANT -------------------------------------------

--- @brief Génère un identifiant unique pour le père
--- @param Id_Fils Identifiant du fils
--- @return Identifiant unique du père
--- @pre L'identifiant du fils doit être strictement positif
--- @post L'identifiant du père est au moins le double de celui du fils
function Creer_Identifiant_Pere (Id_Fils : Natural) return T_Identifiant with
   PRE => Id_Fils > 0,
   POST => Creer_Identifiant_Pere'Result >= 2*Id_Fils;

--- @brief Génère un identifiant unique pour la mère
--- @param Id_Fils Identifiant du fils
--- @return Identifiant unique de la mère
--- @pre L'identifiant du fils doit être strictement positif
--- @post L'identifiant de la mère est au moins le double de celui du fils
function Creer_Identifiant_Mere (Id_Fils : Natural) return T_Identifiant with
   PRE => Id_Fils > 0,
   POST => Creer_Identifiant_Mere'Result >= 2*Id_Fils;

--- @brief Convertit un identifiant en une chaîne de caractères
--- @param Identifiant L'identifiant à convertir
--- @return Chaîne de caractères représentant l'identifiant
function To_String_Identifiant(Identifiant : in T_Identifiant) return String;

---------------------------------------------- OPERATION T_INDIVIDU -------------------------------------------
   
--- @brief Modifie les caractéristiques humaines d'un individu
--- @param Individu L'individu à modifier
--- @param Humain Nouvelles caractéristiques humaines
procedure Set_Humain(Individu : in out T_Individu; Humain : in T_Humain) with
   POST => Get_Humain(Individu) = Humain;
   
--- @brief Crée un individu qui seras la racine
--- @param Humain Caractéristiques humaines
--- @return Un individu avec un identifiant de base
--- @post L'individu a un identifiant égal à 1 et les caractéristiques humaines données
function creer_Individu_Source (Humain : in T_Humain) return T_Individu with
   POST =>
      Get_Identifiant(creer_Individu_Source'Result) = 1 AND
      Get_Humain(creer_Individu_Source'Result) = Humain;

--- @brief Crée un individu père avec un identifiant différent de son fils
--- @param Humain Caractéristiques humaines
--- @param idFils Identifiant du fils
--- @return Un individu représentant le père
--- @post L'individu père a des caractéristiques humaines spécifiées et un identifiant différent de son fils
function creer_Individu_Pere (Humain : in T_Humain; idFils : in T_Identifiant) return T_Individu with
      POST =>
         Get_Humain(creer_Individu_Pere'Result) = Humain AND
         Get_Identifiant(creer_Individu_Pere'Result) /= idFils;

--- @brief Crée un individu mère
--- @param Humain Caractéristiques humaines
--- @param idFils Identifiant du fils
--- @return Un individu représentant la mère
--- @post L'individu mère a les caractéristiques humaines spécifiées
function creer_Individu_Mere (Humain : in T_Humain; idFils : in T_Identifiant) return T_Individu with
      POST => Get_Humain(creer_Individu_Mere'Result) = Humain;

--- @brief Obtient l'identifiant d'un individu
--- @param Individu L'individu dont on veut l'identifiant
--- @return Identifiant de l'individu
function Get_Identifiant (Individu : in T_Individu) return T_Identifiant;

--- @brief Obtient les caractéristiques humaines d'un individu
--- @param Individu L'individu concerné
--- @return Caractéristiques humaines de l'individu
function Get_Humain (Individu : in T_Individu) return T_Humain;

--- @brief Convertit un individu en une chaîne de caractères
--- @param Individu L'individu à convertir
--- @return Chaîne de caractères représentant l'individu
function To_String_Individu(Individu : in T_Individu) return String;

---------------------------------------------- OPERATION T_DATE -------------------------------------------

   --- @brief Creer un objet de type date a partir de 3 entiers
   --- @return La date creer
   --- @post La date doit avoir des chiffres valides
   function Creer_Date (Jour : Natural; Mois : Natural; Annee : Natural) return T_Date with
   Pre =>
   ((Mois = 2 AND 
      (Jour <= 28 OR
      (Jour <= 29 AND Annee mod 4 = 0 AND (Annee mod 100 /= 0 OR Annee mod 400 = 0)))
   ) OR
   ((Mois = 4 OR Mois = 6 OR Mois = 9 OR Mois = 11) AND Jour <= 30) OR
   ((Mois = 1 OR Mois = 3 OR Mois = 5 OR Mois = 7 OR Mois = 8 OR Mois = 10 OR Mois = 12) AND Jour <= 31));
   
   --- @brief Creer une date par default (invalide)
   --- @return La date creer
   function Creer_Date_Null return T_Date;

   --- @brief Verifie si une date est valide
   --- @param Date La date à vérifier
   --- @return Vrai si un des chiffres à une valeur impossible, faux sinon
   function Is_Date_Null (Date : in T_Date) return Boolean;

   --- @brief Creer une date a partir d'une chaine de caractere
   function Create_Date_From_Text(Texte : String) return T_Date;

   --- @brief Renvoie une date sous forme de String
   --- @param Date La date à convertir
   --- @return Chaîne de caractères représentant la date
   function To_String_Date(Date : in T_Date) return String;

   --- @brief Verifie si deux dates sont identique
   --- @param Date1 La première date à comparer
   --- @param Date1 La deuxième date à comparer
   --- @return Vrai si les dates sont identiques, faux sinon
   function Est_Egal_Date(Date1 : in T_Date; Date2 : in T_Date) return Boolean;

---------------------------------------------- PRIVE -------------------------------------------

   private

   --- @brief Renvoie l'entier qui se trouve dans une chaine de caractere
   --- @param Texte La chaine qui contient un nombre
   --- @param Start_Index L'index du premier caractere qui compose le nombre dans la chaine
   --- @param End_Index L'index du dernier caractere qui compose le nombre dans la chaine
   --- @return L'entier qui se trouve dans la chaine, sinon une exception (Constraint_Error)
   function Substring_To_Natural(Texte : in String; Start_Index : in Natural; End_Index : in Natural) return Natural with
   PRE => Start_Index >= Texte'First AND End_Index <= Texte'Last;

   --- @brief Retrouve la position d'un caractere dans une chaine de caractere
   --- @param Texte Chaine qui contient le caractere
   --- @param Char Caractère à trouver dans la chaine
   --- @return L'index de la première occurence, sinon 0
   function Find(Texte : in String; Char : in Character) return Natural with
   POST => Find'Result <= Texte'Last;

---------------------------------------------- DEFINITION TYPE -------------------------------------------

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