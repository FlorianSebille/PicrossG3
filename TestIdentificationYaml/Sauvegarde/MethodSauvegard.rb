##
# Auteur LeNomDeLEtudiant
# Version 0.1 : Date : Tue Dec 12 19:44:04 CET 2017
#

require 'yaml'

def sauver(nomFichier,joueurs)
	begin
			File.open("../Sauvegarde/"+nomFichier+".yaml", "w") {|out| out.puts joueurs.to_yaml }
	rescue
		#ERREUR
		puts "pas reussi a sauver les joueurs"
		nil
	end
end

def charger(nomFichier)
	begin
			donnee = (YAML.load_file nomFichier+".yaml")
	rescue
		#ERREUR
		puts "pas reussi a charger les joueurs"
		donnee = nil
	end
	return donnee
end
