##
# Auteur LeNomDeLEtudiant
# Version 0.1 : Date : Tue Dec 12 19:44:04 CET 2017
#

require 'Classes/Joueur.rb'
require 'Classes/Grille.rb'
require 'Classes/case.rb'
#require 'Classes/Joueur.rb'
class MethodSauvegard


	def sauver(joueur)
		begin
				File.open("Sauvegarde/"+joueur.pseudo.to_s+".marshal", "w") {|nomFichier| @data = Marshal.dump(joueur,nomFichier) }

		rescue
			#ERREUR
			puts "pas reussi a sauver le joueur"
		end

	end

	def charger(pseudo)
		File.open("Sauvegarde/"+pseudo+".marshal","r") {|nomFichier|
			object = Marshal.load(nomFichier)
			return object
		}

	end


	def chargerLeaderBoard()
		tabJoueur = []

		Dir.foreach("Sauvegarde") do |fichier|
			 fichier = fichier.gsub(".marshal", '')

				if (!fichier.eql?(".")) && (!fichier.eql?("..")) && (!fichier.eql?(".DS_Store")) && (!fichier.eql?(".gitkeep"))then
       				object = charger(fichier)
       				tabJoueur << [object.pseudo, object.score.first.score.to_s, object.score.at(1).score.to_s, object.score.last.score.to_s]
     			 end



		end
		return tabJoueur
    end



end
