
class PageMenu < Frame
  attr_reader :label, :btnHome
  attr_writer :joueur

  def initialize(unTitre, monApp, sens, header)

    super(monApp, sens, header)

    @label = Label.new(unTitre, "EF2929", "40")


    @header.btnHome.signal_connect('clicked') {
      # a changer si on veut revenir sur une autre page
      self.supprimeMoi
      menu = Menu.new(monApp, @header)
      menu.ajouteMoi
      @window.show_all
    }

    @header.btnCompte.signal_connect('clicked') {
      # a changer si on veut revenir sur une autre page
      self.supprimeMoi
      monCompte = MonCompte.new(monApp, @header)
      monCompte.ajouteMoi
      @window.show_all
    }

    @hautPage.add(@label, :expand => true, :fill => true)

  end

end
