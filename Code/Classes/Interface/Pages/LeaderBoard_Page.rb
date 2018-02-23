require "Classes/Interface/Page.rb"
require "Classes/MethodSauvegard.rb"

class LeaderBoard_Page < Page

  def initialize(monApp, header, enciennePage)

    ##
    # Creation de la Gtk::Box
    super("LeaderBoard",monApp, :vertical, header, enciennePage)


    self.spacing = 10
    builder = Gtk::Notebook.new






#Tableau des scores 22lignes, 3 colonnes, pas homogènes

table = Array.new

for i in 0..2
    table[i] = Gtk::Table.new(11,3,false)
end

tableauGrille = Array.new
for l in 0..2
    for j in 0..2
        for i in 0..10
            tableauGrille[i] = Gtk::Frame.new()
            table[l].attach(tableauGrille[i],j,3,0,i+1)
        end
    end
end

tableauLabel = Array.new

for i in 0..2
    for k in 1..10
tableauLabel[k] = Gtk::Label.new(k.to_s)
table[i].set_row_spacing(k,20)
table[i].attach(tableauLabel[k],0,1,k,k+1)
    end
end

tableauTitreCol = Array.new
tableauTitreCol[0] = Gtk::Label.new("Place")
tableauTitreCol[1] = Gtk::Label.new("Nom")
tableauTitreCol[2] = Gtk::Label.new("Score")

tableauTitreCol1 = Array.new
tableauTitreCol1[0] = Gtk::Label.new("Place")
tableauTitreCol1[1] = Gtk::Label.new("Nom")
tableauTitreCol1[2] = Gtk::Label.new("Score")

tableauTitreCol2 = Array.new
tableauTitreCol2[0] = Gtk::Label.new("Place")
tableauTitreCol2[1] = Gtk::Label.new("Nom")
tableauTitreCol2[2] = Gtk::Label.new("Score")



    for j in 0..2
        table[0].attach(tableauTitreCol[j],j,j+1,0,1)
        table[1].attach(tableauTitreCol1[j],j,j+1,0,1)
        table[2].attach(tableauTitreCol2[j],j,j+1,0,1)
    end


   table[0].attach( Gtk::Label.new("Le bro David"),1,2,1,2)



tableauvBox = Array.new

#Ajout du titre, de la table et de la box horizontale a la box verticale
for i in 0..2
        tableauvBox[i] = Gtk::Box.new(:vertical, 50)
        tableauvBox[i].add(table[i])
        tableauvBox[i].border_width = 120
end


sauv = MethodSauvegard.new()
















builder.append_page_menu(tableauvBox[0], Gtk::Label.new("Facile"))

    builder.append_page(tableauvBox[1], Gtk::Label.new("Moyen"))

    builder.append_page(tableauvBox[2], Gtk::Label.new("Difficile"))

    self.add(builder)

  end
end
