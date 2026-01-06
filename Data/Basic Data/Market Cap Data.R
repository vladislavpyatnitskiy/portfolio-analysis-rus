library("rvest") # Library

rus.marketcap <- function(x, y){ # Portfolio Securities by Market Cap
  
  l <- NULL # Store data here
  
  for (m in 1:length(y)){ v <- y[m] # For each ratio get Smartlab HTML
  
    d <- read_html(sprintf("https://smart-lab.ru/q/%s/?field=%s",
                           "shares_fundamental",v)) %>% html_nodes('table') %>%
      .[[1]] %>% html_nodes('tr') %>% html_nodes('td') %>% html_text()
    
    message(sprintf("%s is downloaded", gsub("_", "/", toupper(v))))
    
    D <- NULL # Variable for Table with Name, Ticker and values
    
    for (n in 0:(length(d)/6)){ D <- rbind(D, cbind(d[(3+n*7)],d[(6+n*7)])) }
    
    D <- D[-nrow(D),] # Reduce last row
    
    D[,2] <- gsub('["\n"]', '', gsub('["\t"]', '', D[,2]))
    
    D <- gsub(" ", "", D) # Reduce gap in market cap
    
    colnames(D) <- c("Ticker", gsub("_", "/", toupper(v))) # Column names
    
    D <- subset(D, !apply(D == "", 1, any)) # Reduce empty row
    
    if (is.null(l)){ l <- D } else { l <- merge(x=l,y=D,by="Ticker",all=T) } } 
    
  if (isTRUE(l[1,1] == "")){ l <- l[-1,] } # Reduce empty row
  
  rownames(l) <- l[,1] # Move tickers to row names
  
  l <- as.data.frame(l[,-1]) # Reduce excessive column with tickers
  
  for (n in 1:ncol(l)){ l[,n] <- as.numeric(l[,n]) } # Make data numeric
  
  x <- colnames(x[,1 + 3 * seq(ncol(x) %/% 3, from = 0)])[-(ncol(x) %/% 3 + 1)]
  
  if (isTRUE(any(x == "QIWI"))){ x <- x[x != "QIWI"] # If there is QIWI ticker
      
    Q <- read_html("https://www.kommersant.ru/quotes/us74735m1080") %>%
      html_nodes('article') %>% html_nodes('section') %>% html_nodes("div") %>%
      html_nodes("p") %>% html_text() %>% .[8] # Market Cap Value for QIWI
    
    Q<-gsub("млрд₽","",gsub(",",".",gsub("\n","",gsub("\r","",gsub(" ","",Q)))))
    
    Q <- as.data.frame(as.numeric(Q)) # Make it numeric and put in data frame
    
    colnames(Q) <- "Market Cap" # Column Name
    rownames(Q) <- "QIWI" } # ticker
    
  L <- NULL # Collect fundamental data for portfolio securities
  
  for (n in 1:length(x)){ L <- rbind.data.frame(L, l[x[n],]) } # Join data
  
  colnames(L) <- "Market Cap" # Column Name
  rownames(L) <- x # Tickers
  
  if (!is.null(Q)){ rbind.data.frame(L, Q) } else { L } # Display
}
rus.marketcap(x = rus.portfolio.df, y = c("market_cap")) # Test
