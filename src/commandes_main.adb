with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Arbre_Genealogique;          use Arbre_Genealogique;
with Individu;       use Individu;

package body Commandes_Main is
-------------------------------------------------------------- UTILE ---------------------------------------------

    -- Afficher les choix
    procedure Afficher_Actions is
    begin
        Put_Line("----------------------------------------");
        Put_Line("Que voulez vous faire ?");
        Put_Line("1) Ajouter Quelqu'un");
        Put_Line("2) Supprimer Quelqu'un");
        Put_Line("3) Modifier Quelqu'un");
        Put_Line("4) Afficher l'arbre");
        Put_Line("5) Obtenir le nombre d'ancetre connu de quelqu'un");
        Put_Line("6) Obtenir tous les ancetres qui ont un certain nombre de parents connus");
        Put_Line("7) Obtenir l’ensemble des ancêtres situés à une certaine génération de quelqu'un");
        Put_Line("8) Quittez le programme");
        Put("Votre choix : ");
    end Afficher_Actions;

    -- convertis du texte en un nombre. en cas d'impossibilité, renvoie un nombre speciale
    function String_To_Natural(Texte : in String; Valeur_Erreur : Natural) return Natural is
    begin
        if (Texte'Length > 0) then
            begin
                return Natural'Value(Texte);
            exception
                when Constraint_Error | Data_Error => null;
            end;
        end if;
        return Valeur_Erreur;
    end String_To_Natural;

    -- modifie une personne selon les saisies de l'utilisateur
    procedure Demmander_Personne(Humain : in out T_Humain) is
        Ligne : Unbounded_String; 
        Date_Naissance : T_Date;
        Date_Mort : T_Date;
    begin
        Put_Line("Merci de saisir les different caracteristiques de la personnes (une saisie invalide seras ignoré):");

        Put("Sexe [1:Homme / 2:Femme]: ");
        case String_To_Natural(Get_Line, 0) is
            when 1 => Set_Sexe(Humain, Homme);
            when 2 => Set_Sexe(Humain, Femme);
            when others => null;
        end case;

        Put("Nom: ");
        Ligne := To_Unbounded_String(Get_Line);
        if (To_String(Ligne) /= "") then
            Set_Nom(Humain, To_String(Ligne));
        end if;

        Put("Prenom: ");
        Ligne := To_Unbounded_String(Get_Line); 
        if (To_String(Ligne) /= "") then
            Set_Prenom(Humain, To_String(Ligne));
        end if;

        Put("Date de naissance (jj/mm/aaaa): ");
        Ligne := To_Unbounded_String(Get_Line);
        Date_Naissance := Create_Date_From_Text(To_String(Ligne));
        if (Is_Date_Null(Date_Naissance) = False) then
            Set_Date_Naissance(Humain, Date_Naissance);
        end if;

        Put("Lieu de naissance: ");
        Ligne := To_Unbounded_String(Get_Line);
        if (To_String(Ligne) /= "") then
            Set_Lieu_Naissance(Humain, To_String(Ligne));
        end if;

        Put("Date de mort (jj/mm/aaaa): ");
        Ligne := To_Unbounded_String(Get_Line);
        Date_Mort := Create_Date_From_Text(To_String(Ligne));
        if (Is_Date_Null(Date_Mort) = False) then
            Set_Date_Mort(Humain, Date_Mort);
        end if;

        Put("Lieu de mort: "); 
        Ligne := To_Unbounded_String(Get_Line);
        if (To_String(Ligne) /= "") then
            Set_Lieu_Mort(Humain, To_String(Ligne));
        end if;
    end Demmander_Personne;

    -- verifie si un arbre est vide, demmande un identifiant à l'utilisateur, verifie si l'identifiant est valide
    function Demmander_Identifiant(Arbre : in T_Arbre_Genealogique; Identifiant : out T_Identifiant) return T_Arbre_Genealogique is
    begin
        Put("Veuillez saisir l'identifiant : ");
        Identifiant :=  String_To_Natural(Get_Line, 0);
        return Get_Noeud(Arbre, Identifiant);
    end Demmander_Identifiant;


--------------------------------------------------- OPERATION DE L'INTERFACE ---------------------------------------------

    -- supprime une personne et ses ancetres
    procedure Supprimer(Racine : in out T_Arbre_Genealogique; Noeud : in out T_Arbre_Genealogique) is
    begin
        Delete(Racine, Noeud);
    end Supprimer;

    -- modifie une personne de l'arbre
    procedure Modifier(Arbre : in out T_Arbre_Genealogique) is
        Humain : T_Humain;
    begin
        Humain := Get_Humain_Noeud(Arbre);
        Demmander_Personne(Humain);
        Set_Humain_Noeud(Arbre, Humain);
    end Modifier;

    -- affiche l'arbre
    procedure Afficher(Arbre : in T_Arbre_Genealogique) is
    begin
        Print_Arbre(Arbre, Inconnu, 0);
    end Afficher;

    -- Ajoute un Humain dans l'arbre
    procedure Ajouter(Racine : in out T_Arbre_Genealogique) is
        Identifiant_Fils: Natural;
        Noeud_Fils : T_Arbre_Genealogique;
        Identifiant_Creer : Natural;
        Humain : T_Humain;
        Arbre_Vide : Boolean;
        Branche : T_Branche := Inconnu;
    begin
        Arbre_Vide := Est_Vide_Arbre_Genealogique(Racine);

        if (Arbre_Vide = False) then
            Noeud_Fils := Demmander_Identifiant(Racine, Identifiant_Fils);
            if (Est_Vide_Arbre_Genealogique(Noeud_Fils)) then
                Put_Line("L'identifiant n'a pas été trouvé ! Opération annulé");
                return;
            end if;

            Put("Quel personne voulez vous ajouter [1:Pere / 2:Mere] : ");
            while (Branche = Inconnu) loop
                case String_To_Natural(Get_Line, 0) is
                    when 1 => Branche := Pere;
                    when 2 => Branche := Mere;
                    when others => Put("Saisis invalide ! Veuillez tapez '1' ou '2' : ");
                end case;
            end loop;
        end if;

        Humain := creer_Humain_Vide;
        Demmander_Personne(Humain);

        if (Arbre_Vide) then
            Creer_Arbre(Racine, Humain);
            Identifiant_Creer := Get_Identifiant_Noeud(Racine);
        else
            Add_Parent(Noeud_Fils, Humain, Branche);
            Identifiant_Creer := Get_Identifiant_Noeud(Get_Parent(Noeud_Fils, Branche));
        end if;
        Put_Line("La personne à été ajouté avec succès avec l'identifiant :"& Identifiant_Creer'Image);
    end Ajouter;

    procedure Nb_Ancetres_Connu(Arbre : in T_Arbre_Genealogique) is
        Nb_Ancetres : Natural;
    begin
        Nb_Ancetres := Get_Nb_Ancetre(Arbre);
        Put_Line(To_String_Humain(Get_Humain_Noeud(Arbre)) & "' à " & Nb_Ancetres'Image & " ancteres connus (lui inclus)");
    end Nb_Ancetres_Connu;

    procedure Ancetres_Parents_Connu(Arbre : in T_Arbre_Genealogique) is
        Liste : T_Liste_Individu;
        Nb_Parent_Connu : Natural := 3;
    begin
        Put("Saisissez le nombre de parents connus que doivent avoir les ancetres : ");
        loop
            Nb_Parent_Connu := String_To_Natural(Get_Line, 3);
            exit when (Nb_Parent_Connu <= 2 AND Nb_Parent_Connu >= 0);
            Put("Veuillez saisir un nombre entre 0 et 2 : ");
        end loop;
        Get_Groupe (Liste, Arbre, Nb_Parent_Connu);
        Put_Line("Voici ci-dessous, la liste des personnes correspondantes:");
        Print_Liste_Individu(Liste);
    end Ancetres_Parents_Connu;

    procedure Ancetres_Separes_Generation(Arbre : in T_Arbre_Genealogique) is
        Liste : T_Liste_Individu;
        Equart_Generation : Natural;
    begin
        Put("Saisissez le nombre de generation separant l'individu de ses ancetres : ");
        loop
            Equart_Generation := String_To_Natural(Get_Line, 0);
            exit when (Equart_Generation >= 0);
            Put_Line("Veuillez saisir un nombre positif : ");
        end loop;
        Get_Gen (Liste, Arbre, Equart_Generation);
        Put_Line("Voici ci-dessous, la liste des personnes correspondantes:");
        Print_Liste_Individu(Liste);
    end Ancetres_Separes_Generation;

    
------------------------------------------------------ Main -------------------------------------------------------------

    -- Lis et execute l'action saisie par l'utilisateur
    function Lire_Action(Arbre : in out T_Arbre_Genealogique) return Boolean is
        Num_Action : Natural;
        Action_Max : Natural := 8;
        Identifiant : T_Identifiant;
        Noeud : T_Arbre_Genealogique;
    begin
        Num_Action := String_To_Natural(Get_Line, Action_Max+1);
        if (Num_Action > Action_Max) then
            Put_Line("Saisie invalide ! veuillez saisir un chiffre enrtre 1 et" & Action_Max'Image);
        elsif (Num_Action = Action_Max) then
            Free_Arbre_Genealogique(Arbre);
            return False;
        elsif (Num_Action = 1) then
            Put_Line("----------------------------------------");
            Ajouter(Arbre);
        else
            Put_Line("----------------------------------------");
            if (Est_Vide_Arbre_Genealogique(Arbre)) then
                Put_Line("Opération Impossible ! L'arbre est vide !");
                return True;
            end if;
            Noeud := Demmander_Identifiant(Arbre, Identifiant);
            if (Est_Vide_Arbre_Genealogique(Noeud)) then
                Put_Line("L'identifiant n'a pas été trouvé ! Opération annulé");
            else
                case Num_Action is
                    when 2 => Supprimer(Arbre, Noeud);
                    when 3 => Modifier(Noeud);
                    when 4 => Afficher(Noeud);
                    when 5 => Nb_Ancetres_Connu(Noeud);
                    when 6 => Ancetres_Parents_Connu(Noeud);
                    when 7 => Ancetres_Separes_Generation(Noeud);
                    when others => null;
                end case;
            end if;
        end if;
        return True;
    end Lire_Action;

end Commandes_Main;