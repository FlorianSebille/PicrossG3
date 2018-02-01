
##
# Cette class représente un Label defini par une phrase et une couleur

class Label < Gtk::Label

  def initialize(phrase, couleur)
    super()
    self.set_markup(construireChaine(phrase, couleur))
  end

  def construireChaine(phrase, couleur)
    chaine = "<span foreground=\"#"
    chaine = chaine + couleur
    chaine = chaine + "\" font-desc=\"Copperplate 40\" >"
    chaine = chaine + phrase
    chaine = chaine + "</span>"
    return chaine
  end

end
