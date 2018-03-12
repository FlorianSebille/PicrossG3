class Didact
  def initialize
    def not_yet_implemented(object)
      puts "#{object.class.name} sent a signal!"
    end

    def on_di_p1_destroy(object)
      Gtk.main_quit()
    end

    def on_di_p2_destroy(object)
      Gtk.main_quit()
    end

    def on_di_p3_destroy(object)
      Gtk.main_quit()
    end

    def on_button2_clicked(object)
    	$di_p2.show
    	$di_p1.hide

    end


    def on_button1_clicked(object)
    	Gtk.main_quit()
    end

    def on_button4_clicked(object)
    	$di_p2.hide
    	$di_p3.show
    end

    def on_button5_clicked(object)
    	$di_p3.hide
    	$di_p2.show
    end


    def on_button6_clicked(object)
    	Gtk.main_quit()
    end

    def on_button3_clicked(object)
    	$di_p2.hide
    	$di_p1.show
    end


    main_window_res = 'Code/Classes/test.glade'

    builder = Gtk::Builder.new
    builder.add_from_file(main_window_res)

    # Attach signals handlers
    builder.connect_signals do |handler|
      begin
        method(handler)
      rescue
        puts "#{handler} not yet implemented!"
        method('not_yet_implemented')
      end
    end

    $di_p1 = builder.get_object('di_p1')
    b1=builder.get_object('button1')
    b1.override_background_color(:normal, Gdk::RGBA::new(1.0, 1.0, 1.0, 1.0))
    $di_p1.override_background_color(:normal, Gdk::RGBA::new(1.0, 1.0, 1.0, 1.0))
    $di_p2=builder.get_object('di_p2')
    $di_p2.override_background_color(:normal, Gdk::RGBA::new(1.0, 1.0, 1.0, 1.0))
    $di_p3=builder.get_object('di_p3')
    $di_p3.override_background_color(:normal, Gdk::RGBA::new(1.0, 1.0, 1.0, 1.0))
    $di_p1.show()
  end
end
