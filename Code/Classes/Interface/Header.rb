
##
# Cette class defini le Header de la fenetre de l'aplication

require "Classes/Interface/ButtonImage.rb"

class Header < Gtk::HeaderBar

  attr_reader :btnRetour, :btnHome, :btnCompte , :pseudo

  def initialize(monApp)
    super()
    # Titre de la fenêtre
    self.show_close_button = true
    self.has_subtitle = false
    self.pack_start(Gtk::Image.new(:file => "Images/Picross_logo.png", :size => :dialog))

    @window = monApp
    @boxButtons = Gtk::Box.new(:horizontal)
    @boxButtons.spacing = 10

    @btnRetour = ButtonImage.new("Images/Retour.png")
    @btnHome   = ButtonImage.new("Images/Home.png")
    @btnCompte   = ButtonImage.new("Images/Avatar.png")

    [@btnRetour, @btnHome, @btnCompte].each { |btn|
      @boxButtons.add(btn)
    }
    self.pack_end(@boxButtons)
  end

  def ajoutepseudo(sonPseudo)
    @pseudo = Label.new(sonPseudo, "000000","10")

    @boxButtons.add(@pseudo)
  end
  
  def retournepseudo()
  
	psd= @pseudo.text
	return psd
  
  end
  
end
