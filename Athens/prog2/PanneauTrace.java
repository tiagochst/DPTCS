import javax.swing.*;
import java.awt.*;

class PanneauTrace extends JPanel
{
    Voyageur ihmVoyageur;
    
    PanneauTrace(Voyageur _ihmVoyageur)
	{
	    ihmVoyageur = _ihmVoyageur;

	    setPreferredSize(new Dimension(ihmVoyageur.largeur, ihmVoyageur.hauteur));
	javax.swing.border.Border bord = 
	    BorderFactory.createLoweredBevelBorder();
	javax.swing.border.TitledBorder bordTitre = 
	    BorderFactory.createTitledBorder
	    (bord, "Dessin du tour courant");
	bordTitre.setTitleJustification(javax.swing.border.TitledBorder.CENTER);
	setBorder(bordTitre);
	}  
    
    public void paintComponent(Graphics g)
	{
	    super.paintComponent(g);
	    if (ihmVoyageur.gestionnaire.tour != null) 
		ihmVoyageur.dessinerTour(g);  
	}
}
