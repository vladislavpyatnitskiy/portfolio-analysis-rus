lapply(c("moexer", "timeSeries", "xts"), require, character.only = T) # Libs 

rus.heatmap.plt <- function(x, size = .9, main = NULL){
  
  p <- NULL # Create an empty variable and get stock price data
  
  for (a in colnames(x[,1+3*seq(ncol(x) %/% 3,from=0)])[-(ncol(x)%/%3+1)]){ 
    
    D <- as.data.frame(get_candles(a, "2007-01-01", till = as.Date(Sys.Date()),
                                   interval = 'daily')[,c(3,8)])
  
    D <- D[!duplicated(D),] # Remove duplicates
    
    p <- cbind(p, xts(D[, 1], order.by = as.Date(D[, 2]))) }
  
  p <- p[apply(p, 1, function(x) all(!is.na(x))),] # Eliminate NAs
  
  colnames(p) <- colnames(x[,1+3*seq(ncol(x) %/% 3,from=0)])[-(ncol(x)%/%3+1)]
  
  m.correlation = as.matrix(diff(log(as.timeSeries(p)))[-1,]) # returns matrix 
  
  c.correlation = ncol(m.correlation) # Get number of columns
  
  new_cor <- cor(m.correlation) # Calculate correlation coefficients
  
  # Create appropriate colour for each pair of correlation for heatmap
  k.c <- round((10 * length(unique(as.vector(new_cor))))/2)
  corrColorMatrix <- rgb(c(rep(0, k.c), seq(0, 1, length = k.c)),
                         c(rev(seq(0,1,length=k.c)), rep(0,k.c)), rep(0,2*k.c))
  # Display heatmap
  image(x = 1:c.correlation,y = 1:c.correlation,z = new_cor[, c.correlation:1],
        col = corrColorMatrix, axes = FALSE, main = "", xlab = "", ylab = "")
  
  # Add labels for both axis
  axis(2, at = c.correlation:1, labels = colnames(m.correlation), las = 2)
  axis(1, at = 1:c.correlation, labels = colnames(m.correlation), las = 2)
  
  title(main = main) # Add title for heatmap
  
  box() # Box heatmap
  
  # Add correlation values as text strings to each heatmap cell
  x = y = 1:c.correlation
  n_x = n_y = length(y)
  xoy = cbind(rep(x, n_y), as.vector(matrix(y, n_x, n_y, byrow = TRUE)))
  coord_for_corr = matrix(xoy, length(y) ^ 2, 2, byrow = FALSE)
  X_for_corr = t(new_cor)
  for (i in 1:c.correlation ^ 2) {
    text(coord_for_corr[i, 1], coord_for_corr[c.correlation ^ 2 + 1 - i, 2],
         round(X_for_corr[coord_for_corr[i,1],coord_for_corr[i,2]],digits = 2),
         col = "white", cex = size) }
}
rus.heatmap.plt(rus.portfolio.df, size =.9,
                main = "Portfolio Correlations Heatmap") # Test
