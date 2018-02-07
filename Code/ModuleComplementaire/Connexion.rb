
class Connexion < Identification

  def initialize(monApp)
    super("Connexion",monApp, :vertical)

    btnRetour.signal_connect('clicked') {
      ##
      # si il a reussi a ce co
      self.supprimeMoi
      choixConnexionCreation = ChoixConnexionCreation.new(monApp)
      choixConnexionCreation.ajouteMoi
      @window.show_all
    }

    table = Gtk::Table.new(2, 2)

    entreePseudo = Gtk::Entry.new

    entreeMDP = Gtk::Entry.new
    entreeMDP.visibility=(false)

    table.attach(Label.new("Identifiant :", "000000", "15"),0,1,0,1)
    table.attach(entreePseudo,1,2,0,1)
    table.attach(Label.new("Mot de passe :", "000000", "15"),0,1,1,2)
    table.attach(entreeMDP,1,2,1,2)

    @btnConnexion = Gtk::Button.new(:label => "Connexion", :use_underline => true)
    @btnAnnule = Gtk::Button.new(:label => "Annuler", :use_underline => true)
    @btnAfficheMdp = Gtk::Button.new(:label => "Afficher MDP ?", :use_underline => true)

    boxButton=Gtk::ButtonBox.new(:horizontal)
    boxButton.layout = :center

    boxButton.add(@btnConnexion)
    boxButton.add(@btnAnnule)
    boxButton.add(@btnAfficheMdp)

    @btnAfficheMdp.signal_connect('clicked') {
      if entreeMDP.visibility? then
        entreeMDP.visibility=(false)
      else entreeMDP.visibility=(true) end
    }


    @btnConnexion.signal_connect('clicked') {
      ##
      # si il a reussi a ce co
      self.supprimeMoi
      menu = Menu.new(monApp)
      menu.ajouteMoi
      @window.show_all
    }

    @btnAnnule.signal_connect('clicked') {
      self.supprimeMoi
      choixConnexionCreation = ChoixConnexionCreation.new(monApp)
      choixConnexionCreation.ajouteMoi
      @window.show_all
    }
    self.add(table)
    self.add(boxButton)
  end

end
