setwd("D:\\hongyuxiang\\R")
library('R.matlab')
library('plyr')
library('pheatmap')
source("draw.r")
path <- ('D:/hongyuxiang/R/')
pathname <- file.path(path, 's.mat')
alldata <- readMat(pathname)
win_width = 50
win_height =100
row_name <- c('Irs2','Pdx1','Pik3r1','Wnt7a','Bmp4','Shh','Hras','Braf','Ctnnb1')
Mp_name <- c('MP188','MP438','MP2110','MP5559','MP5560','MP74','MP10029','MP440','MP562','MP564')
col_name <- c('Group1:MP(188,5559,5560)\n(100%,100%,100%)','Group2:MP(2110,562,564)\n(100%,100%,100%)','Group3:MP(438,74,10029,440)\n(100%,100%,100%,100%)')
col_name2 <- c('Group1:MP(188,5559,440,564)\n(100%,100%,100%,0.57%)','Group2:MP(2110,5560,564)\n(100%,100%,100%)','Group3:MP(438,74,10029,564)\n(100%,100%,100%,99.55%)')
V3=matrix(0,9,3)
V3[1,1] = 1
V3[2,1] = 1
V3[6,1] = 0.0057
V3[9,1] = 1
V3[4,2] = 1
V3[5,2] = 1
V3[6,3] = 0.9955
V3[7,3] = 1
V3[3,2] = 1
V3[8,3] = 1
t1=cbind(matrix(1,3,1),matrix(0,3,1),matrix(0,3,1))
t2=cbind(matrix(0,3,1),matrix(1,3,1),matrix(0,3,1))
t3=cbind(matrix(0,3,1),matrix(0,3,1),matrix(1,3,1))
V4 =rbind(t1,t2,t3)

RampPlette<-colorRampPalette(c('#ffffff','#9933ff'))(256)
color = RampPlette
cellheight = 15
cellwidth = 30
cluster_cols = 0
cluster_rows = 0
fontsize = 9
fontsize_row = 9
save_filename = 'v3.pdf'
draw(V3, col_name2, row_name, win_width, win_height, color, 
	cellheight, cellwidth, cluster_cols, cluster_rows, fontsize,
	 fontsize_row, save_filename)
save_filename = 'v4.pdf'
cluster_cols = 0
draw(V4, col_name, row_name, win_width, win_height, color, 
	cellheight, cellwidth, cluster_cols, cluster_rows, fontsize,
	 fontsize_row, save_filename)

