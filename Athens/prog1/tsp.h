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
     1 si elle est impos�e, 
     2 sinon c'est-�-dire si elle est libre
  */
} Arete;

// n : ordre du graphe consid�r�
extern int n;

/* 
   Les sommets d'un graphe s'appelle 0, 1, 2...
   On code le graphe trait� par une matrice n * n de structures Arete

*/
extern Arete ** graphe;


// Plus petite valeur de la longueur d'un tour rencontr�e depuis le d�but d'une m�thode
extern int borne;

/*
  _alpha_initial : sert � initialiser la variable globale alpha_initial d�finie dans relaxation.c)
  _nb_iter : sert � initialiser la variable globale nb_iter d�finie dans relaxation.c
  _borne : sert � initialiser la variable globale borne d�finie dans relaxation.c
extern void init_relax(double _alpha_initial, int _nb_iter, int _borne);
*/

// lib�re l'espace-m�moire allou� dynamiquement
extern void liberer(Arete **, Arete **, Arete **, int * );

// recopie un_arbre dans la varaible globale meilleure_solution d�finie dans tsp.c
extern void sauvegarde_solution(Arete ** un_arbre);

// retourne la somme des poids des ar�tes qui se trouvent 
extern int poids(Arete **);

/* 
liste contient toutes les ar�tes du graphe (pr�cis�ment, des pointeurs vers des structures repr�sentant ces ar�tes) sauf celles dont une extr�mit� est le sommet 0 ; les poids des ar�tes tiennent compte de la modification apport�e aux poids initiaux par la relaxation lagrangienne ; nb_liste est le nombre d'ar�tes de cette liste (ce param�tre vaudra toujours (n - 1) * (n - 2) / 2).
liste0 contient toutes les ar�tes issues du sommet 0 ; les poids des ar�tes tiennent compte de la modification apport�e aux poids initiaux par la relaxation lagrangienne ; nb_liste0 est le nombre d'ar�tes de cette liste (ce param�tre vaudra toujours (n - 1)).
*/
extern int relaxation(Arete ** liste, Arete ** liste0, int nb_liste, int nb_liste0);
