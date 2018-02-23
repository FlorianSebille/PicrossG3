class Joueur

  #La class joueur contient un nom prenom pseudo date de naissance pour diférencier chaque joueur
  #elle contient aussi un nombre d'xp qui évolue en fonction des partie gagner et perdu
  #et un mot de passe pour securiser chaque joueur

  attr_reader :nom, :prenom, :dateDeNaissance, :pseudo, :xp, :mdp, :grillesAventure, :grillesEntrainement, :grillesCompetition, :mode, :monde
  attr_writer :nom, :prenom, :dateDeNaissance, :pseudo, :grilles, :grillesAventure, :grillesEntrainement, :grillesCompetition, :mode, :monde

  private_class_method :new

  def Joueur.creer(unNom, unPrenom, unPseudo, unMDP, dateDeNaissance)
    new(unNom, unPrenom, unPseudo, unMDP, dateDeNaissance)
  end

  def initialize(unNom, unPrenom, unPseudo, unMDP, dateDeNaissance)
    @prenom, @nom, @naissance, @pseudo, @mdp, @xp, @mode, @monde = unPrenom, unNom, dateDeNaissance, unPseudo, unMDP, 0, 0, 1
    @grillesAventure = Hash.new
    @grillesEntrainement = Hash.new
    @grillesCompetition = Hash.new
    [@grillesEntrainement, @grillesCompetition].each { |grilles|
      initializeGrilles(grilles)
    }
    initializeAventure
  end

  def augementXp(unNombre)
    @xp += unNombre
  end

  def initializeGrilles(hashGrilles)
    Dir.foreach("../Grilles") do |fichier|
      fichier = fichier.gsub(".txt", '')
      if !fichier.eql?(".") && !fichier.eql?("..") && !fichier.eql?(".DS_Store") && (!hashGrilles.has_key?(fichier)) then
        hashGrilles[fichier] = nil
      end
    end
    return self
  end

  def choisirPartie(dificulte,taille)
    if dificulte.eql?(1) then
      difficulte = "facile"
    elsif difficulte.eql?(2) then
      difficulte = "facile"
    else difficulte = "difficile" end
    temp = Array.new
    Dir.foreach("../Grilles") do |fichier|
      fichier = fichier.gsub(".txt", '')
      if fichier.include?(difficulte.to_s) &&  fichier.include?(taille.to_s) then
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
        @grillesAventure[key] = [choisirPartie(res.first,res.last), nil]
      }
    }
  end

  def grilleAventure(monde, partie)
    key = monde.to_s + "-" + partie.to_s
    return @grillesAventure[key]
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
