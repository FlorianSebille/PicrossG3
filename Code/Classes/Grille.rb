##
# Auteur LeNomDeLEtudiant
# Version 0.1 : Date : Tue Feb 06 07:02:24 CET 2018
#
#	Une grille de jeu est une matrice de case(une case a un seul etat: blanche, noir ou barré)
#	Une grille de jeu est lié à une matrice(de 1 et 0) qui constitue le resultat final du jeu
#	pour savoir si le joueur a gagné, on compare la matrice des cases à la matrice resultat
#	la grille de jeu peut être sauvegardeé pour être repris ulterieurement

require "Classes/case.rb"
require "Classes/aide.rb"
require "Classes/Minuteur.rb"

class Grille

  attr_accessor:taille
  attr_accessor:difficulte
  attr_accessor:grille
  attr_accessor:fich
  attr_accessor:temp


  def initialize(taille,fich)

    @taille=taille-1
    @difficulte = nil
    @grille=[[]]
    @temp = 0
    @fich=fich

    for i in (0..@taille)
      temp=[]
      for j in (0..@taille)
        temp[j]=Case.creer(i,j)
      end
    @grille[i]=temp
    end

    if (@fich.include?(".txt")) then
      fichTogrille()
    else
      saveTogrille()
      stringDificulte = fich[0..fich.index(/[0123456789]/)-1]
      if stringDificulte.eql?("facile") then @difficulte = 1 elsif stringDificulte.eql?("normal") then @difficulte = 2 else @difficulte = 3 end
    end
  end #end of initialize


  def fichTogrille()
    i=-1
    j=0
      f=File.open(@fich,"r")
      f.each_line do |l|
          i +=1
        l.chomp.each_char do |c|

          @grille[i][j].changerEtat(c.to_i)
          j +=1
        end
          j =0

      end
      f.close
      return self
  end #end of fichTogrille

  def saveTogrille()
    if $joueur.mode.eql?(1) then
      if $joueur.grillesEntrainement.has_key?(@fich) then
        if (!$joueur.grillesEntrainement[@fich].eql?(nil)) then
          @grille = $joueur.grillesEntrainement[@fich]
        end
      end
    elsif $joueur.mode.eql?(2) then
      if $joueur.grillesCompetition.has_key?(@fich) then

        if (!$joueur.grillesCompetition[@fich].last.eql?(nil)) then
          @grille = $joueur.grillesCompetition[@fich].last
          @temp = $joueur.grillesCompetition[@fich].at(1)
        end
      end
    else
      if $joueur.grillesAventure.has_key?(@fich) then
        if (!$joueur.grillesAventure[@fich].last.eql?(nil)) then
          @grille = $joueur.grillesAventure[@fich].last
          @temp = $joueur.grillesAventure[@fich].at(2)
        end
      end
    end
    return self
  end #end of fichTogrille

  def grilleTofich()

    f=File.open(@fich,"w")
  @grille.each do |x|
      temp=[]
    x.each do |i|
      temp.push(i.etat)
    end
    f.puts(temp.join.to_s)
  end
  f.close

  end#end of grilleTofich

  def grilleToSave(temp)
    @temp = temp
    if $joueur.mode.eql?(1) then
      $joueur.grillesEntrainement[@fich] = @grille
      data = $sv.sauver($joueur)
    elsif $joueur.mode.eql?(2) then
      $joueur.grillesCompetition[@fich][-1] = @grille
      data = $sv.sauver($joueur)
    else
      $joueur.grillesAventure[@fich][-1] = @grille
      $joueur.grillesAventure[@fich][2] = @temp
      data = $sv.sauver($joueur)
    end

  end#end of grilleToSave

  def afficheToi()
    @grille.each do |x|
      x.each do |i|
        print i.etat
      end
      puts
    end
  end #end of afficheToi

  def grCaseToGrille()
    tab=[[]]
    @grille.each do |x|
        temp=[]
      x.each do |y|
        temp.push(y.etat)
      end
      tab.push(temp)
    end
    return tab

  end
  def indiceLigne(i,bool)
      tab=grCaseToGrille()
      tab1=[]
      c=0
      j=0
      tab[i].each do
      	while j<=@taille
      		if tab[i][j] == 0||(bool&&tab[i][j] == 2)
      			j +=1
      		else
      			while tab[i][j] == 1
      				c +=1
      				j +=1
      			end
      			tab1.push(c)
      			c=0
      		end
      		end
      end
      tab.compact!
      return tab1

    end # end of indiceLigne

    def tabIndicesLignes()
      tab=[]
      for i in (0..@taille+1)
    		tab[i]=indiceLigne(i)
    	end
      tab.delete_at(0)
    	return tab
    end #end of tabIndicesLignes

    def indiceColone(i,bool)
      tab= grCaseToGrille()
      tab1=[]
      tab2=[]
      c=0
      j=0
      tab.each do |x|
          tab1.push(x[i])
      end
      tab1.compact!

      while j<=@taille
        if tab1[j] == 0||(bool&&tab1[j] == 2)
          j +=1
        else
          while tab1[j] == 1
            c +=1
            j +=1
          end
          tab2.push(c)
          c=0
        end
      end
      return tab2

    end #end of indiceColone


  def rejouer()
    for i in (0..@taille)
      for j in (0..@taille)
        @grille[i][j].changerEtat(0)
      end
    end
    grilleToSave(0)
  end # fin de rejouer


  def tabIndicesColones()
    tab=[]
    for i in (0..@taille)
      tab[i]= indiceColone(i)
    end
    #tab.delete_at(0)
    return tab
  end #end of tabIndicesColones

   def jeuTermine(grillef)
     for i in (0..@taille)
       for j in (0..@taille)

         if @grille[i][j].etat.eql?(0) && !grillef.grille[i][j].etat.eql?(0) then
            return false
         end
       end
     end
     return true
   end

   def raz
     for i in (0..@taille)
       for j in (0..@taille)
         @grille[i][j].etat = 0
       end
     end
   end

