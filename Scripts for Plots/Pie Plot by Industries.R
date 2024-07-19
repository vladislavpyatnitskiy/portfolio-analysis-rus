library("rvest") # Library

rus.pie.plt.industry <- function(x){ # Pie Plot of industries for Portfolio
  
  l <- NULL # Data Frame with Ticker and Number columns
  
  for (n in 1:length(x[[1]])){ # Ticker & Number of stocks info
    
    l <- rbind.data.frame(l, cbind(x[[1]][[n]],
                                   x[[4]][[n]][length(x[[4]][[n]])])) }
  
  colnames(l) <- c("Ticker", "Number") # Column names
  
  p <- read_html("https://smart-lab.ru/q/shares/") # Get info from website
  
  tab <- p %>% html_nodes('table') %>% .[[1]] # Extract table
  
  f <- tab %>% html_nodes('tr') # Subtract nodes with tickers
  
  L <- NULL # Reorganise data into data frame with ticker, price and return
  
  for (n in 2:length(f)){ j <- f[n] %>% html_nodes('td') %>% html_text()
  
    P <- gsub('["\n"]', '', gsub('["\t"]', '', j[8])) # Clean Data
    
    P <- as.character(read.fwf(textConnection(P), widths = c(nchar(P) - 1, 1),
                               colClasses = "character")[1])
    
    if (isTRUE(grepl("\\+", P))){ P <- as.numeric(gsub("\\+", "", P)) }
    
  L <- rbind.data.frame(L, cbind(j[3], j[7], P)) } # ticker, price & %
  
  colnames(L) <- c("Ticker", "Price", "Return") # Column names
  
  S <- merge(L, l, by = "Ticker") # Join price, return & number data by ticker
  
  for (n in 2:4){ S[,n] <- as.numeric(S[,n]) } # Change data format to numeric
  
  S$PnL <- as.numeric(format(S[,2] * (1-1/(1+S[,3]/100)),scientific=F)) * S[,4]
  
  S$Portion <- round((S$Price * S$Number / sum(S$Price * S$Number)) * 100, 2)
  
  S$Value <- S$Price * S$Number # Calculate P&L, Portions & Total Value
  
  b <- sum(S[seq(nrow(S)),6] / ((100 + S[seq(nrow(S)),3]) / 100)) # Last total
  
  S <- S[,-(2:4)] # Reduce excess columns
  
  rownames(S) <- seq(nrow(S)) # Sort row names in an ascending way
  
  D <- NULL #
  
  for (n in 1:nrow(S)){ # Get industry info from Morningstar website
    
    k <- read_html(sprintf("https://www.morningstar.com/stocks/misx/%s/quote",
                           S[n,1])) %>% html_nodes('section') %>%
      html_nodes('dd') %>% html_nodes('span') 
    
    d <- NULL # Clean info
    
    for (m in 1:length(k)){ if (isTRUE(k[m] %>% html_attr('class') ==
                                       "mdc-locked-text__mdc mdc-string")){
      
        d <- c(d, k[m] %>% html_text()) } } # Final version
    
    D <- rbind.data.frame(D, cbind(S[n,1], d[2])) } # Join
  
  colnames(D) <- c("Ticker", "Industry") # Column Names
  
  S <- merge(S, D, by = "Ticker") # Merge by tickers
  
  C = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d","#5a51dc",
        "#d49f36","#552095","#507f2d","#db37aa","#84b67c","#a06fda","#df462a",
        "#5b83db","#c76c2d","#4f49a3","#82702d","#dd6bbb","#334c22","#d83979",
        "#55baad","#dc4555","#62aad3","#8c3025","#417d61","#862977","#bba672",
        "#403367","#da8a6d","#a79cd4","#71482c","#c689d0","#6b2940","#d593a7",
        "#895c8b","#bd5975") # Add colour range
  
  S <- S[,-c(1,2,4)] # Reduce excess columns
  
  pie.df <- aggregate(Portion ~ Industry, data = S, sum) # Conditional sum
  
  pie(pie.df[,2], labels = c(sprintf("%s %s%%", pie.df[,1], pie.df[,2])), col=C,
      main = "Portfolio by Industries", radius = 1) # Pie Chart
}
rus.pie.plt.industry(pos.df.new) # Test
