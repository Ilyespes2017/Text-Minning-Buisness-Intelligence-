library("tm") # pour le text mining
library("SnowballC") # pour le text stemming
library("wordcloud") # générateur de word-cloud 
library("RColorBrewer") # Palettes de couleurs
library(textstem) #Lemmatisation
library(qdap) #mgsub
library(plyr)


# Question 1, 2, 3
chemin = "DB.txt"
data = read.csv(chemin, header = FALSE, sep = '\n', quote = "", stringsAsFactors = FALSE,
                encoding = "UTF-8")

df = data.frame(Titre = "", Auteur = "", Année = "",Revue = "", Index = "", Citation = "",
                Abstract = "", NbrAuteur = "", NbrCitation = "",stringsAsFactors = FALSE)

df = remplissage(data,df) #Appel fonction remplissage pour mettre les données propres en dataframe
df = subset(df, subset = !df$Abstract=="")
df = subset(df, subset = !df$Auteur=="")
df$Titre = removePunctuation(df$Titre)
df$Titre = gsub('\\b\\d+\\s','', df$Titre)
#Sauvegarde csv
write.csv2(df,"InfoArticle.csv",row.names = F)
