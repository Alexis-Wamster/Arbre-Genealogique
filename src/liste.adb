package body Liste is

   -- Initialiser une liste
   procedure Initialiser(Liste : out T_Liste) is
   begin
      Liste.Taille := 0;
   end Initialiser;

   -- Ajouter un élément à la liste
   procedure Ajouter(Liste : in out T_Liste; Element : in T_Type) is
   begin
        Liste.Taille := Liste.Taille + 1;
        Liste.Contenu(Liste.Taille) := Element;
   end Ajouter;

   -- Supprimer le dernier élément de la liste
   procedure Supprimer(Liste : in out T_Liste; Index : in Natural) is
   begin
        for I in Index..(Liste.Taille-1) loop
            Liste.Contenu(I) := Liste.Contenu(I+1);
        end loop;
        Liste.Taille := Liste.Taille - 1;
   end Supprimer;

    -- Modifie un élément à la liste
   procedure Modifier(Liste : in out T_Liste; Element : in T_Type; Index : in Natural) is
   begin
        Liste.Contenu(Index) := Element;
   end Modifier;

   -- Insere un élément à la liste
   procedure Inserer(Liste : in out T_Liste; Element : in T_Type; Index : in Natural) is
   begin
        Liste.Taille := Liste.Taille + 1;
        for I in reverse (Index+1)..Liste.Taille loop
            Liste.Contenu(I) := Liste.Contenu(I-1);
        end loop;
        Liste.Contenu(Index) := Element;
   end Inserer;

   -- Concatene 2 listes
   procedure Concatener(Liste1 : in out T_Liste; Liste2 : in T_Liste) is
     Taille_Liste1 : Natural;
     Taille_Liste2 : Natural;
   begin
        Taille_Liste1 := Taille(Liste1);
        Taille_Liste2 := Taille(Liste2);
        Liste1.Taille := Taille_Liste1 + Taille_Liste2;
        for I in 1..Taille_Liste2 loop
            Liste1.Contenu(Taille_Liste1+I) := Liste2.Contenu(I);
        end loop;
   end Concatener;

   -- Obtenir un élément de la liste par index
   function Obtenir(Liste : T_Liste; Index : in Natural) return T_Type is
   begin
        return Liste.Contenu(Index);
   end Obtenir;

   -- Vérifier si la liste est pleine
   function Est_Pleine(Liste : in T_Liste) return Boolean is
   begin
      return Liste.Taille = Capacite;
   end Est_Pleine;

   -- Vérifier si la liste est vide
   function Est_Vide(Liste : in T_Liste) return Boolean is
   begin
      return Liste.Taille = 0;
   end Est_Vide;

   -- Renvoie le nombre d'élements de la liste
   function Taille(Liste : in T_Liste) return Natural is
   begin
          return Liste.Taille;
   end Taille;

end Liste;
