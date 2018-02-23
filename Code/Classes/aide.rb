class Aide



  def Aide.nombreErreurs(grillej,grillef)
    c=0
    for i in (0..grillej.taille)
        for j in (0..grillej.taille)
          if((grillej.grille[i][j].etat==1) && (grillef.grille[i][j].etat==0))
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

      end while ( !((grillej.grille[ligne][colone].etat ==0 || grillej.grille[ligne][colone].etat ==2)&& grillef.grille[ligne][colone].etat == 1)  )

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
end
