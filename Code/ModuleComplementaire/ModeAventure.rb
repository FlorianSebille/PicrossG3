
class ModeAventure < PageMenu

  def initialize(monApp, header)

    ##
    # Creation de la Gtk::Box
    super("Aventure",monApp, :vertical, header)

    mondes = Gtk::ButtonBox.new(:horizontal)
    mondes.layout = :spread

    1.upto(3) { |indice|
      if indice > $joueur.monde then
        monde = BoxButton.new(indice, "Monde n°", "planete_verrous")
      else
        monde = BoxButton.new(indice, "Monde n°", "planete")

        monde.btn.signal_connect('clicked') {
          self.detruitMoi
          monde = Monde.new(indice, monApp, header)
          monde.ajouteMoi
          @window.show_all
        }
      end

      mondes.add(monde, :expand => false, :fill => true)

    }

    self.add(mondes)

  end

end
