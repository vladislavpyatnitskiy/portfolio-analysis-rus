rus.box.plt <- function(x){ # Function to create Boxplot for Portfolio  
  
  x <- x[,1 + 3 * seq(ncol(x) %/% 3, from = 0)][,-(ncol(x) %/% 3 + 1)] # Data
  
  v <- NULL # Variable for values
  
  for (n in 1:ncol(x)){ s <- x[,n] # Clean data and calculate logs
  
    v <- cbind(v, diff(log(s[apply(s,1,function(row) all(row !=0 )),]))[-1,]) } 
  
  colnames(v) <- colnames(x) # Give column names & generate plot
  
  B <- boxplot.matrix(
    v,
    main = "Fluctuations of Portfolio Securities",
    col = "steelblue",
    las = 2
    ) 
  
  grid(nx = 1, ny = NULL, col = "grey", lwd = 1) # Horizontal lines
  
  abline(h = 0, lty = 3) # Break Even Return
  
  axis(side = 4, las = 1) # Return values on the right side of the plot
  
  par(mar = rep(4, 4)) # Define borders of the plot to fit right y-axis
  
  abline(v = seq(ncol(v)), col = "grey", lty = 3) # Add vertical lines
}
rus.box.plt(rus.portfolio.df) # Test
