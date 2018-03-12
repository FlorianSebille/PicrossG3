
require 'thread'
require 'gtk3'

class Minuteur

	attr_accessor :minuteur
	attr_accessor :label
	attr_accessor :malus

	#initialise le minuteur avec un temps (0 ou temps sauvegardé)
	def initialize(temps)
		@minuteur=temps
		@malus=0
		@label= Gtk::Label.new(to_s)
		@pause =false

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
	def setStop()
		@thread.kill
		return to_s
	end
	
	def toggle
		@pause = !@pause
		if @thread.status =='sleep'
				@thread.run
		end
	end

	#check si le timer tourne 
	def running
	 	 @pause
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

			@label.set_markup("<b> #{to_s unless @minuteur==0}</b>")
			
	end

	#lance le minuteur
	def start()

		@thread = Thread.new{
							while true do
				
								sleep(1)
								@minuteur+=1
								setLabel
								
							end
							
							}

		t2 = Thread.new{
			loop{
				print(" entrez un malus");
				malusTemps=gets;
				setMalus(malusTemps.to_i);
				@minuteur+=@malus;
				malustozero()
				print("le minuteur doit il s'arreter ? ");
				arreter=gets;
				if(arreter.to_i == 1)then
					setStop
					t2.kill
				end
			}
		}


		
		#@thread.priority=5;
		#t2.priority=30;


		
		
		return @minuteur
	end


end


Gtk.init

window = Gtk::Window.new

m=Minuteur.new(0)


window.add(m.label)




#affiche la fenetre



m.start()


window.show_all

Gtk.main