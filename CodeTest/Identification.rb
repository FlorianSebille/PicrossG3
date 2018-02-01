
class Identification < Gtk::Box

  attr_reader :label
  
  def initialize(frame)
    ##
    # Creation de la Gtk::Box
    super(:vertical)

    @frame = frame
    @label = Label.new("Identification", "EF2929")

    self.add(@label)

  end

end
