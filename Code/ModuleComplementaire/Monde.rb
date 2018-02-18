
class Monde < PageMenu

  def initialize(unIndice, monApp, header)

    ##
    # Creation de la Gtk::Box
    super(("Monde n°"+ unIndice.to_s),monApp, :vertical, header)

    parties = Gtk::ButtonBox.new(:horizontal)
    parties.layout = :spread

    1.upto(5) { |monde|
      partie = BoxButton.new(monde, "Partie n°", "partie")

      partie.btn.signal_connect('clicked') {
        self.supprimeMoi
        partie = Partie.new(monApp, header, "facile1515elephant")
        partie.ajouteMoi
        @window.show_all
      }

      parties.add(partie, :expand => false, :fill => true)
    }

    self.add(parties)

  end

end
