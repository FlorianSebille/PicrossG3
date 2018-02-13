##
# Auteur LeNomDeLEtudiant
# Version 0.1 : Date : Tue Dec 12 19:44:04 CET 2017
#

#require 'yaml'

class MethodSauvegard


	def sauver(joueur)
		begin
				File.open("../Sauvegarde/"+joueur.pseudo.to_s+".marshal", "w") {|nomFichier| @data = Marshal.dump(joueur,nomFichier) }

		rescue
			#ERREUR
			puts "pas reussi a sauver le joueur"
		end

	end

	def charger(pseudo)
		File.open("../Sauvegarde/"+pseudo+".marshal","r") {|nomFichier|
			object = Marshal.load(nomFichier)
			return object
		}

	end

end
