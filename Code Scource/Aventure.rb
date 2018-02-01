begin
  require 'rubygems'
 rescue LoadError
end

require 'gtk3'
require "thread"

Gtk.init

load "Header.rb"
load "Label.rb"
load "ButtonImage.rb"

load "BoxNiveaux.rb"

def onDestroy
	puts "Fin de l'application"
	Gtk.main_quit
end


if ARGV.size.eql?(0) then

	monApp = Gtk::Window.new

	# Titre de la fenêtre
	header = Header.new

	# Taille de la fenêtre
	monApp.set_default_size(700,400)
	# Réglage de la bordure
	monApp.border_width=5
	# On ne peut pas redimensionner
	monApp.set_resizable(true)
	# L'application est toujours centrée
	monApp.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)

  frame=Gtk::Box.new(:vertical)
  frame.spacing = 50

  labelAventure = Label.new("Aventure", "EF2929")

  boxNiveaux = BoxNiveaux.new(3, frame)

  frame.add(labelAventure)
  frame.add(boxNiveaux)

  monApp.add(frame)

	monApp.titlebar = header
	monApp.show_all
	# Quand la fenêtre est détruite il faut quitter
	monApp.signal_connect('destroy') {onDestroy}
	Gtk.main
else
	puts "Usage Error O argument pour le jeu du S6"
end
