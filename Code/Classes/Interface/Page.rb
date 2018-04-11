
require "Classes/Interface/Label.rb"

class Page < Gtk::Box

  attr_reader :hautPage, :btnRetour, :btnHome, :btnCompte, :enciennePage, :hautPage, :label , :couleur

  def initialize(unTitre, monApp, sens, unHeader, enciennePage, couleur)

    ##
    # Creation de la Gtk::Box
    super(sens)

    unless couleur.eql?(nil) then
	     @couleur = couleur
    else @couleur = $joueur.couleur end

    @hautPage = Gtk::Box.new(:horizontal)

    @label = Label.new(unTitre, @couleur, "40")
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

    @header.btnConnexion.signal_connect('clicked') {

      if(!$joueur.eql?(nil)) then
        $joueur = nil
        @header.supprimePseudo
      end

      self.supprimeMoi
      Connexion_Page.new(monApp, unHeader, ConnexionOuCreation_Page.new(monApp, unHeader, nil)).ajouteMoi
      @window.show_all
    }

  end

  ##
  # Methode pour ajouter l'objet actuelle a la fenetre
  def ajouteMoi
    @window << self
  end

  def supprimeMoi
    @window.each{ |children|
      unless children.class.eql?(Header) then
        @window.remove(children)
      end
    }
  end

  def detruitMoi
    @window.each{ |children|
      unless children.class.eql?(Header) then
        children.destroy
      end
    }
  end

end
