
class Partie < Frame

  def initialize(monApp)
    super(monApp, :vertical)

    table = Gtk::Table.new(3,3)

    @btnChrono = Gtk::Button.new(:label => "Chrono", :use_underline => true)
    @btnGrille = Gtk::Button.new(:label => "Grille", :use_underline => true)

    @btnaide = Gtk::Button.new(:label => "Aide", :use_underline => true)

    @btnChoix = Gtk::Button.new(:label => "Choix", :use_underline => true)

    table.attach(@btnChoix,0,1,1,2)
    table.attach(@btnChrono,1,2,0,1)
    table.attach(@btnGrille,1,2,1,2)
    table.attach(@btnaide,2,3,1,2)

    self.add(table)
  end

end
