lapply(c("moexer", "timeSeries", "xts"), require, character.only = T) # Libs 

moex.comp.plt <- function(x){ # Compare performance between Portfolio and IMOEX
  
  P <- x[,3 * seq(ncol(x) %/% 3, from = 1)] # Take columns with Total Sum
  
  P1 <- t(P) # Transpose 
  
  colnames(P1) <- rownames(P) # Make dates as column names 
  
  R <- as.data.frame(0) # Define data frame with value zero
  
  # Loop for portfolio log returns calculation
  for (n in 2:ncol(P1)){ df2p <- P1[,(n-1):n] # x1 # Select two periods
  
    s <- df2p[apply(df2p, 1, function(row) all(row !=0 )),] # Remove zeros & NA
  
  # Add newly generated variable to data frame
  R <- rbind(R, log(as.numeric(colSums(s)[2]) / as.numeric(colSums(s)[1]))) }
  
  colnames(R) <- "Returns" # Give name to column
  rownames(R) <- rownames(P) # Return dates to index
  
  R <- as.timeSeries(R) # Make it time series
  
  s <- rownames(R)[1] # Start Date
  e <- rownames(R)[nrow(R)] # End Date
  R <- apply(R, 2, function(col) exp(cumsum(col)) - 1) * 100 # Returns
  
  p.row.names <- rownames(R) # Subset dates from data set
  
  R <- data.frame(p.row.names, R) # Join dates with logs
  
  colnames(R) <- c("Date", "Portfolio") # Rename columns once again
  rownames(R) <- seq(nrow(R)) # Create index numbers for data set
  
  p <- as.data.frame(get_candles("IMOEX", from = s, till = e,
                                 interval = 'daily')[,c(3,8)])
  
  p <- p[!duplicated(p),] # Remove duplicates
  
  p <- xts(p[, 1], order.by = as.Date(p[, 2])) 
  
  colnames(p) <- "IMOEX" # Assign names of indices
  
  p <- p[apply(p, 1, function(x) all(!is.na(x))),] # Clean data
  
  r <- diff(log(as.timeSeries(p)))#[-1,] # Make time series and calculate logs
  
  r[1,] <- 0 # Equal first return value to 0
  
  r <- apply(r, 2, function(col) exp(cumsum(col)) - 1) * 100 # total returns
  
  i.names <- rownames(r) # Subset dates from data set
  
  r <- data.frame(i.names, r) # Join dates with logs
  
  colnames(r)[colnames(r) == 'i.names'] <- 'Date' # Rename column Dates
  
  rownames(r) <- seq(nrow(r)) # Create index numbers for data set
  
  i <- as.timeSeries(merge(R, r, by = "Date")) # Merge and make time series
  
  par(mar = c(8, 2.5, 4, 2.5)) # Define borders of the plot
  
  plot(i[,1], ylim = c(min(i), max(i)), lty = 1, type = "l", lwd = 2, las = 1,
       xlab = "Trading Days", ylab = "Returns (%)",
       main = "Performance of Portfolio and index of Moscow Exchange")
  
  axis(side = 4, las = 2) # Right Y-Axis Values
  
  grid(nx = 1, ny = NULL, lty = 3, col = "grey") # Horizontal lines
  
  abline(h = 0) # Add black horizontal line at break even point
  
  for (n in 2:(ncol(i))){ lines(i[,n], col = n, lwd = 2) } # Plot indices
  
  legend(x = "bottom", inset = c(0, -0.27), legend = c("Portfolio", "IMOEX"),
         col = seq(ncol(i)), lwd = 2, cex = .85, bty = "n", xpd = T, horiz = T)
  
  on.exit(par(par(no.readonly = T))) # Show legend with names
}
moex.comp.plt(rus.portfolio.df) # Test
