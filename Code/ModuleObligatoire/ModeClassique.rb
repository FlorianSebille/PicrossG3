

class ModeClassique < Gtk::Notebook

  def initialize(monApp, unHeader)
    super()
    p tab_pos
    tab_pos=(Gtk::PositionType(LEFT))
    p tab_pos
    @window = monApp

    b1 = Gtk::Label.new("Facile")
    b2 = Gtk::Label.new("Moyen")


    append_page(b1, b1)
    #insert_page(0, b1, b1)
    #insert_page(1, b2, b2)
    #append_page(b2, b2)

    #prepend_page(b1, b1)
    #prepend_page(b2, b2)
    #set_menu_label(b1, b1)


  end

  ##
  # Methode pour ajouter l'objet actuelle a la fenetre
  def ajouteMoi
    @window.add(self)
  end

  def supprimeMoi
    @window.remove(self)
  end

  def detruitMoi
    self.destroy
  end

end
