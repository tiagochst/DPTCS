import java.util.*;

class Descente extends Heuristique
{
    Voyageur ihmVoyageur;
    GestionnaireVoyageur gestionnaire;
    
    Descente(Voyageur ihmVoyageur)
    {
	this.ihmVoyageur = ihmVoyageur;
	gestionnaire = ihmVoyageur.gestionnaire;
    }
        
    public void run()
    {
	descendre();
    }

    void descendre()
    {
	int i = 0,j = 2;
	double delta;
	int compteur = 0;
	int max = (gestionnaire.ordre * (gestionnaire.ordre - 3))/2;
	long temps;
    
	travailler = true;
	while ((compteur < max) && travailler)
	    {	
		delta = gestionnaire.evalue(gestionnaire.tour,i,j);
		if (delta < -0.0000001) 
		{
		    
		    gestionnaire.change(gestionnaire.tour ,i, j);
		    if (ihmVoyageur.heuristique instanceof Descente)
			ihmVoyageur.afficherMeilleureLongueurDescente
			    (gestionnaire.longueur(gestionnaire.tour));
		    else
			ihmVoyageur.afficherMeilleureLongueurRecuit
			(gestionnaire.longueur(gestionnaire. tour));
		    ihmVoyageur.repeindre();
		    compteur = 0;
		}
		else compteur++;
		if (((i != 0) && (j < gestionnaire.ordre - 1))||
		    ((i == 0) && (j < gestionnaire.ordre - 2))) j++;
		else if (i != 0)
		    {
	      i++;
	      if (i == gestionnaire.ordre - 2)
		  {
		      i = 0;
		j = 2;
		  }
	      else j = i+2;
	  }
	    else 
		{
		    i = 1;
		    j = 3;
		}	    
	}
	travailler = false;
    }
}
