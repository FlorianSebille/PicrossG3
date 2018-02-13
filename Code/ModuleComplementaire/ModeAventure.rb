
class ModeAventure < PageMenu

  def initialize(monApp, header)

    ##
    # Creation de la Gtk::Box
    super("Aventure",monApp, :vertical, header)

    mondes = Gtk::ButtonBox.new(:horizontal)
    mondes.layout = :spread

    1.upto(3) { |indice|
      monde = BoxButton.new(indice, "Monde n°")

      monde.btn.signal_connect('clicked') {
        self.supprimeMoi
        monde = Monde.new(indice, monApp, header)
        monde.ajouteMoi
        @window.show_all
      }

      mondes.add(monde, :expand => false, :fill => true)

    }

    self.add(mondes)

  end

end
