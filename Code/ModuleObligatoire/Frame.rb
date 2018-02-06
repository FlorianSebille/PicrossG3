

class Frame < Gtk::Box

  attr_reader :hautPage

  def initialize(monApp, sens)

    ##
    # Creation de la Gtk::Box
    super(sens)
    self.spacing = 50

    @window = monApp

    @hautPage = Gtk::Box.new(:horizontal)
    @hautPage.spacing = 150

    @btnHome = ButtonImage.new("../Images/Home.png")

    @btnHome.signal_connect('clicked') {
      self.supprimeMoi
      # a changer si on veut revenir sur une autre page
      ident = Identification.new(monApp)
      ident.ajouteMoi
      @window.show_all
    }

    @hautPage.pack_start(@btnHome, :expand => false, :fill => true)

    self.add(@hautPage, :expand => false, :fill => true)
  end

  ##
  # Methode pour ajouter l'objet actuelle a la fenetre
  def ajouteMoi
    @window.add(self)
  end

  def supprimeMoi
    self.destroy
  end

end
