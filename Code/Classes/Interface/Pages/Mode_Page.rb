
require "Classes/Interface/Page.rb"
require "Classes/Interface/Pages/ModeEntrainement_Page.rb"
require "Classes/Interface/Pages/ModeCompetition_Page.rb"
require "Classes/Interface/Pages/ModeAventure_Page.rb"

class Mode_Page < Page

  def initialize(monApp, header, enciennePage)

    super("Mode",monApp, :vertical, header, enciennePage, $joueur.couleur)

    self.hautPage.spacing = 220

    @bouttons = Gtk::ButtonBox.new(:horizontal)
    @bouttons.layout = :spread

    @btnEntrainement = Gtk::Button.new(:label => "Entrainement", :use_underline => true)
    @btnCompetition = Gtk::Button.new(:label => "Competition", :use_underline => true)
    @btnAventure = Gtk::Button.new(:label => "Aventure", :use_underline => true)

    @bouttons.add(@btnEntrainement, :expand => true, :fill => false)
    @bouttons.add(@btnCompetition, :expand => true, :fill => false)
    @bouttons.add(@btnAventure, :expand => true, :fill => false)


    @btnEntrainement.signal_connect('clicked') {
      ##
      # si il a reussi a ce co
      self.supprimeMoi
      check = [true, true, true, true]
      checkDifficulte = [true, false, false]
      choixPartie = 1
      mode = ModeEntrainement_Page.new(@window, @header, self, check, choixPartie, checkDifficulte)
      $joueur.mode = 1
      mode.ajouteMoi
      @window.show_all
    }

    @btnCompetition.signal_connect('clicked') {
      ##
      # si il a reussi a ce co
      self.supprimeMoi
      mode = ModeCompetition_Page.new(@window, @header, self)
      $joueur.mode = 2
      mode.ajouteMoi
      @window.show_all
    }

    @btnAventure.signal_connect('clicked') {
      ##
      # si il a reussi a ce co
      self.supprimeMoi
      mode = ModeAventure_Page.new(@window, @header, self)
      $joueur.mode = 3
      mode.ajouteMoi
      @window.show_all
    }


    self.add(@bouttons)
  end

end
