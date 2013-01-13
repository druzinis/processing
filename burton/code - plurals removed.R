words <- read.csv("burton.csv", stringsAsFactors=FALSE)[, 2:3]
words <- words[order(words$zodis), ]

# ids <- which(words$zodis[-length(words$zodis)]==gsub("s$", "", words$zodis[-1]))

freq <- as.data.frame(table(gsub("s$", "", words$zodis)))
singulars <- as.character(freq$Var1[freq$Freq>1])
sing.ids <- sapply(singulars, function(i) which(i==words$zodis))
plur.ids <- sapply(paste0(singulars, "s"), function(i) which(i==words$zodis))

words$total <- words$skaicius
words$total[sing.ids] <- rowSums(cbind(words$skaicius[sing.ids], words$skaicius[plur.ids]))
words$singular <- ""
words$singular[sing.ids] <- words$zodis[sing.ids]
words$singular.num <- 0
words$singular.num[sing.ids] <- words$skaicius[sing.ids]
words$plural <- ""
words$plural[sing.ids] <- words$zodis[plur.ids]
words$plural.num <- 0
words$plural.num[sing.ids] <- words$skaicius[plur.ids]

output <- words[-plur.ids, -2]
output <- output[order(output[, 2], decreasing=TRUE), ]
write.csv(output, file="burton - plurals removed.csv", row.names=FALSE)