library("rvest") # Library

rus.ratios <- function(x, y){ # Fundamentals nfo from Smartlab for portfolio
  
  l <- NULL # Store data here
  
  for (m in 1:length(y)){ v <- y[m] # For each ratio get Smartlab HTML
  
    s<-read_html(sprintf("https://smart-lab.ru/q/shares_fundamental/?field=%s",
                         v))
    
    tab <- s %>% html_nodes('table') %>% .[[1]]
    
    d <- tab %>% html_nodes('tr') %>% html_nodes('td') %>% html_text()
    
    D <- NULL # Variable for Table with Name, Ticker and values
    
    for (n in 0:(length(d)/6)){ D <- rbind(D, cbind(d[(3 + n * 6)],
                                                    d[(6 + n * 6)])) }
    D <- D[-nrow(D),] # Reduce last row
    D[,2] <- gsub('["\n"]', '', gsub('["\t"]', '', D[,2]))
    
    for (n in 1:length(D)){ if (isTRUE(grepl(" ", D[n]))){
      
        D[n] <- gsub(" ", "", D[n]) } } # Reduce gap in market cap
    
    colnames(D) <- c("Ticker", gsub("_", "/", toupper(y[m]))) # Column names
    
    if (is.null(l)){ l<-D } else { l<-merge(x=l,y=D,by="Ticker",all=T)} }# Join
    
  if (isTRUE(l[1,1] == "")){ l <- l[-1,] } # Reduce empty row
  
  rownames(l) <- l[,1] # Move tickers to row names
  
  l <- as.data.frame(l[,-1]) # Reduce excessive column with tickers
  
  for (n in 1:ncol(l)){ l[,n] <- as.numeric(l[,n]) } # Make data numeric
  
  x <- colnames(x[,1 + 3 * seq(ncol(x) %/% 3, from = 0)])[-(ncol(x) %/% 3 + 1)]
  
  if (isTRUE(any(x == "QIWI"))){ x <- x[x != "QIWI"] } # Unavailable ticker
  
  L <- NULL # Collect fundamental data for portfolio securities
  
  for (n in 1:length(x)){ L <- rbind.data.frame(L, l[x[n],]) } # Join data
  
  return(L) # Display
}
rus.ratios(x = rus.portfolio.df, y=c("market_cap","p_e","p_bv","p_s","p_fcf",
                                     "ev_ebitda","debt_ebitda"))
