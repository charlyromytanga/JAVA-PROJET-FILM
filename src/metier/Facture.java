package metier;
public class Facture {
    private int id;
    private double montant;
    private double TVA;

    public Facture(int id, double montant, double TVA) {
        this.id = id;
        this.montant = montant;
        this.TVA = TVA;
    }

    public Facture() {
        // Default constructor
    }

    public Facture createFacture(int id, float montant, double TVA) {
        return new Facture(id, montant, TVA);
    }

    public double getTVA() {
        return TVA;
    }

    public int getId() {
        return id;
    }

    public double getMontant() {
        return montant;
    }

    // Other methods if needed
}
