
class Identification < Frame

  def initialize(titre, monApp, sens)
    ##
    # Creation de la Gtk::Box
    super(monApp, sens)

    @hautPage.spacing = 150

    @label = Label.new(titre, "EF2929", "40")

    @btnHome.signal_connect('clicked') {
      self.supprimeMoi
      # a changer si on veut revenir sur une autre page
      choixConnexionCreation = ChoixConnexionCreation.new(monApp)
      choixConnexionCreation.ajouteMoi
      @window.show_all
    }

    @hautPage.add(@label)
  end


end
