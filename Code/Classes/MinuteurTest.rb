
require 'thread'
require 'gtk2'
require 'chronic'

class Minuteur

	attr_accessor :minuteur
	attr_accessor :label
	attr_accessor :malus

	#initialise le minuteur avec un temps (0 ou temps sauvegardé)
	def initialize(temps, window)
		@window = window
		@minuteur=temps
		@stop=1
		@malus=0
		@label= Gtk::Label.new(to_s)
		@thread
    #@iterator = Chrono::Iterator.new("30 * * * *")
	end

	#permet de changer la valeur du malus de temps générer à cause de l'aide
	def setMalus(monMalus)
		@malus+=monMalus
	end

	#permet de remettre le malus de temps à 0
	def malustozero()
		@malus=0
	end

	#permet de changer la variable stop afin de stopper le minuteur
	def setStop(bool)
		Thread.kill(@thread)
		@stop=bool
	end

	def to_s
			heures = @minuteur/3600
			minutes = (@minuteur - (heures*3600)) / 60
			secondes = @minuteur - (heures*3600) - (minutes*60)

			h = heures < 10 ? "0" + heures.to_s : heures.to_s
			m = minutes < 10 ? "0" + minutes.to_s : minutes.to_s
			s = secondes < 10 ? "0" + secondes.to_s : secondes.to_s

			return h + ":" + m + ":" + s
	end


	def setLabel

			@label.set_markup(to_s)
	end

	#lance le minuteur
	def start()

		@thread = Thread.new{
                loop{
                  sleep(1)
                  Chronic.parse('next second')
                  @minuteur += 1
                }
              }

		@thread.priority=5;
		@window.show_all
		return @minuteur
	end


end

Gtk.init
Time.now
window = Gtk::Window.new

m=Minuteur.new(0, window)


window.add(m.label)




#affiche la fenetre

window.show_all

t = Thread.new{m.start()}
t.join
Gtk.main
