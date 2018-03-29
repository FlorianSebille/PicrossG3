
require "Classes/Interface/Page.rb"
require "Classes/Interface/Pages/Mode_Page.rb"


class Compte_Page < Page

  def initialize(monApp, header, enciennePage)

    super("Mon Compte",monApp, :vertical, header, enciennePage)
    self.spacing = 10

  end
end
