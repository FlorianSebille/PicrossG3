##
# Cette class représente un contener qui possède :
# => Un Boutton avec une Image
# => Un label

require "Classes/Interface/Label.rb"
require "Classes/Interface/ButtonImage.rb"

class BoxButton < Gtk::ButtonBox

  attr_reader :btn
  ##
  # Création d'une nouvelle BoxButton avec +unIndice+ et +unTitre+
  #
  #
  def initialize(unIndice, unTitre, image)

    #attr_reader :btn

    super(:vertical)
    indice = unIndice

    @btn = ButtonImage.new(("../Images/" +image +".png"))
    @label = Label.new((unTitre + indice.to_s), "EF2929", "20")

    [@btn, @label].each { |elem|
      self.add(elem)
    }

  end

end