end #end of the class Grille



class Grillei



	def onDestroy
		puts "Fin de l'application"
		Gtk.main_quit
	end

	def onEvt(label,message)
		puts message
		label.set_text(message)
	end


	def initialize(l,c,jeu,frame)

    @d=Aide.grilleAide($grillejoueur,$grillefinal,1)
    @e=Aide.grilleAide($grillejoueur,$grillefinal,2)
		@grille = frame
		@l=l
		@c=c
    @tab_label_l=[[]]
    @tab_label_c=[[]]
    @tab_box_l=[]
    @tab_box_c=[]

		@frame=Gtk::Table.new(l+1,c+1,false)
		@frame.set_size_request(100,100)
		hbox=Gtk::Box.new(:horizontal,3)
		vbox=Gtk::Box.new(:vertical,3)
		@grille.add(hbox)
		hbox.add(vbox)

		aide=Gtk::Button.new(:label => "nombre d'erreurs", :use_underline => nil, :stock_id => nil)
    aide1=Gtk::Button.new(:label => "ligneEvidente", :use_underline => nil, :stock_id => nil)
		aide2=Gtk::Button.new(:label => "case au hasard", :use_underline => nil, :stock_id => nil)
    aide3=Gtk::Button.new(:label => "rejouer", :use_underline => nil, :stock_id => nil)
    aide4=Gtk::Button.new(:label => "colonneEvidente", :use_underline => nil, :stock_id => nil)

    $drawing_area = Gtk::DrawingArea.new

    $drawing_area.set_size_request(120,120)

		aide.set_property("width-request", 5)
		aide.set_property("height-request", 5)
		aide2.set_property("width-request", 5)
		aide2.set_property("height-request", 5)
    aide3.set_property("width-request", 5)
		aide3.set_property("height-request", 5)
    aide1.set_property("width-request", 5)
		aide1.set_property("height-request", 5)
    aide4.set_property("width-request", 5)
		aide4.set_property("height-request", 5)

		vbox.pack_start(aide, :expand => false, :fill => false, :padding =>2)
		vbox.pack_start(aide2, :expand => false, :fill => false, :padding =>2)
    vbox.pack_start(aide3, :expand => false, :fill => false, :padding =>2)
    vbox.pack_start(aide1, :expand => false, :fill => false, :padding =>2)
    vbox.pack_start(aide4, :expand => false, :fill => false, :padding =>2)
    #vbox.pack_start($drawing_area, :expand => false, :fill => false, :padding =>2)

    @msg=""
    @info=Gtk::Label.new("#{@msg}")
    @time=Gtk::Label.new("00:00")


    $m=Minuteur.new($grillejoueur.temp)

    @grille.hautPage.remove(@grille.label)
    @grille.hautPage.add($m.label, :expand => true, :fill => false)
    #@grille.hautPage.pack_end($drawing_area, :expand => true, :fill => true)
    #@grille.hautPage.add(@info, :expand => false, :fill => false)
    #vbox.pack_start($m.label, :expand => false, :fill => false, :padding =>2)


    $m.start




    vbox.add(@info)
    @info.set_text(@msg)



    hbox.add(@frame)


    $drawing_area.signal_connect("draw") do |widget, cr|
      cyan = Cairo::Color.parse("white")
      w = widget.allocated_width
      h = widget.allocated_height
      cr.set_source_rgb(cyan.red, cyan.green, cyan.blue)

      l=h/@l
      px=0
      py=0
      (0..@l-1).each do |i|
        (0..@l-1).each do |j|
            if $grillejoueur.grille[i][j].etat==0
              cr.set_source_rgb(1.0, 0, 0)
            else
              cr.set_source_rgb(0, 1.0, 0)
            end
            cr.rectangle(px,py,l,l)
            cr.fill
            px=px+l
        end
        px=0
        py=py+l
      end
    end

    #nb erreur
		aide.signal_connect('clicked') {
			@msg=Aide.nombreErreurs(jeu,$grillefinal)
      @info.set_text("nb erreur:#{@msg}")
      $m.ajout(10)
		}

    #hazard
		aide2.signal_connect('clicked') {
      if jeu.jeuTermine($grillefinal)==false
			 res=Aide.remplirCaseHasard(jeu,$grillefinal)
			 active(res[0],res[1])
      else
        puts "jeu terminer"
      end
      $m.ajout(10)

      ##
      # Fin de la partie
      if jeu.jeuTermine($grillefinal)==true then

        $joueur.partieFini($m.minuteur,jeu.taille, jeu.fich)

        sleep(3)

        @grille.supprimeMoi
        @grille.enciennePage.ajouteMoi
        #Monde_Page.new(indice, monApp, header, self)

      end
			#jeu.afficheToi()
		}

    #rejouer
    aide3.signal_connect('clicked') {

      #jeu.rejouer()
      for i in (0..jeu.taille)
        for j in (0..jeu.taille)
            if @list_but[convert(i,j)].rtActive!=1
      			   activeE(i,j,1)
            end
        end
      end

      $m.raz

      @d=Aide.grilleAide($grillejoueur,$grillefinal,1)
      @e=Aide.grilleAide($grillejoueur,$grillefinal,2)
		}

    #ligne evidente
    aide1.signal_connect('clicked') {
      tabj=[]
      equal=true
      while equal do
        if @d[0] !=nil
            tabj.clear
            indice=@d.delete_at(0)
            tab=Aide.resoudreLigne(indice,$grillejoueur,$grillefinal,1)
            $grillejoueur.grille[indice].each do |x|
                tabj.push(x.etat)
            end
            (0..tab.size-1).each do |l|
                if tab[l]==1&&tabj[l]!=1
                    equal=false
                end
            end
            if(!equal)
              trouve=true
              indc=0
              tab.each do |i|
                  if i==1
                     @list_but[convert(indice,indc)].activeE(2)
                  end
                  indc+=1
              end
            end
        else
            equal=false
            trouve=false
        end
      end
      if trouve
        @info.set_text("modifie sur ligne :#{indice+1}")
        $m.ajout(30)
      else
        @info.set_text("Pas de ligne evidente")
      end
    }

    #colone evidente
    aide4.signal_connect('clicked') {
      tabj=[]
      equal=true
      while equal do
        if @e[0] !=nil
            tabj.clear
            indice=@e.delete_at(0)
            tab=Aide.resoudreLigne(indice,$grillejoueur,$grillefinal,2)

            (0..$grillejoueur.taille).each do |x|
                tabj.push($grillejoueur.grille[x][indice].etat)
            end

            (0..tab.size-1).each do |l|
                if tab[l]==1&&tabj[l]!=1
                    equal=false
                end
            end

            if(!equal)

              trouve=true
              indc=0
              tab.each do |i|
                  if i==1
                     @list_but[convert(indc,indice)].activeE(2)
                  end
                  indc+=1
              end
            end
        else
            equal=false
            trouve=false
        end
      end
      if trouve
        @info.set_text("modifie sur colonne :#{indice+1}")
        $m.ajout(30)
      else
        @info.set_text("Pas de colonne evidente")
      end
		}

		#list_c=$grillefinal.indiceColone(0)

    #indices pour les colonnes
    bol=false
		(1..@c).each do |i|
			list_c=$grillefinal.indiceColone(i-1,false) ##i-1 pour col##
      list_c=list_c.reverse  ##reverse l_c##
			nb_c=Gtk::Box.new(:vertical,10)
      @tab_box_c.push(nb_c)
      @tab_label_c[i]=[]
			list_c.each do |j|
        n=Gtk::Label.new ("#{j}")
        @tab_label_c[i].push(n)
        #ajouter de padding
        if bol==false
          nb=5-@tab_label_c[i].size
          nb.times do
            nb_c.pack_start (Gtk::Label.new (" "))
          end
        end
        bol=true
        #ajouter de padding
				nb_c.pack_end (n)

			end
			@frame.attach(nb_c,i,i+1,0,1)
		end
    bol=false

    #indices pour les lignes
		(1..@l).each do |i|
			list_l=$grillefinal.indiceLigne(i,false)
      list_l=list_l.reverse
			nb_c=Gtk::Box.new(:horizontal,10)
      @tab_box_l.push(nb_c)
      @tab_label_l[i]=[]
			list_l.each do |j|
        n=Gtk::Label.new ("#{j}")
        @tab_label_l[i].push(n)
        #ajouter de padding
        if bol==false
          nb=5-@tab_label_l[i].size
          nb.times do
            nb_c.pack_start (Gtk::Label.new (" "))
          end
        end
        bol=true
        #ajouter de padding
				nb_c.pack_end (n)
			end
			@frame.attach(nb_c,0,1,i,i+1)
		end




		ind=0
		@list_but=[]
		(1..@c).each do |j|
			(1..@l).each do |i|
				@list_but.push(Button.new(j,i,ind,@frame,jeu, self, @grille))
				ind+=1
			end
		end

    paddinghor=Gtk::Box.new(:horizontal,10)
    paddingvert=Gtk::Box.new(:vertical,10)
    (0..3).each do
      paddingvert.pack_start (Gtk::Label.new(" "))
      paddinghor.pack_start (Gtk::Label.new(" "))
    end
    paddinghor.pack_start (Gtk::Label.new(" "))
    @frame.attach(paddingvert,49,50,49,50)
    @frame.attach(paddinghor,49,50,49,50)

	end


  def colorindice(x,y)

    couleur = Gdk::RGBA.new(65535,0, 0)
    noir = Gdk::RGBA.new(0,0, 0)
    list_l_f=$grillefinal.indiceLigne(x+1,true).reverse
    list_l_j=$grillejoueur.indiceLigne(x+1,true).reverse
    list_c_f=$grillefinal.indiceColone(y,true).reverse
    list_c_j=$grillejoueur.indiceColone(y,true).reverse

    ind=0

    @tab_label_l[x+1].each do |i|
        i.override_color(:normal, noir)
    end

    @tab_label_c[y+1].each do |i|
        i.override_color(:normal, noir)
    end

    list_l_j.each do |j|
       if list_l_f.include?(j)
          @tab_label_l[x+1][list_l_f.index(j)].override_color(:normal, couleur)
          list_l_f[list_l_f.index(j)]=-1
       end
       ind+=1
    end

    ind=0
    list_c_j.each do |j|
       if list_c_f.include?(j)
          @tab_label_c[y+1][list_c_f.index(j)].override_color(:normal, couleur)
          list_c_f[list_c_f.index(j)]=-1
       end
       ind+=1
    end

  end



	def show

		@grille.show_all
		# Quand la fenêtre est détruite il faut quitter
		@grille.signal_connect('destroy') {onDestroy}
		Gtk.main
	end

  def convert(l,c)
    return l*@c+c
  end

	def active(l,c)
		@list_but[l*@c+c].active(1)
	end

  def activeE(l,c,etat)
    @list_but[l*@c+c].activeE(etat)
  end

	def actInit(l,c,etat)
		@list_but[l*@c+c].actInit(etat)
	end

	def frame
		return @frame
	end

  def enter(l,c)

      couleur = Gdk::RGBA.new(65535,0, 65535)
      bg=Gdk::RGBA.new(65535, 65535,     0)
      @tab_box_c[c].override_background_color(:normal, bg)
      @tab_box_l[l].override_background_color(:normal, bg)


  end

  def leave(l,c)

      couleur = Gdk::RGBA.new(0,0 ,0)
      @tab_box_c[c].override_background_color(:normal, nil)
      @tab_box_l[l].override_background_color(:normal, nil)



  end


