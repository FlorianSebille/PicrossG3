
require 'thread'
require 'gtk2'

class Minuteur

	attr_accessor :minuteur
	attr_accessor :label
	attr_accessor :malus
	
	#initialise le minuteur avec un temps (0 ou temps sauvegardé)
	def initialize(temps)
		@minuteur=temps
		@stop=1
		@malus=0
		@label= Gtk::Label.new(to_s)

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
	
			@label.set_text(to_s)
			@label.show_all
	end

	#lance le minuteur
	def start()

		t1 = Thread.new{loop{sleep(1);@minuteur+=1;setLabel}}

=begin 	t2 = Thread.new{
			loop{
				set_text(" entrez un malus");
				malusTemps=gets;
				setMalus(malusTemps.to_i);
				@minuteur+=@malus;
				malustozero()
				set_text("le minuteur doit il s'arreter ? (0 si oui 1 sinon)");
				arreter=gets;
				setStop(arreter.to_i)
			}
			
	}
=end
		
		
		t1.priority=5;
       # t2.priority=30;
        
		
		while(@stop != 0)do
			sleep(1)
		end


		Thread.kill(t1)
		#Thread.kill(t2)
		
		return @minuteur
	end
	
	
end


Gtk.init 

window = Gtk::Window.new

m=Minuteur.new(0)


window.add(m.label)




#affiche la fenetre

window.show_all

Gtk.main
m.start()