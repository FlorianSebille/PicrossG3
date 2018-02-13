

class Frame < Gtk::Box

  attr_reader :hautPage, :btnRetour, :btnHome

  def initialize(monApp, sens, unHeader)

    ##
    # Creation de la Gtk::Box
    super(sens)

    @hautPage = Gtk::Box.new(:horizontal)
    self.pack_start(@hautPage, :expand => false, :fill => true)

    self.spacing = 100

    @window = monApp
    @header = unHeader
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
