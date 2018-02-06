##
# Auteur LeNomDeLEtudiant
# Version 0.1 : Date : Tue Dec 12 19:44:04 CET 2017
#

#require 'yaml'

class MethodSauvegard



	def sauver(nomFichier,joueurs)
		begin
				print"YOOO"
				File.open("../Sauvegarde/"+nomFichier, "wb") {|nomFichier| nomFichier.write(Marshal.dump(joueurs))}
		rescue
			#ERREUR
			puts "pas reussi a sauver les joueurs"
			nil
		end

	end

	def charger(data)
		begin
				File.open("../Sauvegarde/"+nomFichier, "wb"){
					print("CCCCCC")
					obj = Marshal.load(data)
					print obj
				}
				
		rescue
			#ERREUR
			puts "pas reussi a charger les joueurs"
			donnee = nil
		end
	end

end