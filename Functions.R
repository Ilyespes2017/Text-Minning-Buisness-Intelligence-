remplissage <- function(X, df){

  j = last = 0
  for(i in X[,1]){
    #Titre
    if(startsWith(i,"#*")){
      last = "*"
      j = j+1
      df[j,1] = substr(i,3,nchar(i))
      
    }
    
    #Auteur
    else if(startsWith(i,"#@") ){
      df[j,2] = substr(i,3,nchar(i))
      last = "@"
    }
    
    #Année 
    else if(startsWith(i,"#t")){
      df[j,3] = substr(i,3,nchar(i))
      last = "t"
      df[j,8] = lengths(strsplit(df[j,2],","))
      
    }
    
    #Revue
    else if(startsWith(i,"#c")){
      df[j,4] = substr(i,3,nchar(i))
      last = "c"
    }
    
    #Index de l'article
    else if(startsWith(i,"#index")){
      df[j,5] = substr(i,7,nchar(i))
      last = "index"
    }
    
    #Citation
    else if(startsWith(i,"#%")  && last != "%"){
      df[j,6] = substr(i,3,nchar(i))
      last = "%"
    }
    
    #Abstract
    else if(startsWith(i,"#!")){
      last = "!"
      df[j,7] = substr(i,3,nchar(i))
      if(is.na(df[j,6])){df[j,9] = 0}
      else{
      df[j,9] = lengths(strsplit(df[j,6],","))
      }
    }
    
    else if (!(startsWith(i, "#")) && last == "*"){
      df[j,1] = paste(df[j,1],i, sep = " ")
      
    }
    
    else if (!(startsWith(i, "#")) && last == "@"){
      df[j,2] = paste(df[j,2],i, sep = ",")
      
    }
    else if (startsWith(i, "#%") && last == "%"){
      df[j,6] = paste(df[j,6],substr(i,3,nchar(i)), sep = ",")
    }
    else if (!startsWith(i, "#") && last == "!"){
      df[j,7] = paste(df[j,7], i, sep=",")
    }
  }
  df$id_Doc = 1:nrow(df)
  return(df)
}



nettoyage <- function(titres){
  # Convertir le texte en minuscule
  titres <- tm_map(titres, content_transformer(toupper))
  # Supprimer les mots vides anglais/german/french
  titres  <- tm_map(titres , removeWords, stopwords("english"))
  titres  <- tm_map(titres , removeWords, stopwords("french"))
  titres <- tm_map(titres, stripWhitespace) # Supprimer les espaces vides supplémentaires
  ### FIN Nettoyage###
  return(titres)
}
