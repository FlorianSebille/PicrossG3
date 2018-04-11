
require "Classes/Interface/Page.rb"
require "Classes/Interface/Pages/Mode_Page.rb"
require "Classes/Interface/Pages/ModeClassique_Page.rb"
require "Classes/Interface/Pages/ModeAventure_Page.rb"
require "Classes/Interface/Pages/LeaderBoard_Page.rb"
require "Classes/Didact.rb"

class Menu_Page < Page

  def initialize(monApp, header, enciennePage)

    super("Menu",monApp, :vertical, header, enciennePage,$joueur.couleur)
    self.spacing = 10

    @bouttons = Gtk::ButtonBox.new(:vertical)
    @bouttons.layout = :spread
    @bouttons.spacing = 20

    @btnJouer = Gtk::Button.new(:label => "Jouer", :use_underline => true)
    @btnLeaderboard = Gtk::Button.new(:label => "Leaderboard", :use_underline => true)
    @btnDidacticiel = Gtk::Button.new(:label => "Didacticiel", :use_underline => true)
    @btnQuitter = Gtk::Button.new(:label => "Quitter", :use_underline => true)

    [@btnJouer, @btnLeaderboard, @btnDidacticiel, @btnQuitter].each { |btn|
      @bouttons.add(btn, :expand => true, :fill => false)
    }


    @btnJouer.signal_connect('clicked') {
      ##
      # si il a reussi a ce co
      self.supprimeMoi
      choixMode = Mode_Page.new(@window, @header, self)
      choixMode.ajouteMoi
      @window.show_all
    }

    @btnLeaderboard.signal_connect('clicked') {
      ##
      # si il a reussi a ce co
      self.supprimeMoi
      mode = LeaderBoard_Page.new(@window, @header, self)
      mode.ajouteMoi
      @window.show_all
    }

    @btnDidacticiel.signal_connect('clicked') {
      ##
      # si il a reussi a ce co
      mode = Didact.new()
      #mode.ajouteMoi
      @window.show_all
    }

    @btnQuitter.signal_connect('clicked') {
      onDestroy
      @window.show_all
    }


    self.add(@bouttons)
  end
end
