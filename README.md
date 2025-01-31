# Arbre Généalogique

## Description
Ce projet permet de gérer un arbre généalogique en utilisant le langage Ada. Il permet d'ajouter, modifier, supprimer des personnes dans un arbre, et d'afficher des informations sur ces individus tout en conservant la structure de leur ascendance.

## Structure du projet
Le projet est divisé en plusieurs blocs de fichiers :

- **Liste** : avec `liste.adb`, `liste.ads` et  `test_liste.ads`. Permet la gestion des listes utiliser dans le programme. C'est un module générique. dont ont peut choisir le type et la capacité de la liste

- **Individus** : avec `individu.adb`, `individu.ads` et  `test_individu.adb`. Permet la gestion des individu utiliser dans le programme. On peut ainsi creer des individus avec : identifiant, nom, prenom, date et lieu de naissance et date et lieu de décès. 

- **Arbre_Binaire** : avec `arbre_binaire.adb`, `arbre_binaire.ads`, `test_arbre_binaire.adb`. Permet la gestion d'un arbre binaire. création de l'arbre, ajout modification et suppression d'un noeud.

- **Arbre_Genealogique** : avec `arbre_genealogique.adb`, `arbre_genealogique.ads`, `test_arbre_genealogique.adb`. Permet la gestion d'un arbre généalogique autrement dit un arbre binaire d'individus. ce programme s'appuie donc sur le module Individu, Arbre_Binaire et Liste. directement dans le terminal. Il permet  la creation, la modification la suppression et l'affichage de noeuds de l'arbre mais aussi des methodes de recherches dans l'arbre.

- **Main** : avec `main.adb`, `commandes_main.adb`, `commandes_main.ads`. Permet la gestion de l'arbre généalogique directement dans le terminal. Ce module sert d'interface homme machine. il lit les instructions sur le terminal appelle les methodes correspondante d'Arbre_Genealogique et affiche les resultat dans le terminal.

## Fonctionnalités
L'application permet d'effectuer les actions suivantes :

1. Ajouter une personne à l'arbre généalogique.
2. Supprimer un individu et ses ancêtres.
3. Modifier les informations d'une personne.
4. Afficher l'arbre généalogique.
5. Obtenir le nombre d'ancêtres connus pour un individu.
6. Trouver les ancêtres ayant un certain nombre de parents connus.
7. Lister les ancêtres situés à une certaine génération d'un individu.
8. Quitter le programme.

## Dépendances
Le projet utilise les modules suivants :

### Dépendance avec l'extérieur
- `Ada.Text_IO` pour l'affichage et la saisie utilisateur.
- `Ada.Integer_Text_IO` pour la gestion des entrées numériques.
- `Ada.Strings.Unbounded` pour la gestion de chaînes de texte dynamiques.

### Dépendance interne
- `Arbre_Genealogique` dépend de `Arbre_Binaire`, `Individu` et `Liste`.
- `Commandes_Main` dépend de `Arbre_Genealogique`, `Individu` et `Liste`.
- `Main` dépend de `Commandes_Main` et `Arbre_Genealogique`.

## Compilation et Exécution
### Compilation
Utilisez GNAT pour compiler le projet :
```sh
$ gnatmake main.adb
```

### Exécution
Lancez l'exécutable généré :
```sh
$ ./main
```

## Améliorations possibles

### Dans le code actuel
- Ameliorer les fonctions print, compare et To_String pour les rendres génériques.
- Amelioration des identifiants et des listes pour qu'il y ait une capacité illimité.

### Pour aller plus loin
- Sauvegarde et chargement de l'arbre généalogique dans un fichier.
- Interface graphique pour une meilleure visualisation.
- Ajout de nouvelle connexion comme la fraterie pour rendre l'arbre plus complet
- Ajout de statistiques et autres operations sur l'arbre (âge moyen, nombre moyen d'enfants, etc.).

## Auteur
Alexis Wamster et Ken ... en janvier 2025 dans le cadre d'un projet scolaire à l'ENSEEIHT.