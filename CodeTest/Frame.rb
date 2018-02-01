

class Frame < Gtk::Box

  def initialize(monApp)

    ##
    # Creation de la Gtk::Box
    super(:vertical)
    self.spacing = 50

    @window = monApp

  end

end
