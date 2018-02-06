
##
# Cette class defini le Header de la fenetre de l'aplication

class Header < Gtk::HeaderBar

  def initialize
    super()
    # Titre de la fenêtre
    self.show_close_button = true
    self.has_subtitle = false
    self.pack_start(Gtk::Image.new(:file => "../Images/Picross_logo.png", :size => :dialog))
  end
end
