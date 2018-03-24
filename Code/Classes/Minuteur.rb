
require "Classes/Interface/Label.rb"

class Minuteur

	attr_accessor :minuteur
	attr_accessor :label
	attr_accessor :malus

	#initialise le minuteur avec un temps (0 ou temps sauvegardé)
	def initialize(temps)
		@minuteur=temps
		@label= Label.new(to_s, "EF2929", "40")
		@pause =false

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

			@label.set_markup("<span foreground=\"#EF2929\" font-desc=\"Copperplate 40\"> #{to_s unless @minuteur==0}</span>")

	end

	#lance le minuteur
	def start
		@thread = GLib::Timeout.add_seconds(1){
				@minuteur+=1
				setLabel
		}


		#@thread.priority=5;
		#t2.priority=30;




		return @minuteur
	end

	def raz
		@minuteur = 0
	end

	def ajout(n)
		@minuteur+=n
	end

end
