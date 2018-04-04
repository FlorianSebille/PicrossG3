require "Classes/Interface/Page.rb"
require "Classes/Interface/ModeClassique.rb"
require "Classes/Interface/BoxButton.rb"

class ModeEntrainement_Page < Page

  def initialize(monApp, header, enciennePage, check, choixpartie, checkDifficulte)

    ##
    # Creation de la Gtk::Box
    super("Mode Entrainement",monApp, :vertical, header, enciennePage, $joueur.couleur)


    self.spacing = 30


    boxChoix = Gtk::Box.new(:vertical, 20)

    boxDifficulte = Gtk::Box.new(:horizontal,20)

    boxPrincipal = Gtk::Box.new(:horizontal, 5)



    @boutonFacile = Gtk::ToggleButton.new("Facile")
    @boutonFacile.active = checkDifficulte[0]

    @boutonMoyen = Gtk::ToggleButton.new("Moyen")
    @boutonMoyen.active = checkDifficulte[1]

    @boutonDifficile = Gtk::ToggleButton.new("Difficile")
    @boutonDifficile.active = checkDifficulte[2]

    boxDifficulte.add(@boutonFacile)
    boxDifficulte.add(@boutonMoyen)
    boxDifficulte.add(@boutonDifficile)

    boxChoix.add(boxDifficulte)


    @boutonFacile.signal_connect ("clicked"){
          checkDifficulte[0]=true
          checkDifficulte[1]=false
          checkDifficulte[2]=false
          @partieSelect = 1

          self.supprimeMoi
          mode = ModeEntrainement_Page.new(monApp, header, enciennePage, check, @partieSelect, checkDifficulte)
          mode.ajouteMoi
          @window.show_all

    }

    @boutonMoyen.signal_connect ("clicked"){
          checkDifficulte[0]=false
          checkDifficulte[1]=true
          checkDifficulte[2]=false
          @partieSelect = 2


          self.supprimeMoi
          mode = ModeEntrainement_Page.new(monApp, header, enciennePage, check, @partieSelect, checkDifficulte)
          mode.ajouteMoi
          @window.show_all

    }

    @boutonDifficile.signal_connect ("clicked"){
          checkDifficulte[0]=false
          checkDifficulte[1]=false
          checkDifficulte[2]=true
          @partieSelect = 3


          self.supprimeMoi
          mode = ModeEntrainement_Page.new(monApp, header, enciennePage, check, @partieSelect, checkDifficulte)
          mode.ajouteMoi
          @window.show_all

    }


    boxBouton = Gtk::Box.new(:vertical, 40)

    @bouton10x10 = Gtk::ToggleButton.new("10x10")
    @bouton10x10.active = check[0]

    @bouton15x15 = Gtk::ToggleButton.new("15x15")
    @bouton15x15.active = check[1]

    @bouton20x20 = Gtk::ToggleButton.new("20x20")
    @bouton20x20.active = check[2]

    @bouton25x25 = Gtk::ToggleButton.new("25x25")
    @bouton25x25.active = check[3]

    boxBouton.add(@bouton10x10)
    boxBouton.add(@bouton15x15)
    boxBouton.add(@bouton20x20)
    boxBouton.add(@bouton25x25)


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

    if(choixpartie == 1)
      partie1 = afficherTableau(partie1, tableauDesGrillesFaciles)
      boxChoix.add(partie1)
    end
    if(choixpartie == 2)
       partie2 = afficherTableau(partie2, tableauDesGrillesMoyen)
       boxChoix.add(partie2)
    end
    if(choixpartie ==3)
      partie3 = afficherTableau(partie3, tableauDesGrillesDifficile)
      boxChoix.add(partie3)
    end

    @bouton10x10.signal_connect ("clicked"){

        if(@bouton10x10.active? == true)
            check[0] = true

        else
            check[0] = false
        end

        self.supprimeMoi
        mode = ModeEntrainement_Page.new(monApp, header, enciennePage, check, choixpartie, checkDifficulte)
        mode.ajouteMoi
        @window.show_all
    }

    @bouton15x15.signal_connect ("clicked"){
        if(@bouton15x15.active? == true)
            check[1] = true

        else
            check[1] = false
        end

        self.supprimeMoi
        mode = ModeEntrainement_Page.new(monApp, header, enciennePage, check, choixpartie, checkDifficulte)
        mode.ajouteMoi
        @window.show_all



    }

    @bouton20x20.signal_connect ("clicked"){
        if(@bouton20x20.active? == true)
            check[2] = true

        else
            check[2] = false
        end
         self.supprimeMoi
        mode = ModeEntrainement_Page.new(monApp, header, enciennePage, check, choixpartie, checkDifficulte)
        mode.ajouteMoi
        @window.show_all
    }


    @bouton25x25.signal_connect ("clicked"){
      if(@bouton25x25.active? == true)
          check[3] = true

      else
          check[3] = false
      end
      self.supprimeMoi
      mode = ModeEntrainement_Page.new(monApp, header, enciennePage, check, choixpartie, checkDifficulte)
      mode.ajouteMoi
      @window.show_all
    }



    boxPrincipal.add(boxBouton,:expand => true, :fill => false)
    boxPrincipal.add(boxChoix,:expand => true, :fill => false)


    self.add(boxPrincipal)

  end

  def afficherTableau(partie, tableau)
    tab = verifDifficulte(tableau)
      boutonGrille = Hash.new
    k=0
    for j in 0..tab.length-1
        for i in 0..3
          if(tab[k]!=nil)

            if(tab[k].include?"1010")
              image = "grille1010"
            end
            if(tab[k].include?"1515")
               image = "grille1515"
            end
             if(tab[k].include?"2020")
               image = "grille2020"
            end
             if(tab[k].include?"2525")
               image = "grille2525"
            end


            boutonGrille[tab[k]] = BoxButton.new("", "", image)

            boutonGrille.each {|key, value|
              value.btn.signal_connect ("clicked"){
              self.supprimeMoi

              partie = Partie.new(@window, @header, key, self)
              partie.ajouteMoi
              @window.show_all
            }
    }

            partie.attach(boutonGrille[tab[k]], i, i+1, j, j+1)



            k+=1
          end
        end
    end




        return partie
  end


  def verifDifficulte(tableau)

    tableauDiff = Array.new
    if(@bouton10x10.active? == true)
        for i in 0 .. tableau.length-1
           if(tableau[i].include?"1010")
                tableauDiff << tableau[i]

            end

        end

    end

   if(@bouton15x15.active? == true)
        for i in 0 .. tableau.length-1
           if(tableau[i].include?"1515")
                tableauDiff << tableau[i]

            end

        end

    end

    if(@bouton20x20.active? == true)
        for i in 0 .. tableau.length-1
           if(tableau[i].include?"2020")
                tableauDiff << tableau[i]

            end

        end

    end

    if(@bouton25x25.active? == true)
        for i in 0 .. tableau.length-1
           if(tableau[i].include?"2525")
                tableauDiff << tableau[i]

            end

        end

    end

    return tableauDiff

  end




end
