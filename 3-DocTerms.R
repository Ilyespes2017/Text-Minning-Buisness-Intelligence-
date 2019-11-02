titresCorpusFinal <- VCorpus(VectorSource(titres[["1"]][["content"]]))

DocTerm = DocumentTermMatrix(titresCorpusFinal)
DocTerm <- removeSparseTerms(DocTerm, .999) # garder les elements qui figure en 0.1% (1060 variables)

m1 = as.matrix(DocTerm)

DocTerm  = data.frame(m1)
DocTerm$id_doc  = stock

#Boucle pour enlever les lignes vides
i=0
for(i in 1:nrow(DocTerm)){
  if(sum(DocTerm[i,1:length(DocTerm)-1]) == 0)
  {
    DocTerm = DocTerm[-c(i),]
  }
}
names = rownames(DocTerm)
termDoc = t(DocTerm)
termDoc = data.frame(termDoc)
colnames(termDoc) <- names

#CloudWord
termDoc2 = termDoc[-c(95),]
word_freq = sort(rowSums(termDoc2),decreasing = T)
TermPlusFrequent <- data.frame(terme = names(word_freq), freq = word_freq)
wordcloud(TermPlusFrequent$terme, TermPlusFrequent$freq,
           random.order = FALSE, colors = brewer.pal(8, 'Dark2'),)

write.csv2(DocTerm,"DocTerms.csv",row.names = FALSE)
write.csv2(termDoc,"TermsDocs.csv",row.names = FALSE)

#Garder que les auteurs et leurs id
auteurs = subset(df, select = c(id_Doc,Auteur))
write.csv2(auteurs, "auteur.csv", row.names = F)
