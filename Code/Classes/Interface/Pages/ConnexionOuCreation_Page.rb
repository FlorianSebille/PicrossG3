
require "Classes/Interface/Page.rb"
require "Classes/Interface/Pages/CreationCompte_Page.rb"
require "Classes/Interface/Pages/Connexion_Page.rb"

class ConnexionOuCreation_Page < Page

  def initialize(monApp, header, enciennePage)
    ##
    # Creation de la Gtk::Box
    super("Identification",monApp, :vertical, header, enciennePage)

    @bouttons = Gtk::ButtonBox.new(:horizontal)
    @bouttons.layout = :spread

    @btnConnexion = Gtk::Button.new(:label => "Connexion", :use_underline => true)
    @btnCreerCompte = Gtk::Button.new(:label => "Creer un compte", :use_underline => true)

    @bouttons.add(@btnConnexion, :expand => true, :fill => false)
    @bouttons.add(@btnCreerCompte, :expand => true, :fill => false)

    self.add(@bouttons)

    @btnCreerCompte.signal_connect('clicked') {
      self.supprimeMoi
      creation = CreationCompte_Page.new(@window, @header, self)
      creation.ajouteMoi
      @window.show_all
    }

    @btnConnexion.signal_connect('clicked') {
      self.supprimeMoi
      connexion = Connexion_Page.new(@window, @header, self)
      connexion.ajouteMoi
      @window.show_all
    }
  end


end
