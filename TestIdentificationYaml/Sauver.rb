class Sauver

	@file
	@obj


	def initialize()
		@file = File.open("sauvegarde.marshal", "w")
	end

	def envoyerDonnees(donnees)

		@data = Marshal.dump(donnees, @file)
		p @data
		return p

	end

	def recevoirDonnees(teste)
		@obj = Marshal.load(@teste)
		return @obj
	end


end