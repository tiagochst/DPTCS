import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.util.*;
import java.applet.*;

public class Voyageur extends JFrame implements ActionListener, ItemListener
{ 
    int dimension = 6;
    static final int RAYON = 6;
    int largeur  =  400;
    int hauteur  =  400;
    GestionnaireVoyageur gestionnaire;

    JComboBox choixType =  new JComboBox();
    JButton boutonInit = new JButton("initialiser");
    JButton boutonRecuit = new JButton("recuit");;
    JButton boutonDescente =  new JButton("descente");
    JButton boutonTempInit = new JButton("Temperature");
    JButton boutonStop =  new JButton("stop");
    JButton boutonQuitter =  new JButton("Quitter");

    JTextField choixDimension =  new JTextField(8);
    PanneauTrace panneauTrace;
    JLabel ordre = new JLabel("64");
    JLabel meilleureLongueurDescente = new JLabel("?");
    JLabel meilleureLongueurRecuit = new JLabel("?");
    JLabel meilleureLongueurTheo = new JLabel(" ");
    JLabel palierTrouvaille = new JLabel(" ");
    JLabel numPalier  = new JLabel(" ");

    Parametres parametres = new Parametres(this);

    int type;

    Heuristique heuristique;

  Voyageur()
    {
	JPanel p;
    
	setLayout(new BorderLayout());
	
	choixType.addItem("grille");
	choixType.addItem("par fichier");
	choixType.addItemListener(this);
	boutonInit.addActionListener(this);
	boutonRecuit.addActionListener(this);	
	boutonDescente.addActionListener(this); 
	boutonStop.addActionListener(this);
	boutonTempInit.addActionListener(this);
	boutonQuitter.addActionListener(this);
	
	p =  new JPanel();
	p.add(choixType);
	p.add(boutonInit);
	p.add(boutonRecuit);
	p.add(boutonDescente);
	p.add(boutonStop);
	p.add(boutonTempInit);
	p.add(boutonQuitter);
	add(p, BorderLayout.NORTH);

	panneauTrace = new PanneauTrace(this);
	add(panneauTrace, BorderLayout.CENTER);
	
	Box boite =  new Box(BoxLayout.Y_AXIS);

	p =  new JPanel();
	p.add(new JLabel("Dimension pour grille: "));
	p.add(choixDimension);
	choixDimension.setText("8");
	boite.add(p);

	p =  new JPanel();
	p.add(new JLabel("ordre : "));
	p.add(ordre);
	boite.add(p);

	p =  new JPanel();
	p.add(new JLabel("Meilleure longueur de la descente actuelle : "));
	p.add(meilleureLongueurDescente);
	boite.add(p);
	p =  new JPanel();
	p.add(new JLabel("Meilleure longueur du recuit actuel : "));
	p.add(meilleureLongueurRecuit);
	boite.add(p);
	p =  new JPanel();
	p.add(new JLabel("Meilleure longueur : "));
	p.add(meilleureLongueurTheo);
	boite.add(p);
	p =  new JPanel();
	p.add(new JLabel("Palier de la trouvaille: "));
	p.add(palierTrouvaille);
	boite.add(p);
	p =  new JPanel();
	p.add(new JLabel("Numero du palier : "));
	p.add(numPalier);
	boite.add(p);
	add(boite, BorderLayout.SOUTH);

	add(parametres, BorderLayout.EAST);

	gestionnaire = new GestionnaireVoyageur(this);
    } 

