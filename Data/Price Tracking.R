library("rvest") # Library

smartlab.portfolio <- function(x){ # Data Frame with current stocks info
  
  l <- NULL # 
  
  for (n in 1:length(x)){ # Ticker & Number of stocks info
    
    l <- rbind.data.frame(l, cbind(x[[n]][1],
                                   x[[n]][4][[1]][length(x[[n]][4][[1]])])) }
  
  colnames(l) <- c("Ticker", "Number") # Column names
  
  p <- read_html("https://smart-lab.ru/q/shares/") # Get info from website
  
  tab <- p %>% html_nodes('table') %>% .[[1]] # Extract table
  
  f <- tab %>% html_nodes('tr') # Subtract nodes with tickers
  
  L <- NULL # Reorganise data into data frame
  
  for (n in 2:length(f)){ j <- f[n] %>% html_nodes('td') %>% html_text()
  
    P <- gsub('["\n"]', '', gsub('["\t"]', '', j[8]))
    
    P <- as.character(read.fwf(textConnection(P), widths = c(nchar(P) - 1, 1),
                               colClasses = "character")[1])
    
    if (isTRUE(grepl("\\+", P))){ P <- as.numeric(gsub("\\+", "", P)) }
    
    L <- rbind.data.frame(L, cbind(j[3], j[7], P)) } # ticker, price & %
  
  colnames(L) <- c("Ticker", "Price", "%") # Column names
  
  S <- merge(L, l, by = "Ticker") # Join data
  
  for (n in 2:4){ S[,n] <- as.numeric(S[,n]) } # Make data numeric
  
  S$PnL <- as.numeric(format(as.numeric(S$Price) * (1 - 1 / (1 + S[,3] / 100)),
                             scientific = F)) * as.numeric(S$Number)
  
  S$Value <- as.numeric(S$Price) * S$Number # Total sum
  
  b <- sum(S[seq(nrow(S)),6] / ((100 + S[seq(nrow(S)),3]) / 100)) # Last total
  
  S <- S[order(-S[,3]), ] # Order in a descending way
  
  rownames(S) <- seq(nrow(S)) # Sort row names in an ascending way
  
  d <- list(S, # Table of tickers, prices, %, Numbers & Value of Stocks
            c(sprintf("Portfolio Value: %s Roubles", sum(S[,6])),
              sprintf("Total PnL: %s Roubles", round(sum(S[,5]), 2)),
              sprintf("Return: %s %%",round(((sum(S[,6]) - b) / b) * 100, 2)),
              sprintf("%s: %s %%", L[1,1], L[1,3]))) # Index Return
  d # Show
}
smartlab.portfolio(rus.nest.df) # Test
