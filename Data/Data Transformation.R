portfolio_builder1 <- function(x){ # Suit data frame of positions for portfolio
  
  s <- unique(x[,1]) # Subtract tickers from data frame
  
  L <- NULL # Make list with total value of positions
  
  for (n in 1:length(s)){ l <- x[x$Ticker == s[n],] # Subtract ticker
    
    if (isTRUE(nrow(l) > 1)){ for (m in 2:nrow(l)){ 
      
        l[m, 4] <- l[m, 4] + l[(m - 1), 4] } } # Add numbers
  
    L <- c(L, list(s[n], l[,2], l[,3], l[,4])) } # Join values
  
  # Put into nested list according to tickers, start and end dates, numbers
  D <- list(L[seq(length(L) - 1, from = 0, by = 4) + 1],
            L[seq(length(L) - 1, from = 0, by = 4) + 2],
            L[seq(length(L) - 1, from = 0, by = 4) + 3],
            L[seq(length(L), from = 0, by = 4) + 0])
  D # Show
}
portfolio_builder1(df_positions) # Test
