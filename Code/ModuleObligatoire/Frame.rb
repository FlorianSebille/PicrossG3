

class Frame < Gtk::Box

  attr_reader :hautPage, :btnRetour, :btnHome

  def initialize(monApp, sens)

    ##
    # Creation de la Gtk::Box
    super(sens)

    @hautPage = Gtk::Box.new(:horizontal)
    @hautPage.spacing = 150

    @btnRetour = ButtonImage.new("../Images/Retour.png")
    @btnHome   = ButtonImage.new("../Images/Home.png")

    @hautPage.pack_start(@btnHome, :expand => false, :fill => true)
    @hautPage.pack_end(@btnRetour, :expand => false, :fill => true)

    self.pack_start(@hautPage, :expand => false, :fill => true)

    self.spacing = 100
    
    @window = monApp

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
