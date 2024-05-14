package metier;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Utilisateur {
    private String email;
    private String motDePasse;
    private String nom;
    private String prenom;
    private String sexe;
    private Date dateDeNaissance;
    private String adresse;
    private String phraseSecrete;
    private List<Commentaire> commentaires;
    private List<Achat> achats;
    private boolean estAbonne;
    private List<Film> filmsAchetes;

    // Constructor
    public Utilisateur(String email, String motDePasse, String nom, String prenom, String sexe, Date dateDeNaissance, String adresse, String phraseSecrete) {
        this.email = email;
        this.motDePasse = motDePasse;
        this.nom = nom;
        this.prenom = prenom;
        this.sexe = sexe;
        this.dateDeNaissance = dateDeNaissance;
        this.adresse = adresse;
        this.phraseSecrete = phraseSecrete;
        this.commentaires = new ArrayList<>();
        this.achats = new ArrayList<>();
        this.estAbonne = false;
    }

    // Getters and setters
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getSexe() {
        return sexe;
    }

    public void setSexe(String sexe) {
        this.sexe = sexe;
    }

    public Date getDateDeNaissance() {
        return dateDeNaissance;
    }

    public void setDateDeNaissance(Date dateDeNaissance) {
        this.dateDeNaissance = dateDeNaissance;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getPhraseSecrete() {
        return phraseSecrete;
    }

    public void setPhraseSecrete(String phraseSecrete) {
        this.phraseSecrete = phraseSecrete;
    }

    // Other methods
    public void commenterFilm(Film film, String contenu) {
        Commentaire commentaire = new Commentaire(contenu, this, film);
        commentaires.add(commentaire);
        film.getCommentaires().add(commentaire);
    }

    public void modifierCommentaire(Commentaire commentaire, String nouveauContenu) {
        commentaire.setContenu(nouveauContenu);
    }

    public void supprimerCommentaire(Commentaire commentaire) {
        commentaires.remove(commentaire);
        commentaire.getFilm().getCommentaires().remove(commentaire);
    }

    public List<Commentaire> visualiserCommentaires(Film film) {
        List<Commentaire> commentsForFilm = new ArrayList<>();
        for (Commentaire commentaire : commentaires) {
            if (commentaire.getFilm().equals(film)) {
                commentsForFilm.add(commentaire);
            }
        }
        return commentsForFilm;
    }

    public List<Commentaire> filtrerCommentaires(Film film, FiltreCommentaire typeFiltre) {
        List<Commentaire> filteredComments = new ArrayList<>();
        for (Commentaire commentaire : commentaires) {
            if (commentaire.getFilm().equals(film)) {
                if (typeFiltre.isPlusRecent() && commentaire.getDate().after(new Date())) {
                    filteredComments.add(commentaire);
                }
                if (typeFiltre.isPositifs() && commentaire.getContenu().toLowerCase().contains("positive")) {
                    filteredComments.add(commentaire);
                }
                if (typeFiltre.isNegatifs() && commentaire.getContenu().toLowerCase().contains("negative")) {
                    filteredComments.add(commentaire);
                }
                // Add additional filters here if needed
            }
        }
        return filteredComments;
    }
    
    public List<Achat> consulterHistoriqueAchats() {
        return achats;
    }

    public List<Achat> filtrerHistoriqueAchats(CritereDeFiltreHistorique critereFiltre) {
        List<Achat> filteredAchats = new ArrayList<>();
        for (Achat achat : achats) {
            if (achat.getStatut().equals(critereFiltre.getStatutAchat()) && achat.getNombreFilms() >= critereFiltre.getNombreDeFilms() && achat.getDateAchat().after(critereFiltre.getDateAchat())) {
                filteredAchats.add(achat);
            }
        }
        return filteredAchats;
    }

    public void sAbonner() {
        estAbonne = true;
    }

    public void seDesabonner() {
        estAbonne = false;
    }

    public List<Film> rechercherParAuteur(String nomAuteur) {
        List<Film> filmsByAuthor = new ArrayList<>();
        for (Film film : filmsAchetes) {
            for (Acteur acteur : film.getActeurs()) {
                if (acteur.getNom().equalsIgnoreCase(nomAuteur)) {
                    filmsByAuthor.add(film);
                    break;
                }
            }
        }
        return filmsByAuthor;
    }
}
