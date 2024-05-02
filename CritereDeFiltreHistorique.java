import java.util.Date;

public class CritereDeFiltreHistorique {
    private Date dateAchat;
    private int nombreDeFilms;
    private StatutAchat statutAchat;

    // Default constructor
    public CritereDeFiltreHistorique() {
    }

    // Parameterized constructor
    public CritereDeFiltreHistorique(Date dateAchat, int nombreDeFilms, StatutAchat statutAchat) {
        this.dateAchat = dateAchat;
        this.nombreDeFilms = nombreDeFilms;
        this.statutAchat = statutAchat;
    }

    // Getters and setters
    public Date getDateAchat() {
        return dateAchat;
    }

    public void setDateAchat(Date dateAchat) {
        this.dateAchat = dateAchat;
    }

    public int getNombreDeFilms() {
        return nombreDeFilms;
    }

    public void setNombreDeFilms(int nombreDeFilms) {
        this.nombreDeFilms = nombreDeFilms;
    }

    public StatutAchat getStatutAchat() {
        return statutAchat;
    }

    public void setStatutAchat(StatutAchat statutAchat) {
        this.statutAchat = statutAchat;
    }
}
