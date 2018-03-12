
#require "Classes/Interface/Page.rb"
require "Classes/Interface/ModeClassique.rb"
require "Classes/Interface/BoxButton.rb"

class ModeEntrainement_Page < Page

  def initialize(monApp, header, enciennePage)

    ##
    # Creation de la Gtk::Box
    super("Mode Entrainement",monApp, :vertical, header, enciennePage)


    self.spacing = 30

    builder = Gtk::Notebook.new


    boxPrincipal = Gtk::Box.new(:horizontal, 20)


    boxBouton = Gtk::Box.new(:vertical, 40)

    bouton10x10 = Gtk::CheckButton.new("10x10")
    bouton10x10.active = true

    bouton15x15 = Gtk::CheckButton.new("15x15")
    bouton15x15.active = true

    bouton20x20 = Gtk::CheckButton.new("20x20")
    bouton20x20.active = true

    bouton25x25 = Gtk::CheckButton.new("25x25")
    bouton25x25.active = true

    boxBouton.add(bouton10x10)
    boxBouton.add(bouton15x15)
    boxBouton.add(bouton20x20)
    boxBouton.add(bouton25x25)


    partie1 = Gtk::Table.new(5,5)
    partie1.set_row_spacings(20)
    partie1.set_col_spacings(20)

    partie2 = Gtk::Table.new(5,5)
    partie2.set_row_spacings(20)
    partie2.set_col_spacings(20)

    partie3 = Gtk::Table.new(5,5)
    partie3.set_row_spacings(20)
    partie3.set_col_spacings(20)

    tableauDesGrillesFaciles = Array.new
    tableauDesGrillesMoyen = Array.new
    tableauDesGrillesDifficile = Array.new

     Dir.foreach("Grilles") do |fichier|
      fichier = fichier.gsub(".txt", '')
      if fichier.include?("facile") then
        tableauDesGrillesFaciles << fichier
      end
      if fichier.include?("normal")then
        tableauDesGrillesMoyen << fichier
      end
      if fichier.include?("difficile") then
        tableauDesGrillesDifficile << fichier
      end
    end



    partie1 = afficherTableau(partie1, tableauDesGrillesFaciles)
    partie2 = afficherTableau(partie2, tableauDesGrillesMoyen)
    partie3 = afficherTableau(partie3, tableauDesGrillesDifficile)


    builder.append_page(partie1, Gtk::Label.new("Facile"))

    builder.append_page( partie2, Gtk::Label.new("Moyen"))

    builder.append_page(partie3, Gtk::Label.new("Difficile"))


    boxPrincipal.add(boxBouton,:expand => true, :fill => false)
    boxPrincipal.add(builder,:expand => true, :fill => false)



    self.add(boxPrincipal)


  end

  def afficherTableau(partie, tableau)
    k=0
    tab = verifDifficulte(tableau)
    for j in 0..3
        for i in 0..4
            partie.attach(Gtk::Label.new(tab[k]), i, i+1, j, j+1)
            k+=1
        end
    end
    return partie
  end

  def verifDifficulte(tableau)

  	tableauDiff = Array.new
  	if(bouton10x10.active == true)
  		tableauDiff << tableau.include?('1010')
  	end

  	if(bouton15x15.active == true)
  		tableauDiff << tableau.include?('1515')
  	end

  	if(bouton20x20.active == true)
  		tableauDiff << tableau.include?('2020')
  	end

  	if(bouton15x15.active == true)
  		  		tableauDiff << tableau.include?('2525')
  	end

  end
end