    public void actionPerformed(ActionEvent evt) 
    {
	Object source  =  evt.getSource(); 
	
	if (source.equals(boutonInit))
	    {
		if ((heuristique != null) && 
		    (heuristique.travailler)) return;
		if (choixType.getSelectedItem().equals("grille"))
		    gestionnaire.initialiserPourGrille();
		else 
		    {
			try
			    {
				gestionnaire.initialiserPourFichier();
			    }
			catch (Exception exc)
			    {
				exc.printStackTrace();
			    }
		    }
	    }
	else if ((source.equals(boutonDescente))  && 
		 (heuristique == null || (!heuristique.travailler)))
	    {
		try
		    {
			if (gestionnaire.tour == null) 	
			    if (choixType.getSelectedItem().equals("grille"))
				gestionnaire.initialiserPourGrille();
			    else  gestionnaire.initialiserPourFichier();
			afficherMeilleureLongueurDescente
			    (gestionnaire.longueur(gestionnaire.tour));
			heuristique = new Descente(this);
			heuristique.start();
				    
		    }
		catch (Exception exc)
		    {	
			exc.printStackTrace();
		    }
	    }
	else if ((source.equals(boutonRecuit)) && 
		 (heuristique == null || (!heuristique.travailler)))
	    {
		try
		    {
			if (gestionnaire.tour == null) 	
			    if (choixType.getSelectedItem().equals("grille"))
				gestionnaire.initialiserPourGrille();
			    else gestionnaire.initialiserPourFichier();
			double temperatureInit = 
			    Double.parseDouble(parametres.choixTemperature.getText());
			double decroissance = Double.parseDouble
			    (parametres.choixDecroissance.getText());
			int longueurPalier = 
			    Integer.parseInt(parametres.choixLongueurPalier.getText());
			int nbPaliers = 
			    Integer.parseInt(parametres.choixNbPaliers.getText());
			afficherMeilleureLongueurRecuit
			    (gestionnaire.longueur(gestionnaire.tour));
			heuristique = new Recuit(this, temperatureInit,
						 decroissance,
						 longueurPalier,
						 nbPaliers);
			heuristique.start();
		    }
		catch (Exception exc)
		    {
			exc.printStackTrace();
		    }
	    }
	else if (source.equals(boutonStop))
	    {
		if (heuristique != null) heuristique.travailler = false;
	    }
	else if (source.equals(boutonTempInit))
	    {
		Recuit.calculerTemperatureInitiale(gestionnaire);
	    }
	else if (source.equals(boutonQuitter))
	    {
		System.exit(0);
	    }
    }

    public void itemStateChanged(ItemEvent evt)
    {
	try
	    {
		if (choixType.getSelectedItem().equals("grille"))
		    {
			gestionnaire.initialiserPourGrille();
		    }
		else
		    {
			gestionnaire.initialiserPourFichier();
		    }
	    }
	catch(Exception exc)
	    {
		exc.printStackTrace();
		System.out.println("pb de fichier ?");
		choixType.setSelectedItem("grille");
	    }
    }
    
    void repeindre()
    {
	panneauTrace.repaint();
    }
    
    
    void dessinerTour(Graphics g)
    {
	Point point, point1, point2;
	int [] tour = gestionnaire.tour;
	Point [] positions = gestionnaire.positions;
	int ordre = gestionnaire.ordre;
	    
	
	g.setColor(Color.red);

	for (int i = 1;i < gestionnaire.ordre;i++)
	    {
		point1 = positions[tour[i-1]];
		point2 = positions[tour[i]];
		g.drawLine(point1.x,point1.y,point2.x,point2.y);
	    }
	if(ordre>0)
	    {
		point1 = positions[tour[ordre-1]];
		point2 = positions[tour[0]];
		g.drawLine(point1.x,point1.y,point2.x,point2.y);
	    }
	g.setColor(Color.GREEN);
	for (int i = 0; i < ordre; i++)
	    {
		point = positions[i];
		g.fillOval(point.x - RAYON/2, point.y -  RAYON/2, RAYON, RAYON);
	    }
    }
    
    void afficherMeilleureLongueurRecuit(double longueur)
    {
	java.text.DecimalFormat f = new java.text.DecimalFormat();
	f.setMaximumFractionDigits(4);
	meilleureLongueurRecuit.setText(f.format(longueur));
    }  

     void afficherMeilleureLongueurDescente(double longueur)
    {
	java.text.DecimalFormat f = new java.text.DecimalFormat();
	f.setMaximumFractionDigits(4);
	meilleureLongueurDescente.setText(f.format(longueur));
    }    

    void afficherMeilleureLongueurTheo(double longueur)
    {
	java.text.DecimalFormat f = new java.text.DecimalFormat();
	f.setMaximumFractionDigits(4);
	meilleureLongueurTheo.setText(f.format(longueur));
    }
    
    void afficherNumPalier(int numero)
    {
	numPalier.setText(Integer.toString(numero));
    }    
    
    void afficherPalierTrouvaille(int numero)
    {
	palierTrouvaille.setText(Integer.toString(numero));
    }
}


