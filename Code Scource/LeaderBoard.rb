
require 'gtk3'


Gtk.init

def onDestroy
	Gtk.main_quit
end




#set la fenetre
window = Gtk::Window.new

window.set_default_size(600,600)

window.set_title("LeaderBoard")

window.set_window_position(Gtk::Window::POS_CENTER_ALWAYS)


#Set une box verticale qui contient le titre, le tableau et les boutons
vBox = Gtk::VBox.new(false,50)

#Titre
titre = Gtk::Label.new("LEADERBOARD")

#Tableau des scores 22lignes, 3 colonnes, pas homogènes
table = Gtk::Table.new(22,3,false)

#1ere colonne
titreCol1=Gtk::Label.new("Nom")
table.attach(titreCol1,1,2,0,1)

#2emecolonne
titreCol2=Gtk::Label.new("Difficulté")
table.attach(titreCol2,2,3,0,1)

#3eme colonne
titreCol3=Gtk::Label.new("Score")
table.attach(titreCol3,3,4,0,1)

table.set_row_spacing(0,30)

l1=Gtk::Label.new("1")
table.set_row_spacing(1,20)
table.attach(l1,0,1,1,2, Gtk::EXPAND)

l2=Gtk::Label.new("2")
table.set_row_spacing(2,20)
table.attach(l2,0,1,2,3, Gtk::EXPAND)

l3=Gtk::Label.new("3")
table.set_row_spacing(3,20)
table.attach(l3,0,1,3,4, Gtk::EXPAND)

l4=Gtk::Label.new("4")
table.set_row_spacing(4,20)
table.attach(l4,0,1,4,5)

l5=Gtk::Label.new("5")
table.set_row_spacing(5,20)
table.attach(l5,0,1,5,6)

l6=Gtk::Label.new("6")
table.set_row_spacing(6,20)
table.attach(l6,0,1,6,7)

l7=Gtk::Label.new("7")
table.set_row_spacing(7,20)
table.attach(l7,0,1,7,8)

l8=Gtk::Label.new("8")
table.set_row_spacing(8,20)
table.attach(l8,0,1,8,9)



pseudo1=Gtk::Label.new("Steevfyer")
table.set_row_spacing(1,20)
table.attach(pseudo1,1,2,1,2)

pseudo2=Gtk::Label.new("Didoutch")
table.set_row_spacing(1,20)
table.attach(pseudo2,1,2,2,3)

pseudo3=Gtk::Label.new("DavidGoodEnough")
table.set_row_spacing(1,20)
table.attach(pseudo3,1,2,3,4)



difficulteF=Gtk::Label.new("Facile")
table.set_row_spacing(1,20)
table.attach(difficulteF,2,3,1,2)

difficulteF=Gtk::Label.new("Facile")
table.set_row_spacing(1,20)
table.attach(difficulteF,2,3,2,3)

difficulteF=Gtk::Label.new("Facile")
table.set_row_spacing(1,20)
table.attach(difficulteF,2,3,3,4)




score=Gtk::Label.new("1200")
table.set_row_spacing(1,20)
table.attach(score,3,4,1,2)

score=Gtk::Label.new("900")
table.set_row_spacing(1,20)
table.attach(score,3,4,2,3)

score=Gtk::Label.new("400")
table.set_row_spacing(1,20)
table.attach(score,3,4,3,4)




#Box horizontale pour contenir les boutons a coté
hBox = Gtk::HBox.new(true)

#Instanciation des 3 boutons
bFacile = Gtk::RadioButton.new('Facile')
bFacile.active=true
bMoyen = Gtk::RadioButton.new(bFacile,'Moyen')
bDifficile = Gtk::RadioButton.new(bFacile,'Difficile')

#Ajout des 3 boutons a la box horizontale
hBox.pack_start(bFacile, true, false, 0)
hBox.pack_start(bMoyen, true, false, 0)
hBox.pack_start(bDifficile, true, false, 0)

#Ajout du titre, de la table et de la box horizontale a la vox verticale
vBox.pack_start(titre,false, false, 0)
vBox.pack_start(table,false, false,0)
vBox.pack_start(hBox,false, false, 0)

#Ajout box verticale a la fenetre
window.add(vBox)


window.show_all
window.signal_connect('destroy'){
	onDestroy
}


Gtk.main


