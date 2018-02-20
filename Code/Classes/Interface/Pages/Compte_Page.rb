
#require "Classes/Interface/Page.rb"

class Compte_Page < Page

  def initialize(monApp, header, enciennePage)

    super("Mon Compte",monApp, :vertical, header, enciennePage)

  end

end
