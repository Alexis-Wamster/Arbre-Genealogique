generic
   type T_Type is private;
   Capacite : Natural;
package Liste is

   type T_Liste is tagged private;


   -- Initialiser une liste
   procedure Initialiser(Liste : out T_Liste) with
   POST => Taille(Liste) = 0;

   -- Ajouter un élément à la liste
   procedure Ajouter(Liste : in out T_Liste; Element : in T_Type) with
   PRE => Taille(Liste) < Capacite,
   POST =>
      Taille(Liste) = Taille(Liste)'Old + 1 AND
      Obtenir(Liste, Taille(Liste)) = Element;


   -- Modifie un élément à la liste
   procedure Modifier(Liste : in out T_Liste; Element : in T_Type; Index : in Natural) with
   PRE => Index <= Taille(Liste),
   POST =>
      Taille(Liste) = Taille(Liste)'Old AND
      Obtenir(Liste, Index) = Element;

   -- Insere un élément à la liste à l'index voulus (le reste est décalé a droite)
   procedure Inserer(Liste : in out T_Liste; Element : in T_Type; Index : in Natural) with
   PRE => Index <= Taille(Liste) AND Taille(Liste) < Capacite,
   POST =>
      Taille(Liste) = Taille(Liste)'Old + 1 AND
      Obtenir(Liste, Index) = Element;

   -- Supprimer le dernier élément de la liste
   procedure Supprimer(Liste : in out T_Liste; Index : in Natural) with
   PRE => Taille(Liste) > 0,
   POST => Taille(Liste) = Taille(Liste)'Old - 1;

   -- ajoute les element de la liste2 à la fin de la liste 1
   procedure Concatener(Liste1 : in out T_Liste; Liste2 : in T_Liste) with
   PRE => (Taille(Liste1) + Taille(Liste2)) <= Capacite,
   POST => Taille(Liste1) = Taille(Liste1)'Old + Taille(Liste2);

   -- Obtenir un élément de la liste par index
   function Obtenir(Liste : in T_Liste; Index : in Natural) return T_Type with
   PRE => Index <= Taille(Liste);

   -- Vérifier si la liste est pleine
   function Est_Pleine(Liste : in T_Liste) return Boolean with
   POST => Est_Pleine'Result = (Taille(Liste) >= Capacite);

   -- Vérifier si la liste est vide
   function Est_Vide(Liste : in T_Liste) return Boolean with
   POST => Est_Vide'Result = (Taille(Liste) <= 0);

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
