##
# Auteur LeNomDeLEtudiant
# Version 0.1 : Date : Tue Dec 12 19:44:04 CET 2017
#

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
	end
	return donnee
end
