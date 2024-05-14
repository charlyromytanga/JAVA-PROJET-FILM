package metier;
import java.util.List;
import java.util.Date;
public class Achat {
    private Utilisateur utilisateur;
    private List<Film> filmsAchetes;
    private StatutAchat statut;
    private Date dateAchat;
    
    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }
    public int getNombreFilms() {
        return filmsAchetes.size();
    }
    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setFilmsAchetes(List<Film> films) {
        this.filmsAchetes = films;
    }

    public List<Film> getFilmsAchetes() {
        return filmsAchetes;
    }
    public StatutAchat getStatut() {
        return statut;
    }
    public Date getDateAchat() {
        return dateAchat;
    }
    public void setStatut(StatutAchat statut) {
        this.statut = statut;
    }
}
