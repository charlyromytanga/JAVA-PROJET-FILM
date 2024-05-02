package Metier;
import java.util.List;

public class AdministrateurDuSite {
    private String identifiant;
    private String motDePasse;

    // Default constructor
    public AdministrateurDuSite() {
    }

    // Parameterized constructor
    public AdministrateurDuSite(String identifiant, String motDePasse) {
        this.identifiant = identifiant;
        this.motDePasse = motDePasse;
    }

    public void ajouterFilm(int code, String theme, List<Acteur> acteurs, List<Producteur> producteurs, int annee, String titre, String resume) {
        // Implementation for adding a film
        Film newFilm = new Film(code, theme, acteurs, producteurs, annee, titre, resume);
        // Logic to add the new film to the database or repository
        // This could involve calling a method from a service or repository class
        System.out.println("Film added successfully: " + newFilm.getTitre());
    }

    public void modifierFilm(Film film, int code, String theme, List<Acteur> acteurs, List<Producteur> producteurs, int annee, String titre, String resume) {
        // Implementation for modifying a film
        film.setCode(code);
        film.setTheme(theme);
        film.setActeurs(acteurs);
        film.setProducteurs(producteurs);
        film.setAnnee(annee);
        film.setTitre(titre);
        film.setResume(resume);
        // Logic to update the film in the database or repository
        // This could involve calling a method from a service or repository class
        System.out.println("Film modified successfully: " + film.getTitre());
    }

    public void supprimerFilm(Film film) {
        // Implementation for deleting a film
        // Logic to delete the film from the database or repository
        // This could involve calling a method from a service or repository class
        System.out.println("Film deleted successfully: " + film.getTitre());
    }

    public void activerCommentaires(Film film) {
        // Implementation for activating comments
        // Logic to activate comments for the specified film
        // This could involve setting a flag or status in the database or repository
        System.out.println("Comments activated for film: " + film.getTitre());
    }

    public void desactiverCommentaires(Film film) {
        // Implementation for deactivating comments
        // Logic to deactivate comments for the specified film
        // This could involve setting a flag or status in the database or repository
        System.out.println("Comments deactivated for film: " + film.getTitre());
    }

    public void setIdentifiant(String identifiant) {
        this.identifiant = identifiant;
    }

    public String getIdentifiant() {
        return identifiant;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    // Other methods if needed
}
