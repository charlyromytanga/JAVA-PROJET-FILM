package metier;
import java.util.Date;

public class Effectuer {
    private Date date;
    private double montantTotal;

    public void setDate(Date date) {
        this.date = date;
    }

    public Date getDate() {
        return date;
    }

    public void setMontantTotal(double montant) {
        this.montantTotal = montant;
    }

    public double getMontantTotal() {
        return montantTotal;
    }
}
