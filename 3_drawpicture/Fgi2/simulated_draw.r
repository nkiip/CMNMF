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
new_row_name <-c('Braf','Bmp4','Pdx1','Wnt7a','Irs2','Ctnnb1','Shh','Hras','Pik3r1')
V3 = matrix(0, 9, 10)
V3[1, 1] = 1
V3[4, 2] = 1
V3[7, 3] = 1
V3[2, 4] = 1
V3[3, 5] = 1
V3[5, 6] = 1
V3[6, 7] = 1
V3[8, 8] = 1
V3[8, 9] = 1
V3[9, 10] = 1
Mp_name <- c('MP188','MP438','MP2110','MP5559','MP5560','MP562','MP564','MP74','MP10029','MP440')
RampPlette<-colorRampPalette(c('#ffffff','#9933ff'))(256)
color = RampPlette
cellheight = 25
cellwidth = 20
cluster_cols = 0
cluster_rows = 0
fontsize = 9
fontsize_row = 9
save_filename = 'v_4.pdf'
cluster_cols = 0
draw(V3, Mp_name, row_name, win_width, win_height, color, 
	cellheight, cellwidth, cluster_cols, cluster_rows, fontsize,
	 fontsize_row, save_filename)

