
require "Classes/Interface/Label.rb"

class Page < Gtk::Box

  attr_reader :hautPage, :btnRetour, :btnHome, :enciennePage, :hautPage, :label

  def initialize(unTitre, monApp, sens, unHeader, enciennePage)

    ##
    # Creation de la Gtk::Box
    super(sens)

    @hautPage = Gtk::Box.new(:horizontal)

    @label = Label.new(unTitre, "EF2929", "40")
    @hautPage.add(@label, :expand => true, :fill => true)

    self.pack_start(@hautPage, :expand => false, :fill => true)

    self.spacing = 100

    @window = monApp
    @header = unHeader
    @enciennePage = enciennePage

    @header.btnRetour.signal_connect('clicked') {
      if (!enciennePage.eql?(nil)) then
        self.supprimeMoi
        enciennePage.ajouteMoi
        @window.show_all
      end
    }

    @header.btnHome.signal_connect('clicked') {
      self.supprimeMoi
      if ($joueur.eql?(nil)) then
        ConnexionOuCreation_Page.new(monApp, unHeader, nil).ajouteMoi
      else Menu_Page.new(monApp, unHeader, nil).ajouteMoi end
      @window.show_all
    }

    @header.btnCompte.signal_connect('clicked') {
      if (!$joueur.eql?(nil)) then
        self.supprimeMoi
        Compte_Page.new(monApp, unHeader, nil).ajouteMoi
        @window.show_all
      end
    }
  end

  ##
  # Methode pour ajouter l'objet actuelle a la fenetre
  def ajouteMoi
    @window << self
  end

  def supprimeMoi
    @window.remove(self)
  end

  def detruitMoi
    self.destroy
  end

end
