library("rvest") # Library

smartlab.portfolio <- function(x){ # Data Frame with current stocks info
  
  l <- NULL # 
  
  for (n in 1:length(x)){ # Ticker & Number of stocks info
    
    l <- rbind.data.frame(l, cbind(x[[n]][1],
                                   x[[n]][4][[1]][length(x[[n]][4][[1]])])) }
  
  colnames(l) <- c("ticker", "number") # Column names
  
  p <- read_html("https://smart-lab.ru/q/shares/") # Get info from website
  
  tab <- p %>% html_nodes('table') %>% .[[1]] # Extract table
  
  f <- tab %>% html_nodes('tr') # Subtract nodes with tickers
  
  L <- NULL # Reorganise data into data frame
  
  for (n in 2:length(f)){ j <- f[n] %>% html_nodes('td') %>% html_text()
  
    L <- rbind.data.frame(L, cbind(j[3], j[7])) } # Info about ticker and price
  
  colnames(L) <- c("ticker", "price") # Column names
  
  S <- merge(L, l, by = "ticker") # Join data
  
  for (n in 2:3){ S[,n] <- as.numeric(S[,n]) } # Make data numeric
  
  S$Total <- as.numeric(S$price) * S$number # Total sum
  
  a <- sprintf("Total Amount: %s", sum(S[,4])) # Show total sum of portfolio
  
  d <- list(S, a) # Add to list so all 
  
  d # Display
}
smartlab.portfolio(rus.nest.df) # Test
