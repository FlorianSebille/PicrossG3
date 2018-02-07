##
# Auteur LeNomDeLEtudiant
# Version 0.1 : Date : Tue Dec 12 19:44:04 CET 2017
#

#require 'yaml'

class MethodSauvegard


	def sauver(nomFichier,joueurs)
		begin
				print"YOOO"
				File.open("../Sauvegarde/"+nomFichier+".marshal", "r+") {|nomFichier| @data = Marshal.dump(joueurs,nomFichier) }
				#return @data

		rescue
			#ERREUR
			puts "pas reussi a sauver les joueurs"
			nil
		end

	end

	def charger(nomFichier)
		begin

			object = nil
			print("COUCOU")
			File.open("../Sauvegarde/"+nomFichier+".marshal","r+") {|nomFichier| 
				print"JE PASSe"
				object = Marshal.load(nomFichier)
				return object
			}
				
		rescue
			#ERREUR
			puts "pas reussi a charger les joueurs"
		end
	end

end