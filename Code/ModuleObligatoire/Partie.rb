

class Partie < PageMenu

  def initialize(monApp, header)
    super("",monApp, :vertical, header)

    cheminDuFichier="../Grilles/facile1010souris.txt"
    cheminDujoueur="facile1010souris"

    grillejoueur=Grille.new(10, cheminDujoueur)
    #grillejoueur.rejouer()
    $grillefinal=Grille.new(10,cheminDuFichier)
    g=Grillei.new(grillejoueur.taille+1,grillejoueur.taille+1,grillejoueur, self)

    for i in (0..grillejoueur.taille)
    	for j in (0..grillejoueur.taille)
    		if grillejoueur.grille[i][j].etat==1	then

    			g.actInit(i,j)

    		end
    	end

    end

    monApp.show_all
  end




end