end

class Button


	attr_accessor :jeu

  def initialize(ligne,col,nb,frame,jeu,interjeu, fenetre)
		@ligne=ligne-1
		@col=col-1
		@nb=nb
		@active=1
		@frame=frame
		@jeu=jeu
    @img=Gtk::Image.new(:file=>"Images/case_blanc_10.png")
    @img_hover='Images/case10h.png'
    @img_blanc='Images/case_blanc_10.png'
    @img_noir='Images/case_noir_10.png'
    @img_croix = 'Images/case_croix_10.png'
    @inter=interjeu

    @button=Gtk::EventBox.new().add(@img)

    @fenetre = fenetre
		#@button=Gtk::Button.new(:label => nil, :use_underline => nil, :stock_id => nil)
		frame.attach(@button,@col+1,@col+2,@ligne+1,@ligne+2)


		#@button.set_size_request(10,10)

    @button.signal_connect('button-release-event') {|s,x|

      #@release=true
		}


		@button.signal_connect('button-press-event') {|s,x|
      active(x.button)

		}
    @button.signal_connect('enter-notify-event') {|s,x|
      enter
    }


    @button.signal_connect('leave-notify-event') {
      leave
    }


	end

  def enter
      @inter.enter(@ligne,@col)


  end

  def leave
      @inter.leave(@ligne,@col)
  end

  def hoverin

  end

  def hoverout

  end

  def activeE(etat)
     if etat==1 then
        @img.set_from_file (@img_blanc)
        @active=1
      elsif etat==2
        @img.set_from_file (@img_noir)
        @active=2
      elsif etat==3
        @img.set_from_file (@img_croix)
        @active=3
      end
      @jeu.grille[@ligne][@col].changerEtat(@active-1)
      @jeu.grilleToSave($m.minuteur)

      $drawing_area.queue_draw()
      puts "button #{@nb}:(#{@col},#{@ligne}) active par modifier etat"
      @inter.colorindice(@ligne,@col)
  end

  def active(button)
    if(button==1)
      if @active==1 then
        @img.set_from_file (@img_noir)
        @active=2
      elsif @active==2
        @img.set_from_file (@img_blanc)
        @active=1
      elsif @active==3
        @img.set_from_file (@img_noir)
        @active=2
      end
    end

    if(button==3)
      if @active==3
        @img.set_from_file (@img_blanc)
        @active=1
      elsif @active==1
        @img.set_from_file (@img_croix)
        @active=3
      elsif @active==2
        @img.set_from_file (@img_croix)
        @active=3
      end

    end



    @jeu.grille[@ligne][@col].changerEtat(@active-1)
    @jeu.grilleToSave($m.minuteur)
    $drawing_area.queue_draw()

		puts "button #{@nb}:(#{@col},#{@ligne}) active"
    @inter.colorindice(@ligne,@col)

    ##
    # Fin de la partie
    if @jeu.jeuTermine($grillefinal)==true then
      $joueur.partieFini($m.minuteur,@jeu.taille, @jeu.difficulte, @jeu.fich)
      @jeu.raz
      sleep(3)

      @fenetre.supprimeMoi
      @fenetre.enciennePage.ajouteMoi

    end

	end

  def actInit(etat)
		 if etat==1 then
        @img.set_from_file (@img_blanc)
        @active=1
      elsif etat==2
        @img.set_from_file (@img_noir)
        @active=2
      elsif etat==3
        @img.set_from_file (@img_croix)
        @active=3
      end
    $drawing_area.queue_draw()
		puts "button #{@nb}:(#{@col},#{@ligne}) active par init"
    @inter.colorindice(@ligne,@col)
	end

  def rtActive
    return @active
  end


end
