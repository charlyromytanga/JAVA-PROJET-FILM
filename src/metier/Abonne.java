package metier;
public class Abonne  {
    private double reduction;

    // Default constructor
    public Abonne() {
    }

    // Parameterized constructor
    public Abonne(double reduction) {
        this.reduction = reduction;
    }

    public double getReduction() {
        return reduction;
    }

    public void setReduction(double reduction) {
        this.reduction = reduction;
    }

    public boolean aAccesResumes() {
        // Implementation for accessing resumes
        // This method could include logic to check if the subscriber has access to resumes
        return true; // Assuming all subscribers have access to resumes by default
    }
}

// mettre extend pour abboner avec utilisateur. 
