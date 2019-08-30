library(R.temis)
#Appel du dossier où se trouveront nos textes
setwd("")
#Création du corpus avec nos textes dedans (bien préciser le format et la langue)
corpus <- import_corpus("Chap", format="txt",language="fr")
#Appel du CSV qui contient les métadonnées de nos textes (bien respecter le même ordre)
metadata<-read.csv2("metadata.csv", header=TRUE)
#View(metadata)
#On lie le corpus avec les metadonnées
corpus <- set_corpus_variables(corpus, metadata)
corpus
#On découpe le corpus en unités (ici, 1 = 1 paragraphe)
corpus <-split_documents(corpus,1)
corpus
#Cette fonction permet de faire apparaitre dans la console la première unité du texte
inspect (corpus[[1]])
#On fait apparaitre dans une autre fenêtre le corpus, divisé en unités et par texte
#View(sapply(corpus, as.character))
#On crée un tableau lexical en supprimant les mot-outils
dtmsmo <-build_dtm(corpus, remove_stopwords=T)
dtmsmo
#Bilan lexical sans lemmatisation ni mots outils
#on rajoute une variable, avec une présentation par année, spécifié grâce au fichier de métadonnées
lexical_summary(dtmsmo, corpus, "year")
lexico = lexical_summary(dtmsmo, corpus, "year")
write.csv(lexico, file = "lexico.csv")
#premier dictionnaire sans lemmatisation ni mots outils
dictionary(dtmsmo)
dic <-dictionary(dtmsmo)
#Apparition d'un dictionnaire avec les termes et leur occurence dans le texte
#View(dic)
#On peut exporter ce dictionnaire en format CSV si l'on veut
write.csv2(dic, file = "dic.csv")


#On peut ensuite effectuer diverses manipulations
#On peut cr�er un nuage de mots
#On fixe l'apparence du nuage
set.seed(1)
#On le fait ensuite apparaitre (on peut choisir sa couleur, le nb max de mots, etc.)
cloud<-word_cloud(dtmsmo, color="black", n=100, min.freq=0)

#On peut faire apparaitre la fréquence des mots
frequent_terms(dtmsmo)
#On peut aussi choisir un terme en particulier et le faire apparaitre par sous corpus
term_freq(dtmsmo,"soci�t�",meta(corpus)$year)

#On peut s'interesser aux concordances de termes
#D'abord pour un terme
concordances(corpus,dtmsmo,"soci�t�")
#Puis en s'intéressant aux concordances de deux mots entre eux
concordances(corpus,dtmsmo,c("soci�t�","crimes"))

#Doit faire apparaitre des caractéristiques de documents par métadonnées
characteristic_docs(corpus,dtmsmo,meta(corpus)$id)

#On peut faire apparaitre les cooccurences
#On peut avoir un graphe de mots dans une autre fenêtre
tree <- terms_graph(dtmsmo)

#Création d'une AFC avec un tableau lexical entier
resTLE <-corpus_ca(corpus,dtmsmo, sparsity=0.9)
explor(resTLE)
#A fermer avant de continuer

