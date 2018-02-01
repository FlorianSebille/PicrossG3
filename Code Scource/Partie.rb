
load "BoxButton.rb"

##
# Cette class représente une Partie dans les menus de l'apli

class Partie < BoxButton

  def initialize(unIndice, uneFrame)

    super(unIndice, "Partie n°")

    self.each {|elem|
      if elem.class.eql?(ButtonImage) then
        elem.signal_connect('clicked') {
          uneFrame.each { |elem|
            uneFrame.remove(elem)
          }
        }
      end
    }

  end


end
