
class ChoixMode < PageMenu

  def initialize(monApp)

    super("Menue",monApp, :vertical)

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
      mode = ModeEntrainement.new(@window)
      mode.ajouteMoi
      @window.show_all
    }

    @btnCompetition.signal_connect('clicked') {
      ##
      # si il a reussi a ce co
      self.supprimeMoi
      mode = ModeCompetition.new(@window)
      mode.ajouteMoi
      @window.show_all
    }

    @btnAventure.signal_connect('clicked') {
      ##
      # si il a reussi a ce co
      self.supprimeMoi
      mode = ModeAventure.new(@window)
      mode.ajouteMoi
      @window.show_all
    }


    self.add(@bouttons)
  end

end
