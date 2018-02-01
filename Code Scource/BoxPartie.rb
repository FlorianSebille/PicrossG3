
load "Partie.rb"

class BoxPartie < Gtk::Box

  def initialize(frame)

    super(:horizontal)

    self.spacing = 10

    1.upto(5) { |indice|
      self.add(Partie.new(indice, frame), :expand => true, :fill => true)
    }
  end


end
