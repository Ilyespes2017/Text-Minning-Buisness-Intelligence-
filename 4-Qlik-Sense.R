##### Partie 2 : Qlik Sense

#Enregister dans la case de chaque auteur son nombre d'enregistrement
#Auteur le plus productif
productionAuteur = data.frame()
for(i in auteurs$Auteur){ # Il ya 33523 Auteurs
  y = strsplit(i,",")
  for(j in y){
   productionAuteur[j,1] = productionAuteur[j,1] + 1
   #productionAuteur[j,1] = 0
  }}
write.csv2(productionAuteur,"AuteurProductifs.csv")

#Articles les plus populaires :
popularitee = data.frame()
for(i in df$Citation){ # Il ya 60070 articles
  if(!is.na(i)){
  y = strsplit(i,",")
  for(j in y){
    popularitee[j,1] = popularitee[j,1] + 1
    #popularitee[j,1] = 0
  }
    
  }
  }
write.csv2(popularitee,"ArticlePopulaires.csv")
#3- Année explosifs
anneeExplosive = data.frame()
anneeExplosive = count(df,"Année")
write.csv2(anneeExplosif,"anneeExplosives.csv", row.names = F)
#4- Article Par revue
articleParRevue = count(df,"Revue")
write.csv2(articleParRevue,"articleParRevue.csv", row.names = F)


#distNombreCitation = count(df,"NbrCitation")


#Partie 3
df3 =subset(df, subset = df$Revue==c("SIGMOD ","SIGMOD Record",
                                     "SIGMOD Conference","STOC"
                                     ))
titres = subset(df3, select = c(Titre,id_Doc))
stock = titres[,2]
titres = titres[,-2]
titres$Titre = mgsub(c("-","The","using","the","with","for","with","and","job","use","per"),' ',titres$Titre)
part3 <- VCorpus(VectorSource(titres$Titre))
DocTerm3 = DocumentTermMatrix(part3)
m3 = as.matrix(DocTerm3)
DocTerm3  = data.frame(m3)


km = skmeans(DocTerm3,centers = 5)
km


