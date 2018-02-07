
class PageMenu < Frame
  attr_reader :label, :hautPage, :btnHome

  def initialize(unTitre, monApp, sens)
    super(monApp, sens)

    @hautPage = Gtk::Box.new(:horizontal)
    @hautPage.spacing = 150

    @btnHome = ButtonImage.new("../Images/Home.png")
    @label = Label.new(unTitre, "EF2929", "40")

    @btnHome.signal_connect('clicked') {
      self.supprimeMoi
      # a changer si on veut revenir sur une autre page
      menu = Menu.new(monApp)
      menu.ajouteMoi
      @window.show_all
    }

    @hautPage.pack_start(@btnHome, :expand => false, :fill => true)

    @hautPage.add(@label)

    self.add(@hautPage, :expand => false, :fill => true)
  end

end
