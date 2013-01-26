# Inputai
tekstas <- "http://www.gutenberg.org/cache/epub/10800/pg10800.txt"
skaityti.nuo <- 83
skaityti.iki <- 43521 #abu imtinai

# Taisymai
keisti.i.tarpa <- ".,!?/\\|;:_\\-"
keisti.i.nieka <- "\""

trinti.eilutes.kai.prasideda <- "\\("

# Outout
failas <- "burton.csv"
##############################################################################
library(stringr)
nbsp <- "nonbreakingspc"

# Import book
source.text <- scan(tekstas, "character", sep="\n")[skaityti.nuo:skaityti.iki]

# Clean-up
d <- source.text[-grep(paste0("^", trinti.eilutes.kai.prasideda), source.text)]

d <- paste(d, collapse=" ")
d <- gsub(" +", " ", d)

d <- tolower(d)

## Non-breaking space exceptions

d <- gsub("democritus junior", "democritusnbspjunior", d)
# str_locate_all(d, "democritusnbspjunior")
# str_match_all(d, " st\\. ([a-z]+)")

d <- gsub(" st\\. ([a-z]+)", " stnbsp\\1", d)
# str_match_all(d, "stnbsp")

if (keisti.i.tarpa!="") d <- gsub(paste0("[", keisti.i.tarpa, "]"), " ", d)
if (keisti.i.nieka!="") d <- gsub(paste0("[", keisti.i.nieka, "]"), "", d)

d <- gsub("\\[[0-9]*\\]", "", d)
d <- gsub("[\\']", " ", d)
d <- gsub("[\\(]", "", d)
d <- gsub("[\\)]", "", d)
d <- gsub("[\\[]", "", d)
d <- gsub("[]]", "", d)

# Make dictionary

d <- strsplit(d, " ")
d <- unlist(d, use.names=FALSE)
d <- d[-match("", d)]
d <- d[sapply(d, nchar)!=0]

u <- table(d)

result <- data.frame(id=1:length(u), zodis=names(u), skaicius=as.data.frame(u)$Freq)

# Kill numbers
result <- result[!grepl("^[0-9]*$", result$zodis), ]

# Restore non breaking spaces

result$zodis <- gsub("democritusnbspjunior", "Democritus Junior", result$zodis)

# str_locate_all(result$zodis, "stnbsp")

saints <- grepl("stnbsp", result$zodis)
saints.names <- result$zodis[saints]
saints.names <- paste0("St. ", 
                       toupper(sapply(str_match_all(saints.names, "stnbsp(\\w)"), 
                                      function(x) x[1, 2])), 
                       sapply(str_match_all(saints.names, "stnbsp(\\w)(\\w+)"), 
                              function(x) x[1, 3]))
result$zodis[saints] <- saints.names

# result$zodis <- gsub("stnbsp([a-z])([a-z]+)", "St. \\l\\1\\2", result$zodis)

result$zodis[grepl("^St", result$zodis)]

write.csv(result, failas, row.names=FALSE)