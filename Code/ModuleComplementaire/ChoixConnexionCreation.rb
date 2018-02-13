
class ChoixConnexionCreation < Identification

  attr_reader :label

  def initialize(monApp, header)
    ##
    # Creation de la Gtk::Box
    super("Identification",monApp, :vertical, header)

    @bouttons = Gtk::ButtonBox.new(:horizontal)
    @bouttons.layout = :spread

    @btnConnexion = Gtk::Button.new(:label => "Connexion", :use_underline => true)
    @btnCreerCompte = Gtk::Button.new(:label => "Creer un compte", :use_underline => true)

    @bouttons.add(@btnConnexion, :expand => true, :fill => false)
    @bouttons.add(@btnCreerCompte, :expand => true, :fill => false)

    self.add(@bouttons)

    @btnCreerCompte.signal_connect('clicked') {
      self.supprimeMoi
      creation = CreationCompte.new(@window, @header)
      creation.ajouteMoi
      @window.show_all
    }

    @btnConnexion.signal_connect('clicked') {
      self.supprimeMoi
      connexion = Connexion.new(@window, @header)
      connexion.ajouteMoi
      @window.show_all
    }
  end


end
