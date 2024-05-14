package metier;
import java.util.List;

public class Film {
    private int code;
    private String theme;
    private List<Acteur> acteurs;
    private List<Producteur> producteurs;
    private int annee;
    private String titre;
    private String resume;
    private List<Note> notes;
    private List<Commentaire> commentaires;

    public Film(int code, String theme, List<Acteur> acteurs, List<Producteur> producteurs, int annee, String titre, String resume) {
        this.code = code;
        this.theme = theme;
        this.acteurs = acteurs;
        this.producteurs = producteurs;
        this.annee = annee;
        this.titre = titre;
        this.resume = resume;
    }

    // Getters and setters
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public List<Acteur> getActeurs() {
        return acteurs;
    }

    public void setActeurs(List<Acteur> acteurs) {
        this.acteurs = acteurs;
    }

    public List<Producteur> getProducteurs() {
        return producteurs;
    }

    public void setProducteurs(List<Producteur> producteurs) {
        this.producteurs = producteurs;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getResume() {
        return resume;
    }

    public void setResume(String resume) {
        this.resume = resume;
    }

    public List<Note> getNotes() {
        return notes;
    }

    public void setNotes(List<Note> notes) {
        this.notes = notes;
    }

    public List<Commentaire> getCommentaires() {
        return commentaires;
    }

    public void setCommentaires(List<Commentaire> commentaires) {
        this.commentaires = commentaires;
    }

    public double moyenneNote(List<Note> listeNote) {
        if (listeNote == null || listeNote.isEmpty()) {
            return 0.0;
        }
        double sum = 0.0;
        for (Note note : listeNote) {
            sum += note.getValeur();
        }
        return sum / listeNote.size();
    }

    public List<Commentaire> getListeCommentaires() {
        return commentaires;
    }
}
