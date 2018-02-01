##
# Auteur Pierre Jacoboni
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

class Modedejeu < Gtk::Window

    def initialize
        super

        set_title "Picross"
        signal_connect "destroy" do
            Gtk.main_quit
        end

        set_default_size 400, 300

        set_window_position Gtk::Window::Position::CENTER

        show
    end
end

Gtk.init
    window = Modedejeu.new
      #Creation des Boutons et label
     tab=Gtk::Table.new(9,3,true)
     window.add(tab)
     monLabel=Gtk::Label.new("Mode de jeu:")
     monBout1=Gtk::Button.new("Aventure")
     monBout2=Gtk::Button.new("Entrainement")
     monBout3=Gtk::Button.new("Compétition")
     image=Gtk::Image.new("acceuil.png")



     #on ajoute a la table les widgets
     tab.attach(monLabel,1,2,0,1)
     tab.attach(monBout1,1,2,3,4)
     tab.attach(monBout2,1,2,5,6)
     tab.attach(monBout3,1,2,7,8)
     tab.attach(image,0,1,0,1)


   window.show_all
Gtk.main
