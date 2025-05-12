rus.box.plt <- function(x){ # Function to create Boxplot for Portfolio  
  
  v <- NULL # Clean data & calculate logs
  
  for (n in 1:ncol(x)){ v <- cbind(v, diff(log(x[,n]))[-1]) }
  
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
rus.box.plt(rus.df1) # Test
