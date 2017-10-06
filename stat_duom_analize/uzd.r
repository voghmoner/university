#1 uzduotis, 2 dalis
x <- c(1, 2, 3)
A <- matrix(c(1, 1, -1, 2, 0, 3), nrow = 3, ncol = 2, byrow = TRUE)
x*A
B <- A[1:2,]
B %% B
C <- data.frame(A )
D <- data.frame(A)
colnames(D) <- c('x1', 'x2')
D$x3 <- c('vienas', 'du', 'trys')
D$x4 <- D$x1 + D$x2
matricos <- list('A'=A, 'B'=B, 'C'=C)

#
# 2 uzd, 1 dalis
#

#setwd(...)
file <- read.table('Auto.txt', header = TRUE)
file <- as.data.frame(file)
currentDate<-Sys.Date()  #for getting current system date eg:2012-11-06
formatDate<-format(currentDate,"%Y")
age <- as.numeric(formatDate) - file$Gamybos_metai
avg_age <- mean(age)
list <- list()
for (i in age){
    print(i)
    if(i <= 12){
        print("yay")
        list <- c(list, "naujas")
    }  else if (i > 12 & i <= 15 ) {
        print("yay1")
        list <- c(list,"padevetas")
    }  else {
        print("yay2")
        list <- c(list,"senas")
    }
}
 #kad jus zinotumet kiek tai truko...
file$amziaus_grupe <- unlist(list)
new_rida <- tapply(file$Rida, file$amziaus_grupe, mean)
file$nauja_Rida <- new_rida[file$amziaus_grupe]
# 
aut1 <- read.table('Auto.txt', header = TRUE)
aut1 <- as.data.frame(aut1)
aut2 <- read.table('Auto2.txt', header = TRUE)
aut2 <- as.data.frame(aut2)
aut1$Kaina<- NA
Auto3 <- rbind(aut1, aut2)
Auto4 <- data.frame(Auto3$Gamybos_metai, Auto3$Marke, Auto3$Rida)
colnames(Auto4) <- c("Gamybos_metai", "Marke", "Rida")
Auto5 <- Auto3[(as.numeric(formatDate) - Auto3$Gamybos_metai) <= 10 & Auto3$Rida < 100000,]
#kitas budas Auto5 <- subset(Auto3, (as.numeric(formatDate) - Auto3$Gamybos_metai) <= 10 & Auto3$Rida < 100000)
#
name <- c("Jonas", "Petras", "Rasa", "Daiva", "Rimas")
surname <- c("Jonaitis", "Petraitis", "Kuosyte", "Rimkute", "Juozaitis")
code <- c(352, 841, 369, 299, 986)
students <- data.frame(name, surname, code)
ex1 <- c(9, 10, 6, 5, 8)
ex2 <- c(8, 9, 7, 8, 8)
ex3 <- c(7, 8, 8, 9, 7)
ex4 <- c(7, 8, 8, 8, 9)
code <- c(841, 369, 299, 352, 986)
exams <- data.frame(code, ex1, ex2, ex3, ex4)
total <- merge(students,exams,by="code")
max <- apply(total[4:7], MARGIN=1, FUN=max)
min <- apply(total[4:7], MARGIN=1, FUN=min)
mw <- apply(total[4:7], MARGIN=1, FUN=mean)
ans <- data.frame(total$name, total$surname, max, min, mw)

#
# 2 uzd, 1 dalis
#

xy <- read.table('xy.txt', header = TRUE)
xy <- as.data.frame(xy)
xy <- data.frame(lapply(xy, function(x) {
                  gsub(",", ".", x)
                  }))
love_is_in_the_air <- function(x, y){
    return(sin(x) + cos(y))
}
x <- mapply(love_is_in_the_air, as.numeric(xy$x), as.numeric(xy$y))
x
vector <- c(57, -232, 5.3, 21, 4, -7, 87, -1.2)
func <- function(t){
    for(j in vector){
        print(j)
        if(!is.null(t)){
            t <- abs(mean(vector))
        }
        if(j > t){
            replace(vector, j, t)
        }
    }
}
func(4)
vector
t = 4
