
load "BoxPartie.rb"
load "BoxButton.rb"

##
# Cette class représente un Niveau dans les menus de l'apli

class Niveau < BoxButton

  ##
  # Création d'un nouveau Niveau
  #
  def initialize(unIndice, uneFrame)

    super(unIndice, "Niveau n°")

    self.each {|elem|
      if elem.class.eql?(ButtonImage) then
        elem.signal_connect('clicked') {
          uneFrame.each { |elem|
            uneFrame.remove(elem)
          }
          labelNiveau = Label.new(("Niveau n°"+unIndice.to_s), "EF2929")
          boxPartie = BoxPartie.new(uneFrame)
          uneFrame.add(labelNiveau)
          uneFrame.add(boxPartie)
        }
      end
    }

  end


end
