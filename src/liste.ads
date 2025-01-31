generic
   type T_Type is private;
   Capacite : Natural;
package Liste is

   type T_Liste is tagged private;

   -- @brief Initialise une liste vide.
   -- @param Liste (out) La liste qui sera initialisée.
   -- @post La liste est vide après l'initialisation (Taille = 0).
   procedure Initialiser(Liste : out T_Liste) with
   POST => Taille(Liste) = 0;

   -- @brief Ajoute un élément à la fin de la liste.
   -- @param Liste (in out) La liste à laquelle ajouter l'élément.
   -- @param Element (in) L'élément à ajouter.
   -- @pre La liste ne doit pas être pleine.
   -- @post La taille de la liste augmente de 1 et l'élément est ajouté à la fin.
   procedure Ajouter(Liste : in out T_Liste; Element : in T_Type) with
   PRE => Taille(Liste) < Capacite,
   POST =>
      Taille(Liste) = Taille(Liste)'Old + 1 AND
      Obtenir(Liste, Taille(Liste)) = Element;

   -- @brief Modifie un élément à une position donnée dans la liste.
   -- @param Liste (in out) La liste où l'élément sera modifié.
   -- @param Element (in) La nouvelle valeur de l'élément.
   -- @param Index (in) L'index de l'élément à modifier.
   -- @pre L'index doit être valide (<= Taille de la liste).
   -- @post L'élément à l'index donné est remplacé.
   procedure Modifier(Liste : in out T_Liste; Element : in T_Type; Index : in Natural) with
   PRE => Index <= Taille(Liste),
   POST =>
      Taille(Liste) = Taille(Liste)'Old AND
      Obtenir(Liste, Index) = Element;

   -- @brief Insère un élément à une position donnée dans la liste (les éléments suivants sont décalés).
   -- @param Liste (in out) La liste où l'élément sera inséré.
   -- @param Element (in) L'élément à insérer.
   -- @param Index (in) La position où insérer l'élément.
   -- @pre L'index doit être valide et la liste ne doit pas être pleine.
   -- @post L'élément est inséré et la taille de la liste augmente de 1.
   procedure Inserer(Liste : in out T_Liste; Element : in T_Type; Index : in Natural) with
   PRE => Index <= Taille(Liste) AND Taille(Liste) < Capacite,
   POST =>
      Taille(Liste) = Taille(Liste)'Old + 1 AND
      Obtenir(Liste, Index) = Element;

   -- @brief Supprime un élément à un index donné dans la liste.
   -- @param Liste (in out) La liste où l'élément sera supprimé.
   -- @param Index (in) L'index de l'élément à supprimer.
   -- @pre La liste ne doit pas être vide.
   -- @post La taille de la liste diminue de 1.
   procedure Supprimer(Liste : in out T_Liste; Index : in Natural) with
   PRE => Taille(Liste) > 0,
   POST => Taille(Liste) = Taille(Liste)'Old - 1;

   -- @brief Concatène deux listes en ajoutant les éléments de la seconde à la première.
   -- @param Liste1 (in out) La liste principale qui recevra les éléments.
   -- @param Liste2 (in) La liste dont les éléments seront ajoutés.
   -- @pre La capacité totale ne doit pas être dépassée.
   -- @post Liste1 contient ses anciens éléments plus ceux de Liste2.
   procedure Concatener(Liste1 : in out T_Liste; Liste2 : in T_Liste) with
   PRE => (Taille(Liste1) + Taille(Liste2)) <= Capacite,
   POST => Taille(Liste1) = Taille(Liste1)'Old + Taille(Liste2);

   -- @brief Retourne un élément de la liste à un index donné.
   -- @param Liste (in) La liste dont on veut obtenir un élément.
   -- @param Index (in) L'index de l'élément à récupérer.
   -- @pre L'index doit être valide.
   -- @return L'élément situé à l'index donné.
   function Obtenir(Liste : in T_Liste; Index : in Natural) return T_Type with
   PRE => Index <= Taille(Liste);

   -- @brief Vérifie si la liste est pleine.
   -- @param Liste (in) La liste à vérifier.
   -- @return True si la liste est pleine, False sinon.
   function Est_Pleine(Liste : in T_Liste) return Boolean with
   POST => Est_Pleine'Result = (Taille(Liste) >= Capacite);

   -- @brief Vérifie si la liste est vide.
   -- @param Liste (in) La liste à vérifier.
   -- @return True si la liste est vide, False sinon.
   function Est_Vide(Liste : in T_Liste) return Boolean with
   POST => Est_Vide'Result = (Taille(Liste) <= 0);

   -- @brief Renvoie la taille actuelle de la liste.
   -- @param Liste (in) La liste dont on veut connaître la taille.
   -- @return Le nombre d'éléments dans la liste.
   function Taille(Liste : in T_Liste) return Natural;

private
   -- Définition du tableau contenant les éléments
   type T_Contenu is array (1 .. Capacite) of T_Type;

   -- Définition de la structure de la liste
   type T_Liste is tagged record
      Contenu : T_Contenu; -- Tableau contenant les éléments de la liste
      Taille  : Integer := 0; -- Nombre actuel d'éléments dans la liste
   end record;

end Liste;

