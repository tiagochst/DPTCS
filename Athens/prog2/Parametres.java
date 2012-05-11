import java.awt.event.*;
import javax.swing.*;

class Parametres extends Box
{
    JTextField choixTemperature = new JTextField(10);
    JTextField choixDecroissance = new JTextField(10);
    JTextField choixLongueurPalier = new JTextField(10);
    JTextField choixNbPaliers = new JTextField(10);
    JTextField choixTaux = new JTextField(10);

    Parametres(Voyageur voyageur)
    {
	super(BoxLayout.Y_AXIS);
	JPanel panneau;	    
	
	panneau = new JPanel();
	panneau.add(new JLabel("temperature initiale : "));
	panneau.add(choixTemperature);
	choixTemperature.setText("10");
	add(panneau);
	
	panneau = new JPanel();
	panneau.add(new JLabel("taux de decroissance : "));
	panneau.add(choixDecroissance);
	choixDecroissance.setText("0.925");
	add(panneau);
	
	panneau = new JPanel();
	panneau.add(new JLabel("longueur d'un palier : "));
	panneau.add(choixLongueurPalier);
	choixLongueurPalier.setText("10000");
	add(panneau);
	
	panneau = new JPanel();
	panneau.add(new JLabel("nombre de paliers : "));
	panneau.add(choixNbPaliers);
	choixNbPaliers.setText("100");
	add(panneau);

	panneau = new JPanel();
	panneau.add(new JLabel("taux d'acceptation initial : "));
	panneau.add(choixTaux);
	choixTaux.setText("0.1");
	add(panneau);

	javax.swing.border.Border bord = 
	    BorderFactory.createLoweredBevelBorder();
	javax.swing.border.TitledBorder bordTitre = 
	    BorderFactory.createTitledBorder
	    (bord, "Parametres du recuit");
	bordTitre.setTitleJustification(javax.swing.border.TitledBorder.CENTER);
	setBorder(bordTitre);
    }
}
