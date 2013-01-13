setwd("testing Rstem")

# Package installation
install.packages("Rstem", repos = "http://www.omegahat.org/R")

# Help 
library(Rstem)
getStemLanguages()

help(package="Rstem")
help(wordStem)

# Simple examples
wordStem(c("go", "going", "went"), language="english") # "go"   "go"   "went"
wordStem(c("house", "houses"), language="english") # "hous" "hous"
wordStem(c("knife", "knives"), language="english") # "knife" "knive"

# Bigger examples (see csv files)
testWords = readLines(system.file("words", "english", "voc.txt", package = "Rstem"))
write.csv(cbind(input=testWords, stem=wordStem(testWords)), file="example in Rstem package.csv", row.names=FALSE)

burton <- read.csv("../burton/burton.csv", stringsAsFactors=FALSE)[["zodis"]]
write.csv(cbind(input=burton, stem=wordStem(burton)), file="example - burton.csv", row.names=FALSE)
