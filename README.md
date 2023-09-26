# compinou (Compilateur)

*Kevin Garnier* ; 
*Tania Mahandry*

## Gestion des variables globales
- Les variables globales sont stockées dans une table qui sera alors analysée lorsqu'on fait appel à ``read`` ou qu'une variable est utilisée à l'intérieur des instructions du programme.

## Gestion des variables locales
- Nous avons choisi d'utiliser un module ``StrMap`` qui n'est rien d'autre qu'un ``Map(String)`` pour stocker nos variables locales.

Pour garder l'encapsulation, à chaque entrée dans un nouveau bloc d'instructions (ex: une fonction) la map des variables locales est initialisée à vide.

Chaque apparition d'une variable implique la vérification de son existence :
* Soit dans les variables locales du bloc actuel
* Soit dans les variables globales
* Sinon le programme renvoie une exception


## Gestion de la pile
- Nous utilisons une référence ``sp_aux`` qui sert à sauvegarder l'avancé de --$sp-- quand on utilise la pile pour stocker des résultats temporaires.


## Gestion des fonctions
- Nous avons rajouté le token ``JEnd f `` := `j endf`, qui nous évite d'entrer dans la déclaration de la fonction avant son appel.

## Conventions
- Le résulat de compilation de chaque expression est stocké dans --$v0-- 
- L'Argument des fonction est stocké dans --$a0--


