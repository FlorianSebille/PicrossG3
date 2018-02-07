
class Identification < Frame

  def initialize(titre, monApp, sens)
    ##
    # Creation de la Gtk::Box
    super(monApp, sens)

    @hautPage = Gtk::Box.new(:horizontal)
    @hautPage.spacing = 150

    @btnHome = ButtonImage.new("../Images/Home.png")
    @label = Label.new(titre, "EF2929", "40")

    @btnHome.signal_connect('clicked') {
      self.supprimeMoi
      # a changer si on veut revenir sur une autre page
      choixConnexionCreation = ChoixConnexionCreation.new(monApp)
      choixConnexionCreation.ajouteMoi
      @window.show_all
    }

    @hautPage.pack_start(@btnHome, :expand => false, :fill => true)

    @hautPage.add(@label)

    self.add(@hautPage, :expand => false, :fill => true)
  end


end
