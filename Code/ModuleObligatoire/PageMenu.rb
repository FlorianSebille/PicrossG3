
class PageMenu < Frame
  attr_reader :label

  def initialize(unTitre, monApp, sens)
    super(monApp, sens)
    @label = Label.new(unTitre, "EF2929", "40")

    self.hautPage.add(@label)
  end

end
