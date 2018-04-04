
require "Classes/Interface/Page.rb"

class Partie < Page

  def initialize(monApp, header, fichier, enciennePage)
    super("",monApp, :vertical, header, enciennePage)

   

    if($joueur.mode == 1)
       cheminDuFichier=(("Grilles/" + fichier + ".txt"))
        cheminDujoueur=""
    else
          cheminDuFichier=(("Grilles/" + fichier.first + ".txt"))
          cheminDujoueur=$joueur.grillesAventure.key(fichier)
    end

   

     if($joueur.mode == 1)
        if(fichier.include?"1010")
              entier = 10
          end
          if(fichier.include?"1515")
               entier = 15
          end
          if(fichier.include?"2020")
               entier = 20
          end
          if(fichier.include?"2525")
               entier = 25
          end
    else
      entier = (fichier.first.split(//).keep_if {|v| v =~ /[0123456789]/}).first(2).join.to_i
    end

    grillejoueur=Grille.new(entier, cheminDujoueur)
    #grillejoueur.rejouer()
    $grillefinal=Grille.new(entier,cheminDuFichier)
    g=Grillei.new(grillejoueur.taille+1,grillejoueur.taille+1,grillejoueur, self)


    for i in (0..grillejoueur.taille)
      for j in (0..grillejoueur.taille)
        if grillejoueur.grille[i][j].etat==1  then
          g.actInit(i,j)
        end
        if grillejoueur.grille[i][j].etat==2  then
          g.actInit(i,j)
          g.actInit(i,j)
        end
      end

    end

    monApp.show_all
  end
end
