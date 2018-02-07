
class PageMenu < Frame
  attr_reader :label, :btnHome

  def initialize(unTitre, monApp, sens)

    super(monApp, sens)

    @label = Label.new(unTitre, "EF2929", "40")

    @btnHome.signal_connect('clicked') {
      self.supprimeMoi
      # a changer si on veut revenir sur une autre page
      menu = Menu.new(monApp)
      menu.ajouteMoi
      @window.show_all
    }

    @hautPage.add(@label)

  end

end
