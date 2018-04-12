
class Score
  attr_reader :score

  def initialize()
    @score = 0
    @tentative = 0
    @sommeTotal = 0
  end

  def ajouteScore(temps)
    @tentative = @tentative + 1
    @sommeTotal = @sommeTotal + temps
    @score = @sommeTotal / @tentative
  end

  def changeScore(temp)
    @tentative = 1
    @sommeTotal = temp
    @score = @sommeTotal / @tentative
  end

  def getScore
    return @score
  end

end
