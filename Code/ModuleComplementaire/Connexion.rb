
class Connexion < PageMenu

  def initialize(monApp)
    super("Connexion",monApp, :vertical)

    table = Gtk::Table.new(2, 2)

    entreePseudo = Gtk::Entry.new

    entreeMDP = Gtk::Entry.new
    entreeMDP.visibility=(false)

    table.attach(Label.new("Identifiant :", "000000", "15"),0,1,0,1)
    table.attach(entreePseudo,1,2,0,1)
    table.attach(Label.new("Mot de passe :", "000000", "15"),0,1,1,2)
    table.attach(entreeMDP,1,2,1,2)

    btnValide = Gtk::Button.new(:label => "Connexion", :use_underline => true)
    btnAnnule = Gtk::Button.new(:label => "Annuler", :use_underline => true)
    btnAfficheMdp = Gtk::Button.new(:label => "Afficher MDP ?", :use_underline => true)

    boxButton=Gtk::ButtonBox.new(:horizontal)
    boxButton.layout = :center

    boxButton.add(btnValide)
    boxButton.add(btnAnnule)
    boxButton.add(btnAfficheMdp)

    btnAfficheMdp.signal_connect('clicked') {
      if entreeMDP.visibility? then
        entreeMDP.visibility=(false)
      else entreeMDP.visibility=(true) end
    }
    self.add(table)
    self.add(boxButton)
  end

end
