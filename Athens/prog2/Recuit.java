import java.util.*;

class Recuit extends Heuristique
{
    double temperatureInit;
    int longueurPalier;
    double decroissance; 
    int nbPaliers; 

    Voyageur ihmVoyageur;
    Random aleat = new Random();
    GestionnaireVoyageur gestionnaire;
 
    static void calculerTemperatureInitiale(GestionnaireVoyageur gestionnaire)
    {
	double taux = 0.3;
	int i, j, nb = 0;
	double delta, somme = 0, temperature;
	int [] tour;
	Random aleat = new Random();
	int ordre;

	tour = gestionnaire.tour;
	if (tour == null) return;
	ordre = tour.length;
	// La variable taux contiendra le taux d'acceptations initiales souhaite
	taux = Double.parseDouble(gestionnaire.ihmVoyageur.parametres.choixTaux.getText());

	/* 
	   Il s'agit de calculer une temperature correspndant au taux 
	   initial d'acceptation notee ici taux.
	   L'attribut ordre contient l'ordre du graphe.
	   L'attribut tour contient la solution initiale. 
	   L'appel a : gestionnaire.evalue(tour, i, j) renvoie la variation de la 
	   longueur du tour si on fait un 2-opt a partir des sommets 
	   en position d'indices i et j dans le tour. 
	*/

	// COMPLETER
	int aux;
	for(aux=0;aux<100*ordre;aux++){
	    
	    i = (int)(Math.random() * tour.length);
	    j = (int)(Math.random() * tour.length);
	    if(Math.abs(j-i)>2){
		delta = gestionnaire.evalue(tour, i, j);
		if(delta>0){
		    somme=somme+delta;
		    nb++;
		}
	    }
	}

	temperature = - (somme/nb)/Math.log(taux);
	// L'instruction ci-dessous devra etre supprimee
	//temperature = gestionnaire.longueur(tour) / ordre;

	// Ci-dessous, affichage de la temperature initiale calculee 
	// qui sera automatiquement utilisee par le recuit.
	java.text.DecimalFormat f = new java.text.DecimalFormat();
	//	f.setMaximumFractionDigits(2);
	double d;// = Double.parseDouble(f.format(temperature));
	d = (int)(temperature * 1000) / 1000.0;
	gestionnaire.ihmVoyageur.parametres.choixTemperature.setText
	    (Double.toString(d)); 
    }
    
    Recuit(Voyageur ihmVoyageur,
	   double temperatureInit,
	   double decroissance,
	   int longueurPalier,
	   int nbPaliers) 
    {
	this.temperatureInit = temperatureInit;
	this.longueurPalier = longueurPalier;
	this.nbPaliers = nbPaliers;
	this.decroissance = decroissance;
	this.ihmVoyageur = ihmVoyageur;
	gestionnaire =  ihmVoyageur.gestionnaire;
    }

    // Deroulement du recuit
    public void run()
    {
	int i,j;
	double delta;
	int numIter = 0;
	int numPalier = 1;
	double temperature;
	boolean changer;
	double tirage;
	int longueurMin;
	int[] meilleurTour = new int[gestionnaire.ordre];
	double meilleureLongueur, longueurCourante;
	
	travailler = true;
	longueurCourante = gestionnaire.longueur(gestionnaire.tour);
	meilleureLongueur = longueurCourante;
	System.arraycopy(gestionnaire.tour, 0, 
			 meilleurTour, 0, gestionnaire.ordre);
	temperature = temperatureInit;
	while ((numPalier <= nbPaliers) && travailler)
	    {
		ihmVoyageur.afficherNumPalier(numPalier);
		numIter = 0;
		while ((numIter < longueurPalier) && travailler)
		    {
			changer = false;
			i = Math.abs(aleat.nextInt()) % gestionnaire.ordre;
			j = Math.abs(aleat.nextInt()) % gestionnaire.ordre;

			/* On evalue la transformation 2-opt a partir des indices i et j */
			delta = gestionnaire.evalue(gestionnaire.tour, i, j);
			if (delta < -0.000001) changer = true;
			else{
			    if(aleat.nextDouble()<= Math.exp(-delta/temperature)) 
				changer = true;
			}
			/* 
			   A COMPLETER
			   L'attribut aleat de type Random peut permettre de tirer 
			   aleatoirement un double compris entre 0 et 1 
			   en utilisant la methode d'instance nextDouble
			*/
			
			if (changer)
			    {
				gestionnaire.change(gestionnaire.tour, i, j);
				ihmVoyageur.repeindre();
				longueurCourante += delta;
				if (longueurCourante <= meilleureLongueur - 0.000001)
				    {
					meilleureLongueur = gestionnaire.longueur(meilleurTour);
					ihmVoyageur.afficherMeilleureLongueurRecuit
					    (meilleureLongueur);
					ihmVoyageur.afficherPalierTrouvaille(numPalier);
					System.arraycopy(gestionnaire.tour, 0, 
							 meilleurTour,0, gestionnaire.ordre);
				    }
			    }
			numIter++;
		    }

		// Une ligne a ajouter ici
		temperature = temperature*decroissance;
		numPalier++;
	    }
	gestionnaire.tour = meilleurTour;
	meilleureLongueur = gestionnaire.longueur(gestionnaire.tour);
	(new Descente(ihmVoyageur)).descendre();
	if (gestionnaire.longueur(gestionnaire.tour) < meilleureLongueur) 
	    ihmVoyageur.afficherPalierTrouvaille(numPalier);
	travailler = false;
  }
}
