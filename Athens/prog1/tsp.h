#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include <time.h> 
#include <sys/time.h>
#include <sys/resource.h>
#include <math.h> 


typedef struct arete 
{
  int x, y; // on aura en principe x > y
  int poids;
  double poids_relax;
  int statut; 
  /* statut vaut 0 si l'arete est exclue, 
     1 si elle est imposée, 
     2 sinon c'est-à-dire si elle est libre
  */
} Arete;

// n : ordre du graphe considéré
extern int n;

/* 
   Les sommets d'un graphe s'appelle 0, 1, 2...
   On code le graphe traité par une matrice n * n de structures Arete

*/
extern Arete ** graphe;


// Plus petite valeur de la longueur d'un tour rencontrée depuis le début d'une méthode
extern int borne;

/*
  _alpha_initial : sert à initialiser la variable globale alpha_initial définie dans relaxation.c)
  _nb_iter : sert à initialiser la variable globale nb_iter définie dans relaxation.c
  _borne : sert à initialiser la variable globale borne définie dans relaxation.c
extern void init_relax(double _alpha_initial, int _nb_iter, int _borne);
*/

// libère l'espace-mémoire alloué dynamiquement
extern void liberer(Arete **, Arete **, Arete **, int * );

// recopie un_arbre dans la varaible globale meilleure_solution définie dans tsp.c
extern void sauvegarde_solution(Arete ** un_arbre);

// retourne la somme des poids des arêtes qui se trouvent 
extern int poids(Arete **);

/* 
liste contient toutes les arêtes du graphe (précisément, des pointeurs vers des structures représentant ces arêtes) sauf celles dont une extrémité est le sommet 0 ; les poids des arêtes tiennent compte de la modification apportée aux poids initiaux par la relaxation lagrangienne ; nb_liste est le nombre d'arêtes de cette liste (ce paramètre vaudra toujours (n - 1) * (n - 2) / 2).
liste0 contient toutes les arêtes issues du sommet 0 ; les poids des arêtes tiennent compte de la modification apportée aux poids initiaux par la relaxation lagrangienne ; nb_liste0 est le nombre d'arêtes de cette liste (ce paramètre vaudra toujours (n - 1)).
*/
extern int relaxation(Arete ** liste, Arete ** liste0, int nb_liste, int nb_liste0);
