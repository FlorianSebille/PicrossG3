
require "Classes/Interface/Page.rb"
require "Classes/Interface/Pages/Mode_Page.rb"
require "Classes/Interface/Label.rb"


class Compte_Page < Page

  def initialize(monApp, header, enciennePage)

    super("Mon Compte",monApp, :vertical, header, Menu_Page.new(monApp, header, nil), $joueur.couleur)
    self.spacing = 10

	table = Gtk::Table.new(1, 2)
	tabledozo = Gtk::Table.new(3, 2)

    mdp = Gtk::Entry.new
    mdp.visibility=(false)

	newmdp = Gtk::Entry.new
	newmdp.visibility=(false)
	couleur = Gtk::ComboBoxText.new()

	["rouge","bleu", "vert","gris","marron","noir","rose", "violet", "orange", "jaune"].each {|clr| couleur.append_text("#{clr}")}
	couleur.active = 0

	affecter = Gtk::Button.new(:label => "affecter", :use_underline => true)
	resetadventure = Gtk::Button.new(:label => "Redemarrer l'Aventure", :use_underline => true)
	changemdp = Gtk::Button.new(:label => "Changer de mot de passe", :use_underline => true)

	#couleur
	table.attach(Label.new("Couleur :","000000","15"),0,1,0,1)
	table.attach(couleur,1,2,0,1)

	#changement de mot de passe
    tabledozo.attach(Label.new("#{header.retournepseudo()}",$joueur.couleur, "15"),1,2,0,1)
    tabledozo.attach(Label.new("Ancien mot de passe :", "000000", "15"),0,1,1,2)
    tabledozo.attach(mdp,1,2,1,2)
	tabledozo.attach(Label.new("Nouveau mot de passe :","000000","15"),0,1,2,3)
	tabledozo.attach(newmdp,1,2,2,3)


	boxButton=Gtk::ButtonBox.new(:horizontal)
    boxButton.layout = :center

	boxButtondozo=Gtk::ButtonBox.new(:horizontal)
    boxButton.layout = :center

	#bouton affecte le changement de couleur
	boxButton.add(affecter)
	#bouton qui valide le changement de mdp
	boxButtondozo.add(changemdp)
	#bouton qui reset l'avaneture
	boxButtondozo.add(resetadventure)

	self.add(table)
	self.add(boxButton)
	self.add(tabledozo)
	self.add(boxButtondozo)

	#action sur le bouton qui valide le changement de couleur
	 affecter.signal_connect('clicked') {

		color = couleur.active_text
		if color == "rouge" then
			couleurTitre = "E90008"
		elsif color == "bleu" then
			couleurTitre = "0008EF"
		elsif color == "vert" then
			couleurTitre = "00EF18"
		elsif color == "gris" then
			couleurTitre = "737B74"
		elsif color == "marron" then
			couleurTitre = "4F2529"
		elsif color == "noir" then
			couleurTitre = "000000"
		elsif color == "rose" then
			couleurTitre = "F08DE9"
		elsif color == "violet" then
			couleurTitre = "A102DB"
		elsif color == "orange" then
			couleurTitre = "F48A00"
		elsif color == "jaune" then
			couleurTitre = "F4E400"
		end

      sonPseudo = header.retournepseudo()

      joueur = $sv.charger(sonPseudo)
      joueur.couleur = couleurTitre
      data = $sv.sauver(joueur)

      $joueur = joueur
      self.supprimeMoi
      Compte_Page.new(monApp, header, nil).ajouteMoi
      @window.show_all
    }

	 changemdp.signal_connect('clicked'){

      sonPseudo = header.retournepseudo()

      sonMDP = mdp.text
      sonNewMDP = newmdp.text


        if (File.exists?("Sauvegarde/"+sonPseudo+".marshal")) then
          sonMDP = Digest::SHA256.digest sonMDP

			joueur = $sv.charger(sonPseudo)
          if(joueur.mdp.eql?(sonMDP)) then
			sonNewMDP = Digest::SHA256.digest sonNewMDP
			joueur.mdp = sonNewMDP

			data = $sv.sauver(joueur)



            self.supprimeMoi
            menu = Menu_Page.new(monApp, @header, nil)
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

  end
end
