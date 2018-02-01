
load "Niveau.rb"

class BoxNiveaux < Gtk::Box


  def initialize(nbNiveaux, frame)
    super(:horizontal)

    self.spacing = 10

    1.upto(nbNiveaux) { |indice|
      self.add(Niveau.new(indice, frame), :expand => true, :fill => true)
    }
  end

end
