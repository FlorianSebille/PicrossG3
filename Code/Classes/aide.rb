class Aide



  def Aide.nombreErreurs(grillej,grillef)
    c=0
    for i in (0..grillej.taille)
        for j in (0..grillej.taille)
          if(((grillej.grille[i][j].etat==1) && (grillef.grille[i][j].etat==0)) || ((grillej.grille[i][j].etat==2) && (grillef.grille[i][j].etat==1)) )
            c+=1
          end
        end
    end
      return c
    end
    def Aide.jeuxFini(grillej,grillef)

      i=0
      j=0
      while i<=grillej.taille && grillej.grille[i][j].etat != grillef.grille[i][j].etat
          i +=1
          j+=1
      end
        return i
    end
   def Aide.remplirCaseHasard(grillej,grillef)
     c=Aide.jeuxFini(grillej,grillef)
     if (c == grillej.taille+1) then
       return 0
     else
      begin
        ligne=rand(0..grillej.taille)
        colone=rand(0..grillej.taille)

      end while ( !(grillej.grille[ligne][colone].etat ==0 && grillef.grille[ligne][colone].etat == 1)  )

       return [ligne,colone]
     end
    end

    def Aide.ligneEvidente(grillef)
        tab =grillef.tabIndicesLignes()
        tabbis=[]
        i=-1
        tab.each do |x|
          i +=1
          if x.inject(:+) + (x.size-1) == (grillef.taille)+1
            tabbis[i]= i
          end
        end
        tabbis.compact!
        return tabbis
    end

    def Aide.coloneEvidente(grillef)
      tab =grillef.tabIndicesColones()
      tab1=[]
      i=-1
      tab.each do |x|
          i +=1

        if   x.inject(:+) + (x.size-1) == (grillef.taille)+1
          tab1[i] = i
        end
      end
      tab1.compact!
      return tab1
    end





    ###### renvoit le tableau correspondant à ce qu'il est possible de  remplir sur la ligne i grâce aux indices
   def Aide.resoudreLigne(i,grillej,grillef,type)
      tabLigne=[]
      if type==2
        grillej.grille.each do |x|
            tabLigne.push(x[i].etat.clone)
        end
        tabLigne.compact!

        tabIndices = grillef.indiceColone(i)
      else
        for j in  grillej.grille[i]
            tabLigne.push(j.clone)
        end
        #tabLigne = grillej.grille[i]

        for j in (0..grillej.taille)

            tabLigne[j] = grillej.grille[i][j].etat
        end


        tabIndices = grillef.indiceLigne(i+1)
      end

      tabIndicesD = tabIndices.reverse
      tabLigneD = tabLigne.reverse

      placeTab = 0

      ################## DEBUT PARCOURS GAUCHE

      for i in(0..tabIndices.size-1)
        j = 1

        while (j<=tabIndices[i])
          if(tabLigne[placeTab]==2) #si on trouve une case marquée comme  blanche par le joueur
            placeTab+=1 #on se place après cette case
            j=0 #on recommence à placer les hypothèses
            for z in(0..placeTab) #et on supprime les hypothèses précédentes
              if (tabLigne[z] == -i-1) then tabLigne[z] = 0 end
            end
          else
            tabLigne[placeTab] = -i-1
            placeTab+=1
          end
        j+=1

        end


        placeTab+=1
      end

      ################## FIN PARCOURS GAUCHE
    #  puts placeTab
#print tabLigne
      ################## DEBUT PARCOURS DROITE

      placeTab=0
      for i in(0..tabIndicesD.size-1)
        j = 1
        while (j<=tabIndicesD[i])
          if(tabLigneD[placeTab]==2)  #si on trouve une case marquée comme  blanche par le joueur
            placeTab+=1 #on se place après cette case
            j=0 #on recommence à placer les hypothèses
            for z in(0..placeTab) #et on supprime les hypothèses précédentes
              if (tabLigneD[z] == -(tabIndicesD.size-1-i+1)) then tabLigneD[z] = 0 end
            end
          else
            tabLigneD[placeTab] = -(tabIndicesD.size-1-i+1)
            placeTab+=1
          end
          j+=1

        end

        placeTab+=1
      end
      ################## FIN PARCOURS DROITE
      ### fusion
      tabLigneD = tabLigneD.reverse
      #print tabLigne
      for i in(0..tabLigne.size-1)
        if(tabLigne[i] == tabLigneD[i] && tabLigne[i] <0)
          tabLigne[i] = 1

        else
          if(tabLigne[i] <0) then tabLigne[i] = 0 end
        end
      end
      return tabLigne
    end



      #retourne true si l'utilisateur peut être aidé sur la ligne i, false sinon
      def Aide.ligneAide(i,grillej,grillef,type)
        #print grillej.grille
        ligneFin = resoudreLigne(i,grillej,grillef,type)

        if type==1
          for i in (0..ligneFin.size-1)
            if ligneFin[i] != 0 then return true end
          end
        else
          for i in (0..ligneFin.size-1)
            if ligneFin[i] != 0 then return true end
          end
        end
        return false
      end






      #retourne toutes les lignes sur lesquelles l'utilisateur  peut être aidé
      def Aide.grilleAide(grillejj,grilleff,type)
        grillej=grillejj.clone
        grillef=grilleff.clone
        tab = []

        for i in (0..grillef.taille)
          if ligneAide(i,grillej,grillef,type)  then tab.push(i) end
        end

        return tab
      end


end
