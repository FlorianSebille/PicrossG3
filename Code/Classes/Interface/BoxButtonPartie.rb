
require "Classes/Interface/BoxButton.rb"

class BoxButtonPartie < BoxButton

  def initialize(monde , partie, bloque)
    if bloque then
      super(partie, "Partie n°", "partie_verrous")
    else super(partie, "Partie n°", "partie") end

    @etoile1 = Gtk::Image.new(:file => "Images/Etoile.png", :size => :dialog)
    @etoile2 = Gtk::Image.new(:file => "Images/Etoile.png", :size => :dialog)
    @etoile3 = Gtk::Image.new(:file => "Images/Etoile.png", :size => :dialog)

    @boxEtoile = Gtk::Box.new(:horizontal)



    if($joueur.mode == 2) then

    score = $joueur.grillesCompetition(monde, partie).at(1).getScore

    elsif ($joueur.mode == 3) then

      score = $joueur.grilleAventure(monde, partie).at(1).getScore

      if score >= 10 && score < 20 then
        @boxEtoile.add(@etoile1, :expand => true, :fill => true)
      elsif score >= 20 && score < 30 then
        @boxEtoile.add(@etoile1, :expand => true, :fill => true)
        @boxEtoile.add(@etoile2, :expand => true, :fill => true)
      elsif score >= 30 then
        @boxEtoile.add(@etoile1, :expand => true, :fill => true)
        @boxEtoile.add(@etoile2, :expand => true, :fill => true)
        @boxEtoile.add(@etoile3, :expand => true, :fill => true)
      end

      self.add(@boxEtoile)
      self.reorder_child(@boxEtoile, 1)
    end

  end
end
