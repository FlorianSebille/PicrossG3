
require "Classes/Score.rb"
class Joueur

  #La class joueur contient un nom prenom pseudo date de naissance pour diférencier chaque joueur
  #elle contient aussi un score pour chaque niveau de difficulté dans le mode compétition qui évolue en fonction des parties jouées
  #d'une avancé dans le mode aventure
  #de hashs pour savegarder toutes c'est grilles dans chaques modes
  #et un mot de passe pour securiser chaque joueur

  attr_reader :nom, :prenom, :dateDeNaissance, :pseudo, :mdp, :grillesAventure, :grillesEntrainement, :grillesCompetition, :mode, :avanceAventure, :score
  attr_writer :nom, :prenom, :dateDeNaissance, :pseudo, :grilles, :grillesAventure, :grillesEntrainement, :grillesCompetition, :mode, :avanceAventure

  private_class_method :new

  def Joueur.creer(unNom, unPrenom, unPseudo, unMDP, dateDeNaissance)
    new(unNom, unPrenom, unPseudo, unMDP, dateDeNaissance)
  end

  def initialize(unNom, unPrenom, unPseudo, unMDP, dateDeNaissance)
    @prenom, @nom, @naissance, @pseudo, @mdp, @mode = unPrenom, unNom, dateDeNaissance, unPseudo, unMDP, 0
    @avanceAventure = [1,3]
    @score = [Score.new,Score.new,Score.new]
    @grillesAventure = Hash.new
    @grillesEntrainement = Hash.new
    @grillesCompetition = Hash.new
    initializeGrillesEntrainement
    initializeGrillesCompetition
    initializeAventure

  end

  def CalculeScore
    nouveauScore = [Score.new,Score.new,Score.new]
    @grillesCompetition.each { |key, valeur|
      if key.include?("facile") then
        nouveauScore.first.ajouteScore(valeur.first.score)

      elsif key.include?("normal") then
        nouveauScore.at(1).ajouteScore(valeur.first.score)
      else
        nouveauScore.last.ajouteScore(valeur.first.score)
      end
    }
    @score = nouveauScore
  end

  def initializeGrillesEntrainement
    Dir.foreach("Grilles") do |fichier|
      fichier = fichier.gsub(".txt", '')
      if !fichier.eql?(".") && !fichier.eql?("..") && !fichier.eql?(".DS_Store") && (!@grillesEntrainement.has_key?(fichier)) then
        @grillesEntrainement[fichier] = nil
      end
    end
    return self
  end

  def initializeGrillesCompetition
    Dir.foreach("Grilles") do |fichier|
      fichier = fichier.gsub(".txt", '')
      if !fichier.eql?(".") && !fichier.eql?("..") && !fichier.eql?(".DS_Store") && (!@grillesCompetition.has_key?(fichier)) then
        @grillesCompetition[fichier] = [Score.new, 0, nil]
      end
    end
    return self
  end

  def choisirPartie(dif,taille)
    if dif.eql?(1) then
      dif = "facile"
    elsif dif.eql?(2) then
      dif = "normal"
    else dif = "difficile" end
    temp = Array.new
    Dir.foreach("Grilles") do |fichier|
      fichier = fichier.gsub(".txt", '')
      if fichier.include?(dif.to_s) &&  fichier.include?(taille.to_s) then
        temp << fichier
      end
    end
    temp.shuffle
    return temp.first
  end

  def difficulte(monde, partie)
    difficulte = 1
    taille = 10

    if (partie.eql?(1) || partie.eql?(2)) then
      taille = 10
    elsif  partie.eql?(3) then
      taille = 15
    elsif partie.eql?(4) then
      taille = 20
    else
      taille = 25
    end

    if monde.eql?(1) then
      difficulte = 1
    elsif monde.eql?(2) then
      difficulte = 2
    else
      difficulte = 3
    end

    return [difficulte, taille]


  end


  def initializeAventure
    1.upto(3) { |monde|
      1.upto(5) { |partie|
        key = monde.to_s + "-" + partie.to_s
        res = difficulte(monde, partie)
        nomFich = choisirPartie(res.first,res.last)
        @grillesAventure[key] = [nomFich, Score.new, 0, nil]
      }
    }
  end

  def grilleAventure(monde, partie)
    key = monde.to_s + "-" + partie.to_s
    return @grillesAventure[key]
  end

  def partieFini(intScore, key)

    score = intScore

    if $joueur.mode.eql?(2) then
      @grillesCompetition[key].first.ajouteScore(score)
      @grillesCompetition[key][1] = 0
    elsif $joueur.mode.eql?(3) then
      @grillesAventure[key].at(1).ajouteScore(score)
      @grillesAventure[key][2] = 0
    end
  end


end
# Test

#j = Joueur.creer("sebille", "florian", "kiRozZ", "motDePasse", "17/04/1997")

#p j

#j.augementXp(10)
#j.augementXp(20)

#p j

#<Joueur:0x00007fd6820844a8 @prenom="florian", @nom="sebille", @naissance="17/04/1997", @pseudo="kiRozZ", @mDP="motDePasse", @xp=0>
#<Joueur:0x00007fd6820844a8 @prenom="florian", @nom="sebille", @naissance="17/04/1997", @pseudo="kiRozZ", @mDP="motDePasse", @xp=30>
