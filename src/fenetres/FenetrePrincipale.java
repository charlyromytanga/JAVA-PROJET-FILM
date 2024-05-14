package fenetres;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.sql.Connection;

import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JDesktopPane;
import javax.swing.JFrame;
import javax.swing.JMenuBar;
import javax.swing.JPanel;
import javax.swing.JSplitPane;
import javax.swing.UnsupportedLookAndFeelException;

import dao.LierLaBase;

public class FenetrePrincipale extends JFrame {
	

	/**Id **/
	private static final long serialVersionUID = -2641144194865045973L;
	/*Constructeur de l'interface graphique*/
	public FenetrePrincipale() throws UnsupportedLookAndFeelException {
		super("Site de vente de fims en ligne");
		this.setSize(1850, 950);
		this.setLocationRelativeTo(null);
		this.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		
		
		/* Construction de la barre de menu*/
		this.setJMenuBar(creationdelabarredeMenu());
		
		
		// Bureau : conteneur de sous fenetre
		JDesktopPane Bureau = new JDesktopPane();
		Bureau.setPreferredSize(new Dimension(1850, 950));
		
		JPanel FenetrePrincipale = (JPanel) this.getContentPane();
		FenetrePrincipale.add(Bureau, BorderLayout.NORTH);
		
		
	    ButtonGroup buttonGroup = new ButtonGroup();
	    JButton rdoGreen = new JButton("Green");
	    JButton rdoBlue = new JButton("Blue");
	    
	    

        JPanel Navigation = new JPanel( );
        // On cherche à imposer la largeur
        //Navigation.setPreferredSize( new Dimension( 100, 100 ) );
        Navigation.setLayout(new GridLayout(2, 1, 0, 0));

        Navigation.add( rdoGreen );
        buttonGroup.add( rdoGreen );

        Navigation.add( rdoBlue );
        buttonGroup.add( rdoBlue );
		
		
        //contentPane.add( createToolBar(), BorderLayout.NORTH );
        
        // --- On assemble une arborescence (à gauche) et un JDesktopPane (à droite) avec un JSplitPane ---
        JSplitPane splitPane = new JSplitPane( JSplitPane.HORIZONTAL_SPLIT, Navigation, Bureau );

        // --- On ajoute le SplitPane à la fenêtre ---
        FenetrePrincipale.add( splitPane, BorderLayout.CENTER );    

		

	}
	

	// La création de la petit méthode privée pour faire la création de la barre de Menu
	private JMenuBar creationdelabarredeMenu() throws UnsupportedLookAndFeelException {
		//Menu
		JMenuBar BarredeMenu = new JMenuBar();
		//S'identifier en tant qu'admon  + en tant qu'utilisateur + Connection au bases de données + 
		JButton BtnIdentificationAdmin = new JButton("Identification Administrateur");
		BtnIdentificationAdmin.setToolTipText("S'identifier");
		BtnIdentificationAdmin.addActionListener((e)-> {
			new FenetreAdministrateur(this);
		});
		
		JButton BtnIdentificationUtlisateur = new JButton("Identification Utilisateur");
		BtnIdentificationUtlisateur.setToolTipText("S'identifier");
		BtnIdentificationUtlisateur.addActionListener((e)-> {
			new FenetreUtilisateur(this);
		});
		
		JButton BtnConnectionauBases = new JButton("Connection aux Bases de données");
		BtnConnectionauBases.addActionListener((e) -> new LierLaBase(this));
		BtnConnectionauBases.setToolTipText("Connection aux Bases de données");
		
		
		//Ajout dans le barre de Menu
		BarredeMenu.add(BtnIdentificationAdmin);
		BarredeMenu.add(BtnIdentificationUtlisateur);
		BarredeMenu.add(BtnConnectionauBases);
		
		return BarredeMenu;
	}


	public void setConnection(Connection connection) {
		 
        }



}
