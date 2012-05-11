import java.util.*;
import java.awt.*;
import java.io.*;

public class GestionnaireVoyageur
{
    double[][] matrice;
    Voyageur ihmVoyageur;
    Random aleat = new Random();

    // Positions des points dans la fenetre graphique, en pixels
    Point[] positions;
    int intervalle;

    int dimension;
    int [] tour;
    int ordre = -1;

    java.io.File fichier;

  GestionnaireVoyageur(Voyageur ihmVoyageur)
  {
      this.ihmVoyageur = ihmVoyageur;
  }

  double distance(Point a, Point b)
  {
    int horizontal = b.x-a.x;
    int vertical = b.y-a.y;

    return Math.sqrt(horizontal*horizontal+vertical*vertical);
  }

  void change(int[] tour, int i, int j)
  {
    int tampon;

    if (Math.abs(j - i) < 2) return;
    if (i>j) 
      {
	tampon = i;
	i = j;
	j = tampon;
      }
    for (int k = 0;k<(j-i)/2;k++)
      {
	tampon = tour[i+1+k];
	tour[i+1+k] = tour[j-k];
	tour[j-k] = tampon;
      }
  }

  double evalue(int[] tour, int i, int j)
  {
    double delta;

    if (Math.abs(j - i) < 2) return 0;
    delta = matrice[tour[i]][tour[j]]+
      matrice[tour[(i + 1) % ordre]][tour[(j + 1) % ordre]]-
      matrice[tour[i]][tour[(i + 1)% ordre]]-
      matrice[tour[j]][tour[(j + 1) % ordre]];
    return delta;
  }

  void construitMatrice()
  {
    Point origine,extremite;

    matrice = new double[ordre][ordre];
    double dist;
    
    for(int i = 0;i < ordre-1;i++)
      {
	origine = positions[i];
	matrice[i][i] = Double.MAX_VALUE;
	for(int j = i+1;j<ordre;j++)
	  {
	    extremite = positions[j];
	    dist = distance(origine,extremite);
	    matrice[i][j] = matrice[j][i] = dist;
	  }
      }
  }

  public void stop()
  {
      ihmVoyageur.heuristique.travailler  =  false;
  }

  double longueur(int[] tour)
    {
      double laLongueur = 0;

      for (int i = 0; i < ordre-1; i++)
	laLongueur += matrice[tour[i]][tour[i+1]];
      laLongueur += matrice[tour[0]][tour[ordre-1]];
      return laLongueur;
    }

  int[] solutionInitiale()
  {
    int tampon,j;
    int tour[] = new int[ordre];

    for (int i = 0;i<ordre;i++) tour[i] = i;
   for (int i = 1;i<ordre;i++)
     {
       tampon = tour[ordre-i];
       j = Math.abs(aleat.nextInt()) % (ordre-i+1);
       tour[ordre-i] = tour[j];
       tour[j] = tampon;
     }
    return tour;
  }

    void initialiserPourGrille()
    {
	int nouvelOrdre;

	fichier = null;
	dimension = Integer.parseInt(ihmVoyageur.choixDimension.getText());
	nouvelOrdre = dimension * dimension;
	if (nouvelOrdre != ordre) changementDimensionGrille();
	
	initialiser();
    } 

    void changementDimensionGrille()
    {
	double longueurTheo;
	int nouvelOrdre;

	dimension = Integer.parseInt(ihmVoyageur.choixDimension.getText());
	ordre = ordre = dimension * dimension;
	intervalle = (ihmVoyageur.largeur)/(dimension + 1);
	positions = new Point[ordre];
	for (int i = 0; i < dimension;i++)
	    for (int j = 0;j < dimension;j++)
		positions[i * dimension + j] = 
		    (new Point((i + 1) * intervalle,(j + 1) * intervalle + 10));
	construitMatrice();
	for(int i = 0; i < ordre; i++)
	    for(int j = 0; j < ordre; j++)
	    {
		matrice[i][j] /= intervalle;
	    }
	longueurTheo = ordre;
	if (dimension % 2 == 1) longueurTheo +=  Math.sqrt(2) - 1;
	ihmVoyageur.afficherMeilleureLongueurTheo(longueurTheo);
	ihmVoyageur.ordre.setText(Integer.toString(ordre));
    }

    void initialiserPourFichier() throws Exception
    {
	if (fichier == null) choisirFichier();
	initialiser();
    }

    void choisirFichier() throws Exception
    {
	int largeurVraie = ihmVoyageur.largeur - 30;
	javax.swing.JFileChooser fenetre = 
	    new javax.swing.JFileChooser(new java.io.File("."));
	BufferedReader lecteur;
	double x, y;
	
	String nom = null;
	if (fenetre.showOpenDialog(null) == 
	    javax.swing.JFileChooser.APPROVE_OPTION)
	    {
		fichier = fenetre.getSelectedFile();
		nom = fichier.getPath();
	    }
	
	lecteur = new BufferedReader(new FileReader(nom));
	String ligne;
	java.util.StringTokenizer st;
	ordre = Integer.parseInt(lecteur.readLine());
	positions = new Point[ordre];
	for (int i = 0; i < ordre; i++)
	    {
		st = new StringTokenizer(lecteur.readLine());
		x = Double.parseDouble(st.nextToken());
		y = Double.parseDouble(st.nextToken());
		positions[i] = 
		    new Point(20 + (int)(largeurVraie * x), 
			      20 + (int)(largeurVraie * y));
	    }	
	construitMatrice();
	for(int i = 0; i < ordre; i++)
	    for(int j = 0; j < ordre; j++)
		{
		    matrice[i][j] /= largeurVraie;
		}
	initialiser();
	ihmVoyageur.ordre.setText(Integer.toString(ordre));
	ihmVoyageur.meilleureLongueurDescente.setText("?");
	ihmVoyageur.meilleureLongueurRecuit.setText("?");
	double longueurTheorique;
	ligne = lecteur.readLine();
	if (ligne != null)
	    longueurTheorique = Double.parseDouble(ligne);
	else longueurTheorique = 0.76 * Math.sqrt(ordre);
	ihmVoyageur.afficherMeilleureLongueurTheo(longueurTheorique);	
    }

    void initialiser()
    {
	double longueurTour;
	tour = solutionInitiale();

	longueurTour = longueur(tour);
	ihmVoyageur.afficherPalierTrouvaille(0);
	ihmVoyageur.afficherNumPalier(0);
	ihmVoyageur.repeindre();
    }
}
