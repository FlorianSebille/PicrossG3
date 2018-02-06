load 'Klass.rb'
load 'Sauver.rb'


o = Klass.new("DIDOUTCH FISSON\n")

sv = Sauver.new
teste = sv.envoyerDonnees(o)

obj = sv.recevoirDonnees(teste)
obj.sayHello






