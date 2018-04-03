
require "Classes/Interface/Page.rb"
require "Classes/Interface/Label.rb"
require "Classes/Interface/Pages/CreationCompte_Page.rb"
require "Classes/Interface/Pages/Connexion_Page.rb"

class CreationCompte_Page < Page

  def initialize(monApp, header, enciennePage)

    super("Creation Compte",monApp, :vertical, header, enciennePage,"E90008")

    aujourdhui = Time.new
    table = Gtk::Table.new(6, 2)

    entreePseudo = Gtk::Entry.new

    entreeMDP = Gtk::Entry.new
    entreeMDP.visibility=(false)

    entreeVerifMDP = Gtk::Entry.new
    entreeVerifMDP.visibility=(false)

    entreePrenom = Gtk::Entry.new
    entreeNom = Gtk::Entry.new

    jour = Gtk::ComboBoxText.new()
    mois = Gtk::ComboBoxText.new()
    annee = Gtk::ComboBoxText.new()
    boxNaissance=Gtk::Box.new(:horizontal)

    1.upto(31) {|i| jour.append_text("#{i}") }
    jour.active = aujourdhui.day-1

    ["Janvier","Février","Mars","Avril","Mai","Juin","Juillet", "Aout", "Septembre", "Octobre", "Novembre","Décembre"].each {|moi| mois.append_text("#{moi}")}
    mois.active = aujourdhui.month-1

    1950.upto(aujourdhui.year) {|i| annee.append_text("#{i}") }
    annee.active = aujourdhui.year-1950

    [jour, mois, annee].each {|x| boxNaissance.add(x)}

    labelPseudo = Label.new("Identifiant :", "000000", "15")
    labelMDP = Label.new("Mot de passe :", "000000", "15")
    labelVerifMDP = Label.new("Confirmation Mot de passe :", "000000", "15")

    table.attach(labelPseudo,0,1,0,1)
    table.attach(entreePseudo,1,2,0,1)
    table.attach(labelMDP,0,1,1,2)
    table.attach(entreeMDP,1,2,1,2)
    table.attach(labelVerifMDP,0,1,2,3)
    table.attach(entreeVerifMDP,1,2,2,3)
    table.attach(Label.new("Prenom :", "000000", "15"),0,1,3,4)
    table.attach(entreePrenom,1,2,3,4)
    table.attach(Label.new("Nom :", "000000", "15"),0,1,4,5)
    table.attach(entreeNom,1,2,4,5)
    table.attach(Label.new("Date de Naissance :", "000000", "15"),0,1,5,6)
    table.attach(boxNaissance,1,2,5,6)

    btnValide = Gtk::Button.new(:label => "Connexion", :use_underline => true)
    btnAnnule = Gtk::Button.new(:label => "Annuler", :use_underline => true)
    btnAfficheMdp = Gtk::Button.new(:label => "Afficher MDP ?", :use_underline => true)

    btnAfficheMdp.signal_connect('clicked') {
      if entreeMDP.visibility? then
        [entreeMDP,entreeVerifMDP].each {|entree|
          entree.visibility=(false)
        }
      else
        [entreeMDP,entreeVerifMDP].each {|entree|
          entree.visibility=(true)
        }
      end
    }

    boxButton=Gtk::ButtonBox.new(:horizontal)
    boxButton.layout = :center

    boxButton.add(btnValide)
    boxButton.add(btnAnnule)
    boxButton.add(btnAfficheMdp)

    self.add(table)
    self.add(boxButton)

    btnValide.signal_connect('clicked'){

      sonPseudo = entreePseudo.text

      sonMDP = entreeMDP.text
      sonVerifMDP = entreeVerifMDP.text

      if sonMDP.eql?(sonVerifMDP) then

        ##
        # Création d'un joueur et rajout a la base
        #   A FAIRE

        if (!(File.exists?("Sauvegarde/"+sonPseudo+".marshal"))) then
          sonMDP = Digest::SHA256.digest sonMDP

          sonJour = jour.active_text
          sonMois = mois.active_text
          sonAnnee = annee.active_text

          sonPrenom = entreePrenom.text
          sonNom = entreeNom.text

          joueur = Joueur.creer(sonNom,sonPrenom,sonPseudo,sonMDP,"#{sonJour}/#{sonMois}/#{sonAnnee}")

          data = $sv.sauver(joueur)

          self.detruitMoi
          connexion = Connexion_Page.new(monApp, @header, enciennePage)
          connexion.ajouteMoi

          @window.show_all

        else

          label = Label.new("Pseudo déjà utilisé !!!", "EF2929", "15")
          labelPseudo.set_markup("<span foreground=\"#ff0000\"> Identifiant : </span>")
          self.add(label, :expand => true, :fill => false)
          self.reorder_child(label, 2)
          @window.show_all
        end

      else
        label = Label.new("Mot de passe différent !!!", "EF2929", "15")

        labelMDP.set_markup("<span foreground=\"#ff0000\"> Mot de passe : </span>")
        labelVerifMDP.set_markup("<span foreground=\"#ff0000\"> Confirmation Mot de passe : </span>")

        self.add(label, :expand => true, :fill => false)
        self.reorder_child(label, 2)
        @window.show_all
      end

    }

    btnAnnule.signal_connect('clicked') {
      self.detruitMoi
      creationCompte = CreationCompte_Page.new(monApp, @header)
      creationCompte.ajouteMoi
      @window.show_all
    }
  end
end
