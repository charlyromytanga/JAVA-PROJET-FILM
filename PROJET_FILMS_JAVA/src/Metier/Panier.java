package Metier;
import java.util.List;

public class Panier {
    private List<Film> films;
    private boolean estVide;

    public void ajouterFilm(Film film) {
        films.add(film);
    }

    public void supprimerFilm(Film film) {
        films.remove(film);
    }

    public Facture payerPanier() {
        // Implementation for generating invoice
        return new Facture();
    }
}
