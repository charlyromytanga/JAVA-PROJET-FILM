package application;

import javax.swing.JFrame;

import javax.swing.UIManager;
import javax.swing.plaf.nimbus.NimbusLookAndFeel;

import fenetres.FenetrePrincipale;



public class Main extends JFrame {
	
	
   
	
	
	/****/
	private static final long serialVersionUID = 6935330060313793382L;
	
	
	public static void main(String[] args) throws Exception{
		//Fenetre Principale
		UIManager.setLookAndFeel(new NimbusLookAndFeel());
		FenetrePrincipale Fenetreprincipale = new FenetrePrincipale();
		Fenetreprincipale.setVisible(true);
		
		// Les Ecouteurs pour changer IHM
		// 1- Administrateur
		/*UIManager.setLookAndFeel(new NimbusLookAndFeel());
		FenetreAdministrateur FenetreAdministrateur = new FenetreAdministrateur();
		FenetreAdministrateur.setVisible(true);*/
		
		
		
		// 2- Utilisateur
		/*UIManager.setLookAndFeel(new NimbusLookAndFeel());
		FenetreUtilisateur FenetreUtilisateur = new FenetreUtilisateur();
		FenetreUtilisateur.setVisible(true);
		System.out.println("Bonjour");*/

		
	}

}


