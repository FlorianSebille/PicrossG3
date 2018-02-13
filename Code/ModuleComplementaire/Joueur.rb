class Joueur

  #La class joueur contient un nom prenom pseudo date de naissance pour diférencier chaque joueur
  #elle contient aussi un nombre d'xp qui évolue en fonction des partie gagner et perdu
  #et un mot de passe pour securiser chaque joueur

  attr_reader :nom, :prenom, :dateDeNaissance, :pseudo, :xp, :mdp
  attr_writer :nom, :prenom, :dateDeNaissance, :pseudo

  private_class_method :new

  def Joueur.creer(unNom, unPrenom, unPseudo, unMDP, dateDeNaissance)
    new(unNom, unPrenom, unPseudo, unMDP, dateDeNaissance)
  end

  def initialize(unNom, unPrenom, unPseudo, unMDP, dateDeNaissance)
    @prenom, @nom, @naissance, @pseudo, @mdp, @xp, @grilles = unPrenom, unNom, dateDeNaissance, unPseudo, unMDP, 0, Array.new
  end

  def augementXp(unNombre)
    @xp += unNombre
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
