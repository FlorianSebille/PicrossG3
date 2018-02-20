
require "Classes/Interface/Page.rb"

class ModeCompetition_Page < Page

  def initialize(monApp, header, enciennePage)

    ##
    # Creation de la Gtk::Box
    super("Competition",monApp, :vertical, header, enciennePage)


  end

end
