draw <- function(data_factor, col_name, row_name, width, height ,color, cellheight, cellwidth, cluster_cols, cluster_rows, fontsize, fontsize_row, save_filename){
	
	rownames(data_factor) = row_name   
	colnames(data_factor) = col_name		
	windows(width = 50, height =100)
	pheatmap(data_factor, color, cellheight = cellheight, cellwidth = cellwidth, cluster_rows = cluster_rows, cluster_cols = cluster_cols, fontsize = fontsize, fontsize_row = fontsize_row, filename=save_filename)#, filename=save_filename

}

