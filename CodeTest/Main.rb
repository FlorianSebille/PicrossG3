begin
  require 'rubygems'
 rescue LoadError
end

$LOAD_PATH.unshift File.dirname(__FILE__)

require 'gtk3'
require "thread"
require "minitest"

Gtk.init

##
# Module Obligatoire
require "Frame.rb"
require "Header.rb"
require "Label.rb"
require "ButtonImage.rb"
#require ""

##
# Module Complementaire
require "Identification.rb"

def onDestroy
	puts "Fin de l'application"
	Gtk.main_quit
end

def configureMonApp(uneApp)
  ##
  # Taille de la fenêtre
	uneApp.set_default_size(700,400)
	##
  # Réglage de la bordure
	uneApp.border_width=5
	##
  # On ne peut pas redimensionner
	uneApp.set_resizable(true)
	##
  #L'application est toujours centrée
	uneApp.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)
end

if ARGV.size.eql?(0) then
  ##
  # Creation de la fenetre et configuration
  monApp = Gtk::Window.new
  configureMonApp(monApp)

  # Titre de la fenêtre
	header = Header.new


  ######DEBUT#########

  ##
  # Box principale
  frame = Frame.new(monApp)


  ident = Identification.new(frame)


  frame.add(ident)

  monApp.add(frame)

  ######FIN########


  ##
  # Ajout du header a la fenetre
  monApp.titlebar = header

	monApp.show_all

	##
  #Quand la fenêtre est détruite il faut quitter
	monApp.signal_connect('destroy') {onDestroy}

	Gtk.main

else
	puts "Usage Error O argument pour le Picross"
end
