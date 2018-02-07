begin
  require 'rubygems'
 rescue LoadError
end

require 'gtk3'
require "thread"

load "../donnée/Joueur.rb"


Gtk.init

def onDestroy
	puts "Fin de l'application"
	Gtk.main_quit
end


if ARGV.size.eql?(0) then

  aujourdhui = Time.new
  alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
	monApp = Gtk::Window.new

	# Titre de la fenêtre
	header = Gtk::HeaderBar.new
  header.show_close_button = true
  header.title = "Le Jeu du S6"
  header.has_subtitle = false

  #image = Gtk::Image.new("images/hp.png")
  image = Gtk::Image.new(:file => "images/basket.gif", :animation => true, :size => :dialog)
  header.pack_start(image)

	# Taille de la fenêtre
	monApp.set_default_size(400,100)
	# Réglage de la bordure
	monApp.border_width=5
	# On ne peut pas redimensionner
	monApp.set_resizable(true)
	# L'application est toujours centrée
	monApp.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)

  frame=Gtk::Box.new(:vertical)
  frame.spacing = 10

  bouton1 = Gtk::Box.new(:horizontal)
  bouton2 = Gtk::Box.new(:horizontal)

	#creation des boutons de demarage
  btnConnexion = Gtk::Button.new(:label => "Connexion", :use_underline => true)
  btnCreerCompte = Gtk::Button.new(:label => "Creer un compte", :use_underline => true)

  bouton1.add(btnConnexion, :expand => true, :fill => false)
  bouton2.add(btnCreerCompte, :expand => true, :fill => false)

  frame.add(bouton1)
  frame.add(bouton2)

  #Test Mais Ne Marche Pas
  btnCreerCompte.signal_connect('clicked') {

    btnConnexion.destroy
    btnCreerCompte.destroy

    monLabel=Gtk::Label.new("Connexion")

    table = Gtk::Table.new(6, 2)

    entreePseudo = Gtk::Entry.new
    entreeMDP = Gtk::Entry.new
    entreeVerifMDP = Gtk::Entry.new
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

    labelMDP = Gtk::Label.new("Mot de passe :")
    labelVerifMDP = Gtk::Label.new("Confirmation Mot de passe :")

    table.attach(Gtk::Label.new("Identifiant :"),0,1,0,1)
    table.attach(entreePseudo,1,2,0,1)
    table.attach(labelMDP,0,1,1,2)
    table.attach(entreeMDP,1,2,1,2)
    table.attach(labelVerifMDP,0,1,2,3)
    table.attach(entreeVerifMDP,1,2,2,3)
    table.attach(Gtk::Label.new("Prenom :"),0,1,3,4)
    table.attach(entreePrenom,1,2,3,4)
    table.attach(Gtk::Label.new("Nom :"),0,1,4,5)
    table.attach(entreeNom,1,2,4,5)
    table.attach(Gtk::Label.new("Date de Naissance :"),0,1,5,6)
    table.attach(boxNaissance,1,2,5,6)

    btnValide = Gtk::Button.new(:label => "Connexion", :use_underline => true)
    btnAnnule = Gtk::Button.new(:label => "Annuler", :use_underline => true)
    boxButton=Gtk::Box.new(:horizontal)

    boxButton.add(btnValide)
    boxButton.add(btnAnnule)

    frame.add(monLabel, :expand => true, :fill => false)

    frame.add(table)

    frame.add(boxButton)

    frame.reorder_child(monLabel, 0)

    btnValide.signal_connect('clicked'){

      sonPseudo = entreePseudo.text

      sv = MethodSauvegard.new
      #joueurs = charger("listeJoueur")
      joueurs = nil

      pseudoExistant = false

       #if(File.exists?("../Sauvegarde/listeJoueur.marshal"))
          #  print"ECRIRE JDSKFJKJFEDKJFEKEFJk"
       #else
       #end

       joueurs = Array.new

        sonMDP = entreeMDP.text
        sonVerifMDP = entreeVerifMDP.text

        sonJour = jour.active_text
        sonMois = mois.active_text
        sonAnnee = annee.active_text

        #majeur = false

        #if sonAnnee < aujourdhui.year-18 || (sonAnnee == aujourdhui.year-18 && sonMois < aujourdhui.month) || (sonAnnee == aujourdhui.year-18 && sonMois == aujourdhui.month && sonJour <= aujourdhui.day) then
        #  majeur = true
        #end

         if sonMDP.eql?(sonVerifMDP) then

          sonPrenom = entreePrenom.text
          sonNom = entreeNom.text

          joueur = Joueur.creer(sonNom,sonPrenom,sonPseudo,sonMDP,"#{sonJour}/#{sonMois}/#{sonAnnee}")
          joueur.augementXp(10)
          joueurs << joueur
          #joueurs << donnees


          @data = sv.sauver("listeJoueur",joueurs)

          @teste = Marshal.load(@data)

          frame.destroy
          frame=Gtk::Box.new(:vertical)
          frame.spacing = 10

          monLabel = Gtk::Label.new
          monLabel.set_markup("<span foreground=\"#73b5ff\"> Félicitation, vous vous etes inscrit\nvous pouvez vous connecter en revenant au menu\nou quitter le game </span>")
          btnValide = Gtk::Button.new(:label => "Menu", :use_underline => true)
          btnAnnule = Gtk::Button.new(:label => "Quitter", :use_underline => true)

          [monLabel, btnValide, btnAnnule].each {|elem| frame.add(elem)}

          monApp.add(frame)
          monApp.show_all
        else
          monLabel.destroy
          monLabel = Gtk::Label.new
          monLabel.set_markup("        Connexion\n<span foreground=\"#ff0000\">Mot de passe différent !!!</span>")

          labelMDP.set_markup("<span foreground=\"#ff0000\"> Mot de passe : </span>")
          labelVerifMDP.set_markup("<span foreground=\"#ff0000\"> Confirmation Mot de passe : </span>")

          frame.add(monLabel, :expand => true, :fill => false)
          frame.reorder_child(monLabel, 0)
          monApp.show_all
        end

    }

    monApp.show_all
  }

  monApp.add(frame)

	monApp.titlebar = header
	monApp.show_all
	# Quand la fenêtre est détruite il faut quitter
	monApp.signal_connect('destroy') {onDestroy}
	Gtk.main
else
	puts "Usage Error O argument pour le jeu du S6"
end
