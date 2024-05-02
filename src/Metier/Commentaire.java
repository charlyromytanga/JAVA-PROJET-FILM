package Metier;
import java.util.Date;

public class Commentaire {
    private String contenu;
    private Utilisateur utilisateur;
    private Film film;
    private Date date;

    // Constructor
    public Commentaire(String contenu, Utilisateur utilisateur, Film film) {
        this.contenu = contenu;
        this.utilisateur = utilisateur;
        this.film = film;
        this.date = new Date(); // Assuming the current date/time when the comment is created
    }

    // Getters and Setters
    public String getContenu() {
        return contenu;
    }

    public void setContenu(String contenu) {
        this.contenu = contenu;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public Film getFilm() {
        return film;
    }

    public void setFilm(Film film) {
        this.film = film;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
