
##
# Cette class représente un Boutton contenant une image

class ButtonImage < Gtk::Button

  def initialize(chemin)
    super(:use_underline => true)
    self.image=(Gtk::Image.new(:file => chemin, :size => :dialog))
    focus_hadjustment=(:start)
  end
end
