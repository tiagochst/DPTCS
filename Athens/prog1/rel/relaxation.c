int relaxation(Arete ** liste, Arete ** liste0, int nb_liste, int nb_liste0)
{
  int sommet;
  int num_iter = 1, i, k;
  double valeur;
  double alpha = alpha_initial;
  double T;
  int P, D;
  int tour;
  int norme=0;
  double s;
 
  for (i = 0; i < nb_liste; i++) liste_relax[i] = liste[i];
  for (i = 0; i < nb_liste0; i++) liste0_relax[i] = liste0[i];

   // debut de la  recherche du maximum de la fonstion duale
  for (num_iter = 1; num_iter <= nb_iter; num_iter++)
    {
      /* calcul de l'arbre qui minimise la fonction de Lagrange 
	 pour les valeurs actuelles des lambdas ; 
	 la liste des aretes de cet arbre 
	 est dans un_arbre_relax (variable globale). */
      meilleur_un_arbre_relax(nb_liste, nb_liste0); 

      // valeur de la fonction duale pour les valeurs actuelles des lambdas 
      valeur = valeur_fonction_duale();

      /* Regarder si on peut couper en comparant la valeur de la 
	 fonction duale a la borne ; si oui, sortir ; 
	 on raffinera la comparaison en utilisant le fait que 
	 le probleme primal admet une solution entiere, alors que 
	 les valeurs de la fonction duale sont reelles (si la borne vaut 40 
	 et que valeur vaut 39.001, on ne peut pas faire moins que 40
	 et on peut couper). */

      // A COMPLETER
      //TCS
      if(ceil(valeur)>=borne) 
	return 1;

      /* Regarder si un_arbre_relax est un tour en utilisant 
	 le tableau global degres_arbre_relax
	 qui contient les degres des sommets de un_arbre_relax. */

      // A COMPLETER 
      // mes degrees doivent etre egal a 2
      tour=1;
      for(i=0;i<n;i++){
	if(degres_arbre_relax[i]!=2)
	  tour = 0;
      }
      /* S'il s'agit d'un tour :
	 calculer le poids de ce tour ; 
	 l'appel de poids(un_arbre_relax) renvoie ce poids.
	 S'il le faut, mettre ce poids dans borne et sauvegarder 
	 le tour correspondant par l'instruction 
	 sauvegarde_solution(un_arbre_relax).
	 Quitter la fonction relaxation en renvoyant la valeur appropriee.
	 utiliser eventuellement :
	      printf("borne = %d\n", borne);
	 pour voir ou en est la borne.
      */
      // A COMPLETER 
      if(tour){
	int varpoids = poids(un_arbre_relax);
	if(varpoids<borne){
	  borne = varpoids; /*provavelemnte errado =P*/
	  sauvegarde_solution(un_arbre_relax);
	  printf("borne = %d\n", borne);
	  return 1; 
	}
      }


      if (num_iter == nb_iter) break;
      /* Si les remarques precedentes n'ont pas permis de conclure,
	 calculer de nouvelles valeurs des lambdas (voir le cours).
	  */
      for(i=0;i<n;i++){
	norme = norme + pow(degres_arbre_relax[i]-2,2);
      }
      // comentar se gama = 2
      //norme = sqrt(norme);
 
      s = alpha*(borne-valeur)/(norme);
      for(i=0;i<n;i++){
	lambda[i]=lambda[i]+s*(degres_arbre_relax[i]-2);
      }
      // A COMPLETER

      /* Ne pas trop se preoccuper de cette boucle qui sert a eviter  une divergence 
	 de la recherche de l'optimum, 
      . */
      for (i = 0; i < n; i++) 
	{
	  if ((lambda[i] > borne) || (lambda[i] < -borne)) lambda[i] = 0;
	}

      /* Faire decroitre la valeur de alpha (on peut eventuellement laisser
	 toujours ce parametre a la valeur alpha_initial) */
	// A COMPLETER EVENTUELLEMENT


    }
  return 0;
}
