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
class Grille

  attr_accessor:taille
  attr_accessor:grille
  attr_accessor:fich


  def initialize(taille,fich)

    @taille=taille-1
    @grille=[[]]
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
        if (!$joueur.grillesCompetition[@fich].eql?(nil)) then
          @grille = $joueur.grillesCompetition[@fich].last
        end
      end
    else
      if $joueur.grillesAventure.has_key?(@fich) then
        if (!$joueur.grillesAventure[@fich].last.eql?(nil)) then
          @grille = $joueur.grillesAventure[@fich].last
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

  def grilleToSave()

    if $joueur.mode.eql?(1) then
      $joueur.grillesEntrainement[@fich] = @grille
      data = $sv.sauver($joueur)
    elsif $joueur.mode.eql?(2) then
      $joueur.grillesCompetition[@fich][-1] = @grille
      data = $sv.sauver($joueur)
    else
      $joueur.grillesAventure[@fich][-1] = @grille
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
  def indiceLigne(i)
      tab=grCaseToGrille()
      tab1=[]
      c=0
      j=0
      tab[i].each do
      	while j<=@taille
      		if tab[i][j] == 0
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
    def indiceColone(i)
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
        if tab1[j] == 0
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
    grilleToSave()
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
         if @grille[i][j].etat != grillef.grille[i][j].etat
              return false
         end
       end
     end
     return true
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
    @d=Aide.ligneEvidente($grillefinal)
    @e=Aide.coloneEvidente($grillefinal)
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


    @msg=""
    @info=Gtk::Label.new("#{@msg}")
    vbox.add(@info)
    @info.set_text(@msg)



		hbox.add(@frame)

		aide.signal_connect('clicked') {
			@msg=Aide.nombreErreurs(jeu,$grillefinal)
      @info.set_text("nb erreur:#{@msg}")
		}
		aide2.signal_connect('clicked') {
      if jeu.jeuTermine($grillefinal)==false
			res=Aide.remplirCaseHasard(jeu,$grillefinal)
			active(res[0],res[1])
      else
        puts "jeu terminer"
      end
			#jeu.afficheToi()
		}
    aide3.signal_connect('clicked') {

      #jeu.rejouer()
      for i in (0..jeu.taille)
        for j in (0..jeu.taille)
          if jeu.grille[i][j].etat == 1
      			active(i,j)
          elsif jeu.grille[i][j].etat == 2
            active(i,j)
            active(i,j)
          end
        end
      end

      @d=Aide.ligneEvidente($grillefinal)
      @e=Aide.coloneEvidente($grillefinal)
		}
    aide1.signal_connect('clicked') {


      if @d[0] !=nil

        @msg= @d.delete_at(0)
        @info.set_text("la ligne:#{@msg}")
      else
        @msg="plus de ligne evidente"
        @info.set_text("#{@msg}")
      end

    }
    aide4.signal_connect('clicked') {
      if @e[0] !=nil

        @msg= @e.delete_at(0)
        @info.set_text("la colonne :#{@msg}")
      else
        @msg="plus de colone evidente"
        @info.set_text("#{@msg}")
      end

		}

		#list_c=$grillefinal.indiceColone(0)

    #indices pour les colonnes
    bol=false
		(1..@c).each do |i|
			list_c=$grillefinal.indiceColone(i-1).reverse
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
			list_l=$grillefinal.indiceLigne(i).reverse
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
				@list_but.push(Button.new(j,i,ind,@frame,jeu, self))
				ind+=1
			end
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

	def actInit(l,c)
		@list_but[l*@c+c].actInit
	end

	def frame
		return @frame
	end

  def enter(l,c)

      couleur = Gdk::RGBA.new(65535,0, 65535)
      bg=Gdk::RGBA.new(65535, 65535,     0)
      @tab_box_c[c].override_background_color(:normal, bg)
      @tab_box_l[l].override_background_color(:normal, bg)
      @tab_label_c[c+1].each do |i|
        i.override_color(:normal, couleur)
      end

      @tab_label_l[l+1].each do |i|
        i.override_color(:normal, couleur)
      end

  end

  def leave(l,c)

      couleur = Gdk::RGBA.new(0,0 ,0)
      @tab_box_c[c].override_background_color(:normal, nil)
      @tab_box_l[l].override_background_color(:normal, nil)
      @tab_label_c[c+1].each do |i|
        i.override_color(:normal, couleur)
      end


      @tab_label_l[l+1].each do |i|
        i.override_color(:normal, nil)
      end


  end


end

class Button


	attr_accessor :jeu

  def initialize(ligne,col,nb,frame,jeu,interjeu)
		@ligne=ligne-1
		@col=col-1
		@nb=nb
		@active=1
		@frame=frame
		@jeu=jeu
    @img=Gtk::Image.new(:file=>"Images/case_blanc_10.png")
    @img_hover
    @img_blanc='Images/case_blanc_10.png'
    @img_noir='Images/case_noir_10.png'
    @img_croix = 'Images/case_croix_10.png'
    @inter=interjeu
    @button=Gtk::EventBox.new().add(@img)
		#@button=Gtk::Button.new(:label => nil, :use_underline => nil, :stock_id => nil)
		#@jeu=jeu
		frame.attach(@button,@col+1,@col+2,@ligne+1,@ligne+2)



		#@button.style_context.add_provider(@white, Gtk::StyleProvider::PRIORITY_USER)
		#@button.set_relief(Gtk::RELIEF_NONE)
		@button.set_size_request(10,10)
		#@button.set_focus_on_click(false)
		@button.signal_connect('button-press-event') {|s,x|
			active(x.button)
		}
		#@button.signal_connect('enter') {
			#active
		#}

    @button.signal_connect('enter-notify-event') {
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
      @jeu.grilleToSave

		puts "button #{@nb}:(#{@col},#{@ligne}) active"
	end

  def actInit
		if @active==1 then
			@img.set_from_file (@img_noir)
      @active=2
		elsif @active==2
			@img.set_from_file (@img_croix)
      @active=3
    else
      @img.set_from_file (@img_blanc)
      @active=1
		end

		puts "button #{@nb}:(#{@col},#{@ligne}) active"

	end


end
