generic
   type T_Type is private;
   Capacite : Natural;
package Liste is

   type T_Liste is tagged private;


   -- Initialiser une liste
   procedure Initialiser(Liste : out T_Liste);

   -- Ajouter un élément à la liste
   procedure Ajouter(Liste : in out T_Liste; Element : in T_Type) with
   Pre => Liste.Taille < Capacite;

   -- Modifie un élément à la liste
   procedure Modifier(Liste : in out T_Liste; Element : in T_Type; Index : in Natural) with
   Pre => Index <= Liste.Taille;

   -- Insere un élément à la liste à l'index voulus (le reste est décalé a droite)
   procedure Inserer(Liste : in out T_Liste; Element : in T_Type; Index : in Natural) with
   Pre => Index <= Liste.Taille AND Liste.Taille < Capacite;

   -- Supprimer le dernier élément de la liste
   procedure Supprimer(Liste : in out T_Liste; Index : in Natural) with
   Pre => Liste.Taille > 0;

   -- ajoute les element de la liste2 à la fin de la liste 1
   procedure Concatener(Liste1 : in out T_Liste; Liste2 : in T_Liste) with
   Pre => (Liste1.Taille + Liste2.Taille) <= Capacite;

   -- Obtenir un élément de la liste par index
   function Obtenir(Liste : in T_Liste; Index : in Natural) return T_Type with
   Pre => Index <= Liste.Taille;

   -- Vérifier si la liste est pleine
   function Est_Pleine(Liste : in T_Liste) return Boolean;

   -- Vérifier si la liste est vide
   function Est_Vide(Liste : in T_Liste) return Boolean;

   -- Renvoie le nombre d'élements de la liste
   function Taille(Liste : in T_Liste) return Natural;



   private
    -- Définition du tableau de contenu
    type T_Contenu is array (1 .. Capacite) of T_Type;

    -- Définition du type T_Liste
   type T_Liste is tagged record
      Contenu : T_Contenu;
      Taille  : Integer := 0;
   end record;

end Liste;
