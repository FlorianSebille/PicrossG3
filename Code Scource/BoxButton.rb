##
# Cette class représente un contener qui possède :
# => Un Boutton avec une Image
# => Un label


class BoxButton < Gtk::ButtonBox

  ##
  # Création d'une nouvelle BoxButton avec +unIndice+ et +unTitre+
  #
  #
  def initialize(unIndice, unTitre)

    #attr_reader :btn

    super(:vertical)
    indice = unIndice

    btn = ButtonImage.new("../Images/Niveau_aventure.png")
    label = Label.new((unTitre + indice.to_s), "EF2929")

    [btn, label].each { |elem|
      self.add(elem)
    }

  end

end
