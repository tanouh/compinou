# compinou

## Gestion des variables globales
- Les variables globales sont stockées dans une table qui sera alors analysée lorsqu'on fait appel à ``read`` ou qu'une variable est utilisée à l'intérieur des instructions du programme

## Gestion des variables locales
- Nous avons choisi d'utiliser un module ``StrMap`` qui n'est rien d'autre qu'un ``Map(String)`` pour stocker nos variables locales

Pour garder l'encapsulation, à chaque entrée dans un nouveau bloc d'instructions (ex: une fonction) la map des variables locales est initialisée à vide.

## Gestion de la pile
- Nous utilisons une référence ``sp_aux`` qui sert à sauvegarder l'avance de SP quand on utilise la pile pour stocker des résultats temporaires

## Conventions
- Le résulat de compilation de chaque expression est stocké dans --$v0-- 
