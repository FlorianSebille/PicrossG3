
require "Classes/Interface/Page.rb"
require "Classes/Interface/Partie.rb"
require "Classes/Interface/BoxButtonPartie.rb"

class Monde_Page < Page

  def initialize(unIndice, monApp, header, enciennePage)

    ##
    # Creation de la Gtk::Box
    super(("Monde n°"+ unIndice.to_s),monApp, :vertical, header, enciennePage)

    parties = Gtk::ButtonBox.new(:horizontal)
    parties.layout = :spread

    1.upto(5) { |monde|
      if monde > $joueur.avanceAventure.last then
        partie = BoxButtonPartie.new(unIndice,monde, true)
      else
        partie = BoxButtonPartie.new(unIndice,monde, false)

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

end
