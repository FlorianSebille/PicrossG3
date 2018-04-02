
require "Classes/Interface/Page.rb"
require "Classes/Interface/Label.rb"
require "Classes/Interface/Pages/ConnexionOuCreation_Page.rb"
require "Classes/Interface/Pages/Menu_Page.rb"
require "Classes/MethodSauvegard.rb"

class Connexion_Page < Page

	
  def initialize(monApp, header, enciennePage)
    super("Connexion",monApp, :vertical, header, enciennePage,"E90008")

    #@header.btnRetour.signal_connect('clicked') {
    #  self.supprimeMoi
    #  choixConnexionCreation = ConnexionOuCreation_Page.new(monApp, @header, self)
    #  choixConnexionCreation.ajouteMoi
    #  @window.show_all
    #}

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

      sonPseudo = entreePseudo.text
      sonMdp = entreeMDP.text

      if !(sonMdp == nil) then
        sonMdp = Digest::SHA256.digest sonMdp
      end

      if(File.exists?("Sauvegarde/"+sonPseudo+".marshal")) then
          joueur = $sv.charger(sonPseudo)
          if(joueur.mdp.eql?(sonMdp)) then
            $joueur = joueur

            $joueur.initializeGrillesEntrainement
            $joueur.initializeGrillesCompetition

            @header.ajoutepseudo(sonPseudo)
            self.supprimeMoi
            menu = Menu_Page.new(monApp, @header, nil,"E90008")
            menu.ajouteMoi
            @window.show_all
          else
            label = Label.new("Mot de passe incorrect !!!", "EF2929", "15")
            self.add(label, :expand => true, :fill => false)
            self.reorder_child(label, 2)
            @window.show_all
          end
      end
    }

    @btnAnnule.signal_connect('clicked') {
      self.supprimeMoi
      connexion = Connexion_Page.new(monApp, @header, self)
      connexion.ajouteMoi
      @window.show_all
    }
    self.add(table)
    self.add(boxButton)
  end

end
