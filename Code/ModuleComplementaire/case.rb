class Case



  attr_accessor:i
  attr_accessor:j
  attr_accessor:etat



    private_class_method:new

    def Case.creer(x,y)
      new(x,y)
    end

    def initialize(x,y)
      @i=x
      @j=y
      @etat=0
    end

    def jouerCase()
      if self.etat == 0
        @etat = 1
      else
        @etat=0
      end
    end
    def changerEtat(etat)
      @etat = etat
    end
    def to_s
      return @etat
    end
end
