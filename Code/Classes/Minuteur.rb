
require 'thread'
require 'gtk3'

class Minuteur

	attr_accessor :minuteur
	
	#initialise le minuteur avec un temps (0 ou temps sauvegardé)
	def initialize(temps,label)
		@minuteur=temps
		@stop=1
		@malus=0
		@label=label

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

	#lance le minuteur
	def start()
		t1 = Thread.new{loop{@label.set_text(@minuteur);sleep(1);@minuteur+=1}}

#		t2 = Thread.new{
#			loop{
#				puts " entrez un malus";
#				malusTemps=gets;
#				setMalus(malusTemps.to_i);
#				@minuteur+=@malus;
#				malustozero()
#				puts "le minuteur doit il s'arreter ? (0 si oui 1 sinon)";
#				arreter=gets;
#				setStop(arreter.to_i)
#			}
#			
#		}

		
		
		t1.priority=5;
 #       t2.priority=30;
        
		
		while(@stop != 0)do
			sleep(1)
		end


		Thread.kill(t1)
#		Thread.kill(t2)
		
		return @minuteur
	end
	
	
end

