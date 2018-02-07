

class Frame < Gtk::Box

  attr_reader :hautPage

  def initialize(monApp, sens)

    ##
    # Creation de la Gtk::Box
    super(sens)
    self.spacing = 60

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
