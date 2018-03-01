
#require "Classes/Interface/Page.rb"
require "Classes/Interface/ModeClassique.rb"

class ModeEntrainement_Page < Page

  def initialize(monApp, header, enciennePage)

    ##
    # Creation de la Gtk::Box
    super("Mode ModeEntrainement",monApp, :vertical, header, enciennePage)


    self.spacing = 10

    
  end

end
