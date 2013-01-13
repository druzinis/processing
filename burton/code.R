# Inputai
tekstas <- "http://www.gutenberg.org/cache/epub/10800/pg10800.txt"
skaityti.nuo <- 114
skaityti.iki <- 43521 #abu imtinai

# Taisymai
keisti.i.tarpa <- ".,!?/\\|;:_\\-"
keisti.i.nieka <- "\""

trinti.eilutes.kai.prasideda <- "\\("

# Outout
failas <- "burton.csv"
##############################################################################

# Import book
d <- scan(tekstas, "character", sep="\n")[skaityti.nuo:skaityti.iki]

# Clean-up
d <- d[-grep(paste0("^", trinti.eilutes.kai.prasideda), d)]

if (keisti.i.tarpa!="") d <- gsub(paste0("[", keisti.i.tarpa, "]"), " ", d)
if (keisti.i.nieka!="") d <- gsub(paste0("[", keisti.i.nieka, "]"), "", d)

d <- gsub("\\[[0-9]*\\]", "", d)
d <- gsub("[\\']", "", d)
d <- gsub("[\\(]", "", d)
d <- gsub("[\\)]", "", d)
d <- gsub("[\\[]", "", d)
d <- gsub("[]]", "", d)

# Make dictionary

d <- sapply(d, strsplit, " ")
d <- unlist(d, use.names=FALSE)
d <- d[-match("", d)]
d <- d[sapply(d, nchar)!=0]
d <- tolower(d)

u <- table(d)

result <- data.frame(id=1:length(u), zodis=names(u), skaicius=as.data.frame(u)$Freq)

write.csv(result, failas, row.names=FALSE)