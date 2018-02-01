
def creationAceuille
  self.destroy
  self=Gtk::Box.new(:vertical)
  self.spacing = 10

  bouton1 = Gtk::Box.new(:horizontal)
  bouton2 = Gtk::Box.new(:horizontal)

	#creation des boutons de demarage
  btnConnexion = Gtk::Button.new(:label => "Connexion", :use_underline => true)
  btnCreerCompte = Gtk::Button.new(:label => "Creer un compte", :use_underline => true)

  bouton1.add(btnConnexion, :expand => true, :fill => false)
  bouton2.add(btnCreerCompte, :expand => true, :fill => false)

  self.add(bouton1)
  self.add(bouton2)
end
