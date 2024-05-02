public class Note {
    private int valeur;

    public void setValeur(int valeur) {
        if(valeur >= 0 && valeur <= 10)
        this.valeur = valeur;
    }

    public int getValeur() {
        return valeur;
    }
}
