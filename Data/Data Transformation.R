portfolio_builder1 <- function(x){ # Suit data frame of positions for portfolio
  
  s <- unique(x[,1]) # Subtract tickers from data frame
  
  L <- NULL # Make list with total value of positions
  
  for (n in 1:length(s)){ l <- x[x$Ticker == s[n],] # Subtract ticker
  
    k <- NULL # list with changes of position numbers
  
    if (nrow(l) > 1){ for (m in 1:nrow(l)){ if (isTRUE(m == 1)){
      
          k <- data.frame(Date = seq.Date(from = as.Date(l[m,2]),
                                          to = as.Date(l[m,3]), by = "day"),
                          Number = l[m,4])
          
          colnames(k)[m + 1] <- sprintf("%s", m) } else { # call first column
        
          k <- merge(k, data.frame(Date = seq.Date(from = as.Date(l[m,2]),
                                                   to = as.Date(l[m,3]),
                                                   by="day"), Number = l[m,4]),
                     by = "Date", all = T)
          
          colnames(k)[m + 1] <- sprintf("%s", m) } } # Call columns of numbers
    
      k[is.na(k)] <- 0 # Substitute NA with Zero values
    
      k$Total <- rowSums(k[,seq(ncol(k), from = 2)]) # Sum all numbers
      
      K<-rle(k[,ncol(k)])[2][1][[1]] } else { K<-l[,4] } # numbers of positions
    
    L <- c(L, list(s[n], l[,2], l[,3], K)) } # Join all values
  
  # Put into nested list according to tickers, start and end dates, numbers
  D <- list(L[seq(length(L) - 1, from = 0, by = 4) + 1],
            L[seq(length(L) - 1, from = 0, by = 4) + 2],
            L[seq(length(L) - 1, from = 0, by = 4) + 3],
            L[seq(length(L), from = 0, by = 4) + 0])
  D # Show
}
portfolio_builder1(df_positions) # Test
