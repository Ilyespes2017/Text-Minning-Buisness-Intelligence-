#Question 4  "#Matrice document Terme"

#Garder que les titres et leurs id
titres = subset(df, select = c(Titre,id_Doc))
###Nettoyage###

titres$Titre = mgsub(c("-","about","About","The","All","all","Job","using","the","with","for","with","and","job","use","per"),' ', titres$Titre)
titres$Titre = lemmatize_strings(titres$Titre)
titres$Titre = gsub('\\b\\d+\\s','', titres$Titre)
stock = titres$id_Doc

titres <- VCorpus(VectorSource(titres))
titres = nettoyage(titres) # Function pour nettoyer
