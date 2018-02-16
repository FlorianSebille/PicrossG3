
class Identification < Frame

  def initialize(titre, monApp, sens, header)
    ##
    # Creation de la Gtk::Box
    super(monApp, sens, header)

    @label = Label.new(titre, "EF2929", "40")

    ##
    # Probleme ne fonctionne pas

    @header.btnHome.signal_connect('clicked') {
      # a changer si on veut revenir sur une autre page
      self.supprimeMoi
      choixConnexionCreation = ChoixConnexionCreation.new(monApp, @header)
      choixConnexionCreation.ajouteMoi
      @window.show_all
    }


    @hautPage.add(@label, :expand => true, :fill => true)
  end


end
