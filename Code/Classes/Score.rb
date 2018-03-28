
class Score
  attr_reader :score

  def initialize()
    @score = 0
    @tentative = 0
    @sommeTotal = 0
  end

  def ajouteScore(temps, difficulter, nbCases)
    @tentative = @tentative + 1
    @sommeTotal = @sommeTotal + calculerScore(temps, difficulter, nbCases)
    @score = @sommeTotal / @tentative
  end

  def getScore
    return @score
  end

  def max(a , b)
    if(a >= b) then
      return a
    else return b end
  end

  def calculerScore(temps, difficulter, nbCases)
    p temps
    p temps * (difficulter * difficulter)
    teste = max( temps * (difficulter * difficulter) / 10, (difficulter * difficulter) )
    p teste
    return teste
	end
end
