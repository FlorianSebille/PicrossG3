
require "Classes/Interface/Page.rb"

class Partie < Page

  def initialize(monApp, header, fichier, enciennePage)
    super("",monApp, :vertical, header, enciennePage, $joueur.couleur)

    cheminDuFichier=(("Grilles/" + fichier.first + ".txt"))

    if (!$joueur.mode.eql?(3)) then
      cheminDujoueur=fichier
    else
      cheminDujoueur=$joueur.grillesAventure.key(fichier)
    end

    entier = (fichier.first.split(//).keep_if {|v| v =~ /[0123456789]/}).first(2).join.to_i

    $grillejoueur=Grille.new(entier, cheminDujoueur)

    $grillefinal=Grille.new(entier,cheminDuFichier)

    g=Grillei.new($grillejoueur.taille+1,$grillejoueur.taille+1,$grillejoueur, self)

    for i in (0..$grillejoueur.taille)
    	for j in (0..$grillejoueur.taille)
    		if $grillejoueur.grille[i][j].etat==1	then
    			g.actInit(i,j,2)
        end
        if $grillejoueur.grille[i][j].etat==2  then
          g.actInit(i,j,3)
    		end
    	end

    end

    monApp.show_all
  end


end
