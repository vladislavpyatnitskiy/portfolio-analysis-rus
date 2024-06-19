p.basic.info <- function(x){ # Data Frame with current stocks info
  
  l <- NULL # Store values here
  
  for (n in 1:length(x)){ # Ticker & Number of stocks info
    
    l <- rbind.data.frame(l, cbind(x[[n]][1],
                                   x[[n]][4][[1]][length(x[[n]][4][[1]])])) }
  
  colnames(l) <- c("ticker", "number") # Column names
  
  l # Display
}
p.basic.info(rus.nest.df) # Test
