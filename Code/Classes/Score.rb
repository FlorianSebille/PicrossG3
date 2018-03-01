
class Score
  attr_reader :score
  
  def initialize()
    @score = 0
    @tentative = 0
    @sommeTotal = 0
  end

  def ajouteScore(unScore)
    @tentative = @tentative + 1
    @sommeTotal = sommeTotal + unScore
    @score = @sommeTotal / @tentative
  end

  def getScore
    return @score
  end
end
