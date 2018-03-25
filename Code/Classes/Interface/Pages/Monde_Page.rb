
require "Classes/Interface/Page.rb"
require "Classes/Interface/Partie.rb"
require "Classes/Interface/BoxButtonPartie.rb"

class Monde_Page < Page

  def initialize(unIndice, monApp, header, enciennePage)

    ##
    # Creation de la Gtk::Box
    super(("Monde n°"+ unIndice.to_s),monApp, :vertical, header, enciennePage)

    @indice = unIndice

    parties = Gtk::ButtonBox.new(:horizontal)
    parties.layout = :spread

    @nbEtoile = 0

    1.upto(5) { |monde|

      if(@nbEtoile >= 8) then
        $joueur.avanceAventure[1] = 5
      elsif(@nbEtoile >= 6) then
        $joueur.avanceAventure[1] = 4
      end
      p unIndice
      p $joueur.avanceAventure.first

      if unIndice >= $joueur.avanceAventure.first && monde > $joueur.avanceAventure.last then
        partie = BoxButtonPartie.new(unIndice,monde,@nbEtoile, true)
      else
        partie = BoxButtonPartie.new(unIndice,monde, @nbEtoile, false)
        @nbEtoile += partie.nbEtoile
        partie.btn.signal_connect('clicked') {
          self.supprimeMoi
          partie = Partie.new(monApp, header, $joueur.grilleAventure(unIndice,monde), self)
          partie.ajouteMoi
          @window.show_all
        }
      end
      parties.add(partie, :expand => false, :fill => true)
    }

    self.add(parties)

  end

  def ajouteMoi
    page = Monde_Page.new(@indice, @window, @header, @enciennePage)
    @window << page
    @window.show_all
  end

end
