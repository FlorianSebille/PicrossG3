
#require "Classes/Interface/Page.rb"
require "Classes/Interface/ModeClassique.rb"

class ModeEntrainement_Page < Page

  def initialize(monApp, header, enciennePage)

    ##
    # Creation de la Gtk::Box
    super("Mode Entrainement",monApp, :vertical, header, enciennePage)


    self.spacing = 10

    builder = Gtk::Notebook.new

    builder.append_page_menu( Gtk::Label.new("Facile"), Gtk::Label.new("Facile"))

    builder.append_page( Gtk::Label.new("Moyen"), Gtk::Label.new("Moyen"))

    builder.append_page( Gtk::Label.new("Difficile"), Gtk::Label.new("Difficile"))

    self.add(builder)

    
  end

end
