
class Score
  attr_reader :score

  def initialize()
    @score = 0
    @tentative = 0
    @sommeTotal = 0
  end

  def ajouteScore(unScore)
    @tentative = @tentative + 1
    @sommeTotal = @sommeTotal + unScore
    @score = @sommeTotal / @tentative
  end

  def getScore
    return @score
  end
end



#  cette classe permet de determiner le score d'un utilisateur en fonction de la taille de la grille et du timer( exprimer en seconde )
# exemple d'utiliation de la classe
# p Score.calculerScore(15, 900) affiche 16

class CalculerScore
	# une methode de classe
	# prend en paramètre taille de la grille et le nombre de seconde fournit par le timer
	# retourne un entier
	def CalculerScore.calculerScore(taille, timer)
		return (1000*taille) / timer
	end
end # Marqueur de fin de classe CalculerScore
