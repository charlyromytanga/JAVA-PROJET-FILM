package Metier;

public class Utilisateur extends Personne{
	private String phraseSecrete;

	public String getPhraseSecrete() {
		return phraseSecrete;
	}

	@Override
	public boolean authentification() {
		// TODO Auto-generated method stub
		return false;
	}

	public void setPhraseSecrete(String phraseSecrete) {
		this.phraseSecrete = phraseSecrete;
	}

	@Override
	public Personne creationDecompte() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean suppressionDecompte() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String modificationDemotDePasse() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
