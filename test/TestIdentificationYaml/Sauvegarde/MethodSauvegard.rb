##
# Auteur LeNomDeLEtudiant
# Version 0.1 : Date : Tue Dec 12 19:44:04 CET 2017
#

<<<<<<< HEAD
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
=======
require 'yaml'

def sauver(nomFichier,joueurs)

	begin
			teste = charger(nomFichier)
			p teste
			if !teste.eql?(nil) then
				teste += joueurs
				p teste
			else teste = joueurs end
			p teste
			File.open("../Sauvegarde/"+nomFichier+".yaml", "w") {|out| out.puts teste.to_yaml }

	rescue
		#ERREUR
		puts "pas reussi a sauver les joueurs"
		nil
	end
end

def charger(nomFichier)
	begin
			donnee = (YAML.load_file (nomFichier+".yaml"))
	rescue
		#ERREUR
		puts "pas reussi a charger les joueurs"
		donnee = nil
>>>>>>> 7f91379a7fc8d02bb6d7f98054113c7d8620bfcd
	end

end
