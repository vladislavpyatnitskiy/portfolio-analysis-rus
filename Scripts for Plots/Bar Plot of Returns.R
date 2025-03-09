rus.bar.plt <- function(x){ # Bar Plot of Stocks Returns
  
  # Calculate Expected Returns
  v <- x[,3*seq(ncol(x) %/% 3, from=1)] / x[,2+3*seq(ncol(x) %/% 3-1, from=0)]
  
  v[is.na(v)] <- 0 # assign zeros to NaN values
  
  R <- NULL # Put Return values into this variables
  
  for (n in 1:ncol(v)){ s <- v[,n] # Calculate Return for each security
  
    j <- diff(log(s[apply(s, 1, function(row) all(row !=0 )),]))[-1,]
    
    R <- c(R,  (exp(sum(j)) - 1) * 100) } # Join values and assign tickers
    
  names(R) <- colnames(x[,1 + 3*seq(ncol(x) %/% 3, from=0)][,-(ncol(x)/3 + 1)])
  
  R <- sort(R, decreasing = T) # Make data numeric and sort values
  
  # Bar Plot with securities returns
  B <- barplot(R, names.arg = names(R), col = ifelse(R < 0, "red3", "green4"),
               main = "Performance of Portfolio Securities", horiz = T,
               xlim = c(min(R) - 1, max(R) + 1), xlab = "Returns (%)", las = 1) 

  abline(h = B, col = "grey", lty = 3) # Horizontal lines
  
  abline(v = 0) # Break Even Point
  
  grid(nx = NULL, ny = 1, col = "grey", lwd = 1) # Vertical lines
  
  box() # Make borders for plot
}
rus.bar.plt(rus.portfolio.df) # Test
