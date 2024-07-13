rus.bar.plt <- function(x){ # Bar Plot of Stocks Returns
  
  # Take column names containing tickers
  c <- colnames(x[,1 + 3 * seq(ncol(x) %/% 3, from = 0)][,-(ncol(x) / 3 + 1)])
  
  # Calculate Expected Returns
  x <- x[,3*seq(ncol(x) %/% 3, from=1)] / x[,2+3*seq(ncol(x) %/% 3-1, from=0)]
  
  x[is.na(x)] <- 0 # assign zeros to NaN values
  
  v <- NULL #
  
  for (n in 1:ncol(x)){ s <- x[,n] #
    
    j <- diff(log(s[apply(s, 1, function(row) all(row !=0 )),]))[-1,]
    
    v <- c(v,  (exp(sum(j)) - 1) * 100) } # Join  
    
  names(v) <- c # Give column names
  
  v <- sort(v, decreasing = T) # Make data numeric and sort values
  
  mx <- ceiling(round(max(v)) / 10 ^ (nchar(round(max(v))) - 1)) *
    10 ^ (nchar(round(max(v))) - 1) # Round maximum value up
  
  if (min(v) < 0){ # Round minimum value down
    
    if (any(seq(9) == as.numeric(strsplit(as.character(min(v)),"")[[1]][3]))){
      
      mn <- (as.numeric(strsplit(as.character(min(v)),"")[[1]][2]) + 1) * -10 }
  }
  # Bar Plot with securities returns
  plt <- barplot(v, names.arg = names(v), horiz=T, xlab="Returns (%)", las=1,
                 main = "Performance of Portfolio Securities", xlim=c(mn, mx),
                 col=c(rep("green4",length(v)-sum(v<0)),rep("red3",sum(v<0)))) 
  
  # Add vertical (returns) and horizontal (through bars) grey dotted lines
  abline(h = plt, col = "grey", lty = 3) 
  
  l <- as.numeric(v)[!is.na(as.numeric(v))] # Get values for intervals
  
  m <- round(min(l) * -1 + max(l),0)/10^(nchar(round(min(l) * -1+ max(l),0)))
  
  if (m > 0 && m < 1){ mc <- 1 * 10 ^ (nchar(m) - 3) }
  
  else if (m > 1 && m < 2){ mc <- 2 * 10 ^ (nchar(m) - 3) }
  
  else if (m > 2 && m < 5){ mc <- 5 * 10 ^ (nchar(m) - 3) }
  
  for (n in seq(from=-100,by=mc/5,to=10000)){ abline(v=n, col="grey", lty=3) } 
  
  axis(side=1, at = seq(from = -100, by = mc / 5, to = 10000), las=1) # X-axis
  
  box() # Make borders for plot
}
rus.bar.plt(rus.portfolio.df) # Test
