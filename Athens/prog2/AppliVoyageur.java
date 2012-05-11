class AppliVoyageur
{
    public static void main(String[] arg)
    {
	javax.swing.JFrame fenetre = new Voyageur();
	fenetre.pack();
	fenetre.setLocation(100, 100); 
	fenetre.setDefaultCloseOperation(javax.swing.JFrame.EXIT_ON_CLOSE); 
	fenetre.setVisible(true);
    }
}
