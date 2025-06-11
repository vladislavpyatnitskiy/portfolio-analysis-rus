rus.tickers <- function(x, del, add){ # Rearrange tickers
  
  # Extract tickers from portfolio data frame
  
  x = colnames(x[,1 + 3 * seq(ncol(x) %/% 3, from = 0)][,-(ncol(x) %/% 3 + 1)]) 
  
  l <- NULL # Delete tickers you want to get rid of your portfolio
  
  for (n in 1:length(del)){ if (identical(grep(del[n], x), integer(0))){
    
      l <- c(l, del[n]) # Add excess tickers to a vector
    
      next } # Next round of the loop
    
    x <- x[-grep(del[n], x)] } # Delete tickers
      
  titles <- c("Tickers", "Number of Tickers") # Number of tickers
  
  # Scenario when you want to know new and excessive tickers in the vector #
  
  if (!is.null(l)){ y = list(c(x, add), length(c(x, add)), l, length(l))
  
    titles <- c(titles, "Mistyped Tickers", "Number of Mistyped Tickers") }
  
  # Scenario when you just need to know tickers in new portfolio #
    
  else { y <- list(c(x, add), length(c(x, add))) } # tickers and their number
  
  names(y) <- titles # Names for lists
  
  y # Display
}
rus.tickers(rus.portfolio.df,
            c("RASP", "QIWI", "MGNT", "ABRD", "PIKK", "NVTK", "UPRO",
              "TTLK", "GCHE", "AKRN", "AQUA"),
            c("BISVP", "RENI", "WTCMP", "MRKV")
            )
