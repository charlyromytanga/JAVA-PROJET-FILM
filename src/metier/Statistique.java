package metier;
import java.util.List;

public class Statistiques {
    private int nombreVentes;
    private int nombreFilms;
    private int nombreUtilisateurs;

    public int getNombreVentes() {
        return nombreVentes;
    }

    public void setNombreVentes(int ventes) {
        this.nombreVentes = ventes;
    }

    public int getNombreFilms() {
        return nombreFilms;
    }

    public void setNombreFilms(int nombreFilms) {
        this.nombreFilms = nombreFilms;
    }

    public int nombreAbonnes() {
        // Implementation for counting subscribers
        return 0;
    }

    public List<Film> filmsLesPlusVendus() {
        // Implementation for fetching top-selling films
        return null;
    }

    public int getNombreUtilisateurs() {
        return nombreUtilisateurs;
    }

    public void setNombreUtilisateurs(int nombreUtilisateurs) {
        this.nombreUtilisateurs = nombreUtilisateurs;
    }
}
