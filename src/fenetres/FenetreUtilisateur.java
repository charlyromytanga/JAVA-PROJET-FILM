package fenetres;

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

public class FenetreUtilisateur extends JDialog{
	
	/****/
	private static final long serialVersionUID = 4748501387232334596L;
	
	private JTextField txtlogin 		= new JTextField();
	private JTextField txtMotdepasse 	= new JTextField();
	private JTextField txttxtMotdepasse = new JTextField();
	
	
	
	public  FenetreUtilisateur(FenetrePrincipale owner) {
		super(owner, "Utilisateur", true);
		
		// le conteneur : sa récupératioon
		JPanel contentPane = (JPanel) this.getContentPane();
		
		// Le conteneur : sa création 
		JPanel dialogue = new JPanel(new GridLayout(4, 2, 10, 10));
		dialogue.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
		
		dialogue.add(new JLabel("login"));
		dialogue.add(txtlogin);
		dialogue.add(new JLabel("Mot de passe"));
		dialogue.add(txtMotdepasse);
		dialogue.add(new JLabel("Mot de passe oublie"));
		dialogue.add(txttxtMotdepasse);
		contentPane.add(dialogue, BorderLayout.CENTER);
		
		
		// Création de la barre de deux boutton connections
		JPanel BlocConnection = new JPanel(new FlowLayout(FlowLayout.RIGHT));
		
		JButton BoutonConnection = new JButton("Se connecter");
		BoutonConnection.addActionListener(this::connectionListener);
		
		JButton BoutonSuppirmer = new JButton("Annuler");
		BoutonSuppirmer.addActionListener(this::supprimerListener);
		
		BlocConnection.add(BoutonConnection);
		BlocConnection.add(BoutonSuppirmer);
		
		// Les ajouts à la fenetre dialogue
		dialogue.add(BlocConnection, BorderLayout.SOUTH);
		
		// Confid Affichage
		this.setDefaultCloseOperation(DISPOSE_ON_CLOSE);
		this.setSize(400, 300);
		this.setLocationRelativeTo(owner);
		this.setVisible(true);
		
	}
	
	// Les méthodes d'écoutes sur les deux boutons
	private void connectionListener(ActionEvent event) {
	}
	
	private void supprimerListener(ActionEvent event) {
		this.dispose();
	}
	

}







