package Metier;

public abstract class Personne {
	private String nom;
	private String prenom;
	private String sexe;
	private String dateDeNaisssance;
	private String adresse;
	private String email;
	private String motDePasse;
	
	public abstract boolean authentification();
	public abstract Personne creationDecompte();
	public abstract boolean suppressionDecompte();
	public abstract String modificationDemotDePasse();
}
