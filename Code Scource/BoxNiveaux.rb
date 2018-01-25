
load "ButtonImage.rb"

class BoxNiveaux < Gtk::ButtonBox

  def initialize(nbNiveaux)
    super(:horizontal)

    self.spacing = 10

    1.upto(nbNiveaux) { |indice|
      self.add(creationUnNiveau(indice), :expand => true, :fill => true)
    }
  end

  def creationUnNiveau(indice)
    niveau = Gtk::ButtonBox.new(:vertical)

    btn = ButtonImage.new("../Images/Niveau_aventure.png")

    labelNiveau= Gtk::Label.new

    chaine = "<span foreground=\"#0044FE\" font-desc=\"Apple Chancery Small-Caps 20\" > Nivau n°"
    chaine = chaine + indice.to_s
    chaine = chaine + "</span>"

    labelNiveau.set_markup(chaine)
    [btn, labelNiveau].each { |elem|
      niveau.add(elem)
    }
    return niveau
  end

end
