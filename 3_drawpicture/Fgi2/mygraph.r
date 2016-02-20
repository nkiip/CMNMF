#print ("h")
#draw graph
setwd("D:\\hongyuxiang\\R")
library('R.matlab')
library('igraph')
path <- ('D:/hongyuxiang/R/')
pathname <- file.path(path, 'matlab.mat')
data <- readMat(pathname)
ls(data)
m <- data$type2.ppi
#print(m)
g <- graph_from_adjacency_matrix(m, weighted = NULL, mode = 'undirected', diag = FALSE)
plot(g, layout = layout.fruchterman.reingold)
