
##
# Cette class représente un Label defini par une phrase et une couleur

class Label < Gtk::Label

  def initialize(phrase, couleur, taille)
    super()
    self.set_markup(construireChaine(phrase, couleur, taille))
  end

  def construireChaine(phrase, couleur, taille)
    chaine = "<span foreground=\"#"
    chaine = chaine + couleur
    chaine = chaine + "\" font-desc=\"Copperplate "
    chaine = chaine + taille
    chaine = chaine + "\" >"
    chaine = chaine + phrase
    chaine = chaine + "</span>"
    return chaine
  end

end
