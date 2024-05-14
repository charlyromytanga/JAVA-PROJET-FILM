package metier;
public class FiltreCommentaire {
    private boolean plusRecent;
    private boolean positifs;
    private boolean negatifs;

    // Constructor
    public FiltreCommentaire(boolean plusRecent, boolean positifs, boolean negatifs) {
        this.plusRecent = plusRecent;
        this.positifs = positifs;
        this.negatifs = negatifs;
    }

    // Getters and Setters
    public boolean isPlusRecent() {
        return plusRecent;
    }

    public void setPlusRecent(boolean plusRecent) {
        this.plusRecent = plusRecent;
    }

    public boolean isPositifs() {
        return positifs;
    }

    public void setPositifs(boolean positifs) {
        this.positifs = positifs;
    }

    public boolean isNegatifs() {
        return negatifs;
    }

    public void setNegatifs(boolean negatifs) {
        this.negatifs = negatifs;
    }
}
