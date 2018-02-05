
class CoixMode < PageMenu

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

    self.add(@bouttons)
  end

end
