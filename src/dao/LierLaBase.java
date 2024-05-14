package dao;

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;

import fenetres.FenetrePrincipale;

public class LierLaBase extends JDialog {
	
	
	/****/
	private static final long serialVersionUID = -3780080795482036505L;

	
	private static final String CONF_FILENAME = "conf.properties";
    private Properties props = new Properties();
    private JTextField txtDriverClassName = new JTextField();
    private JTextField txtUrl = new JTextField();
    private JTextField txtLogin = new JTextField();
    private JTextField txtPassword = new JTextField();
    
    public LierLaBase(FenetrePrincipale owner) {
    	
    	super(owner, "Connectio à une basse de donnée");
    	//Chargement de la config
        try ( FileInputStream fis = new FileInputStream( CONF_FILENAME ) ) {
            props.load( fis );
            txtDriverClassName.setText( props.getProperty( "jdbc.driver.class" ) );
            txtUrl.setText( props.getProperty( "jdbc.url" ) );
            txtLogin.setText( props.getProperty( "jdbc.login" ) );
            txtPassword.setText( props.getProperty( "jdbc.password" ) );
        } catch ( Exception exception ) {
            exception.printStackTrace();
        }
        
        // Conteneur 
        // --- Récupération du content pane ---
        JPanel contentPane = (JPanel) getContentPane();
        
        // --- Création de la partie centrale ---
        JPanel pnlConnectionInformations = new JPanel( new GridLayout( 5, 2, 10, 10 ) );
        pnlConnectionInformations.setBorder( BorderFactory.createEmptyBorder( 10, 10, 10, 10 ) );
        
        pnlConnectionInformations.add( new JLabel( "Driver class name: " ) ); // com.mysql.cj.jdbc.Driver
        pnlConnectionInformations.add( txtDriverClassName );
        pnlConnectionInformations.add( new JLabel( "URL: " ) ); //  "jdbc:mysql://localhost:3306/DAO?serverTimezone=UTC"
        pnlConnectionInformations.add( txtUrl );
        pnlConnectionInformations.add( new JLabel( "Login: " ) ); // "charly"
        pnlConnectionInformations.add( txtLogin );
        pnlConnectionInformations.add( new JLabel( "Password: " ) ); // "charly"
        pnlConnectionInformations.add( txtPassword );
        contentPane.add( pnlConnectionInformations, BorderLayout.CENTER );
        
        // --- Création de barre de boutons du bas ---
        JPanel pnlButtons = new JPanel( new FlowLayout( FlowLayout.RIGHT ) );
        JButton btnOk = new JButton( "Connect" );
        btnOk.addActionListener( this::connectListener );
        pnlButtons.add( btnOk );
        JButton btnCancel = new JButton( "Cancel" );
        btnCancel.addActionListener( this::cancelListener );
        pnlButtons.add( btnCancel );
        contentPane.add( pnlButtons, BorderLayout.SOUTH );
        
        // --- Affiche la fenêtre ---
        this.setDefaultCloseOperation( DISPOSE_ON_CLOSE );
        this.setSize( 400, 270 );
        this.setLocationRelativeTo( owner );
        this.setVisible( true );
        
    	
	}
    
    
    // Les méthodes 


    private void connectListener( ActionEvent event ) {
        // --- Sauvegarde des données éditées ---
        try ( FileOutputStream fos = new FileOutputStream( CONF_FILENAME ) ) {
            props.setProperty( "jdbc.driver.class", txtDriverClassName.getText() );
            props.setProperty( "jdbc.url", txtUrl.getText() );
            props.setProperty( "jdbc.login", txtLogin.getText() );
            props.setProperty( "jdbc.password", txtPassword.getText() );
            props.store( fos, "JDBC connection data" );

            Class.forName( txtDriverClassName.getText() );
            String url = txtUrl.getText();
            String login = txtLogin.getText();
            String password = txtPassword.getText();
            Connection connection = DriverManager.getConnection( url, login, password );
            ((FenetrePrincipale) this.getOwner()).setConnection( connection );
            
            this.dispose();
        } catch ( Exception exception ) {
            exception.printStackTrace();
            JOptionPane.showMessageDialog( this, "Cannot establish connection!" );
        }
    }

    private void cancelListener( ActionEvent event ) {
        this.dispose();
    }
    
	
	
	

}









