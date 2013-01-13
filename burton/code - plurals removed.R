words <- read.csv("burton.csv", stringsAsFactors=FALSE)[, 2:3]
words <- words[order(words$zodis), ]

ids <- which(words$zodis[-length(words$zodis)]==gsub("s$", "", words$zodis[-1]))
words$total <- words$skaicius
words$total[ids] <- rowSums(cbind(words$skaicius[ids], words$skaicius[ids+1]))
words$singular <- ""
words$singular[ids] <- words$zodis[ids]
words$singular.num <- 0
words$singular.num[ids] <- words$skaicius[ids]
words$plural <- ""
words$plural[ids] <- words$zodis[ids + 1]
words$plural.num <- 0
words$plural.num[ids] <- words$skaicius[ids+1]

output <- words[-(ids+1), -2]
output <- output[order(output[, 2], decreasing=TRUE), ]
write.csv(output, file="burton - plurals removed.csv", row.names=FALSE)
