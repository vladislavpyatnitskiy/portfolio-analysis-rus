library("rvest") # Library

smartlab.portfolio <- function(x){ # Data Frame with current stocks info
  
  l <- NULL # Data Frame with Ticker and Number columns
  
  for (n in 1:length(x[[1]])){ # Ticker & Number of stocks info
    
    l<-rbind.data.frame(l,cbind(x[[1]][[n]],x[[4]][[n]][length(x[[4]][[n]])]))}
  
  colnames(l) <- c("Ticker", "Number") # Column names
  
  f <- read_html("https://smart-lab.ru/q/shares/") %>% html_nodes('table') %>%
    .[[1]] %>% html_nodes('tr') # Subtract nodes with tickers
  
  L <- NULL # Reorganise data into data frame with ticker, price and return
  
  for (n in 2:length(f)){ j <- f[n] %>% html_nodes('td') %>% html_text() 
  
    P <- gsub('["\n"]', '', gsub('["\t"]', '', j[8])) # Clean Data
    
    P <- as.character(read.fwf(textConnection(P), widths = c(nchar(P) - 1, 1),
                               colClasses = "character")[1])
    
    if (isTRUE(grepl("\\+", P))){ P <- as.numeric(gsub("\\+", "", P)) }
    
    L <- rbind.data.frame(L, cbind(j[3], j[7], P)) } # ticker, price & %
  
  H <- f[3] %>% html_nodes('td') %>% html_text() %>% .[10] # Subtract row
  
  colnames(L) <- c("Ticker", "Price", "Return") # Column names
  
  S <- merge(L, l, by = "Ticker") # Join price, return & number data by ticker
  
  for (n in 2:4){ S[,n] <- as.numeric(S[,n]) } # Change data format to numeric
  
  S$PnL <- as.numeric(format(S[,2] * (1-1/(1+S[,3]/100)),scientific=F)) * S[,4]
  
  S$Portion <- round((S$Price * S$Number / sum(S$Price * S$Number)) * 100, 2)
  
  S$Value <- S$Price * S$Number # Calculate P&L, Portions & Total Value
  
  b <- sum(S[seq(nrow(S)),6] / ((100 + S[seq(nrow(S)),3]) / 100)) # Last total
  
  S <- S[order(-S[,3]), ] # Order in a descending way
  
  rownames(S) <- seq(nrow(S)) # Sort row names in an ascending way
  
  d <- list(sprintf("Time: %s", H), # Time
            S, # Table of tickers, prices, %, Numbers & Value of Stocks
            c(sprintf("Portfolio Value: %s Roubles", sum(S[,7])),
              sprintf("Total PnL: %s Roubles", round(sum(S[,5]), 2)),
              sprintf("Return: %s %%",round(((sum(S[,6]) - b) / b) * 100, 2)),
              sprintf("%s: %s %%", L[1,1], L[1,3]))) # Index Return
  d # Show
}
smartlab.portfolio(pos.df.new) # Test
