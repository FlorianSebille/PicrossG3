
require "Classes/Interface/Page.rb"
require "Classes/Interface/BoxButton.rb"
require "Classes/Interface/Pages/Monde_Page.rb"
class ModeAventure_Page < Page

  def initialize(monApp, header, enciennePage)

    ##
    # Creation de la Gtk::Box
    super("Aventure",monApp, :vertical, header, enciennePage)

    mondes = Gtk::ButtonBox.new(:horizontal)
    mondes.layout = :spread

    1.upto(3) { |indice|
      if indice > $joueur.avanceAventure.first then
        monde = BoxButton.new(indice, "Monde n°", "planete_verrous")
      else
        monde = BoxButton.new(indice, "Monde n°", "planete")

        monde.btn.signal_connect('clicked') {
          self.supprimeMoi
          monde = Monde_Page.new(indice, monApp, header, self)
          monde.ajouteMoi
          @window.show_all
        }
      end

      mondes.add(monde, :expand => false, :fill => true)

    }

    self.add(mondes)

  end

  def ajouteMoi
    page = ModeAventure_Page.new(@window, @header, @enciennePage)
    @window << page
    @window.show_all
  end

end
