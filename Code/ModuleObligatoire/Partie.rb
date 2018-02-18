

class Partie < PageMenu

  def initialize(monApp, header, fichier)
    super("",monApp, :vertical, header)
    cheminDuFichier=(("../Grilles/" +fichier +".txt"))
    cheminDujoueur=fichier

    entier = (fichier.split(//).keep_if {|v| v =~ /[0123456789]/}).first(2).join.to_i

    grillejoueur=Grille.new(entier, cheminDujoueur)
    #grillejoueur.rejouer()
    $grillefinal=Grille.new(entier,cheminDuFichier)
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
