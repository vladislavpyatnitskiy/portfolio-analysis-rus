library("rvest") # Library

rus.pie.plt.marketcap <- function(x, y){ # Portfolio Securities by Market Cap
  
  # Calculate Weights for each security
  Y <- x[,3*seq(ncol(x)%/%3,from=1)][nrow(x),]/as.numeric(x[nrow(x),ncol(x)])
  
  Y <- round(as.data.frame(t(as.data.frame(Y))) ,2) * 100
  
  l <- NULL # Store data here
  
  for (m in 1:length(y)){ v <- y[m] # For each ratio get Smartlab HTML
    
    d<-read_html(sprintf("https://smart-lab.ru/q/shares_fundamental/?field=%s",
                         v)) %>% html_nodes('table') %>% .[[1]] %>%
      html_nodes('tr') %>% html_nodes('td') %>% html_text()
    
    D <- NULL # Variable for Table with Name, Ticker and values
    
    for (n in 0:(length(d)/6)){ D <- rbind(D, cbind(d[(3 + n * 6)],
                                                    d[(6 + n * 6)])) }
    D <- D[-nrow(D),] # Reduce last row
    D[,2] <- gsub('["\n"]', '', gsub('["\t"]', '', D[,2]))
    
    for (n in 1:length(D)){ if (isTRUE(grepl(" ", D[n]))){
      
        D[n] <- gsub(" ", "", D[n]) } } # Reduce gap in market cap
    
    colnames(D) <- c("Ticker", gsub("_", "/", toupper(y[m]))) # Column names
    
    if (is.null(l)){ l <- D } else { l <- merge(x=l,y=D,by="Ticker",all=T) } }
    
  if (isTRUE(l[1,1] == "")){ l <- l[-1,] } # Reduce empty row
  
  rownames(l) <- l[,1] # Move tickers to row names
  
  l <- as.data.frame(l[,-1]) # Reduce excessive column with tickers
  
  for (n in 1:ncol(l)){ l[,n] <- as.numeric(l[,n]) } # Make data numeric
  
  x <- colnames(x[,1 + 3 * seq(ncol(x) %/% 3, from = 0)])[-(ncol(x) %/% 3 + 1)]
  
  if (isTRUE(any(x == "QIWI"))){ x <- x[x != "QIWI"]
  
    Q <- read_html("https://www.kommersant.ru/quotes/us74735m1080") %>%
      html_nodes('article') %>% html_nodes('section') %>% html_nodes("div") %>%
      html_nodes("p") %>% html_text() %>% .[8] # Market Cap Value for QIWI
    
    B=gsub("млрд₽","",gsub(",",".",gsub("\n","",gsub("\r","",gsub(" ","",Q)))))
    
    B <- as.data.frame(B)
    colnames(B) <- "Market Cap" # Column Name
    rownames(B) <- "QIWI" } # ticker
  
  L <- NULL # Collect fundamental data for portfolio securities
  
  for (n in 1:length(x)){ L <- rbind.data.frame(L, l[x[n],]) } # Join data
  
  colnames(L) <- "Market Cap" # Column Name
  rownames(L) <- x # Tickers
  
  if (!is.null(B)){ L <- rbind.data.frame(L, B) } # Add if QIWI is in portfolio
  
  M <- NULL # Assign values for Market Cap Values
  
  for (n in 1:ncol(L)){ L[,n] <- as.numeric(L[,n]) } # Make values numeric
  
  for (n in 1:nrow(L)){ m <- L[n,1] # Micro, Small, Mid, Large and Mega Caps
  
    if (m < 1){ M <- rbind.data.frame(M, "Micro-Cap") } # 1
    
    else if (m > 1 & m < 10) { M <- rbind.data.frame(M, "Small-Cap") } # 2
    
    else if (m > 10 & m < 100) { M <- rbind.data.frame(M, "Mid-Cap") } # 3
    
    else if (m > 100 & m < 1000) { M <- rbind.data.frame(M, "Large-Cap") } # 4
    
    else if (m > 1000) { M <- rbind.data.frame(M, "Mega-Cap") } } # 5
    
  rownames(M) <- rownames(L)
  colnames(M) <- "Level" # Column Name
  
  df <- cbind.data.frame(M, Y) # Join
  
  colnames(df)[2] <- "Portion" # Assign column name for numeric values
  
  df <- aggregate(Portion ~ Level, data=df, sum) # Conditional sum & Colours
  
  C = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d","#5a51dc")
  
  pie(df[,2], labels=c(sprintf("%s %s%%", df[,1], df[,2])), col=C, radius=1.5,
      main = "Portfolio Securities by Market Capitalisation") # Plot
}
rus.pie.plt.marketcap(x = rus.portfolio.df, y=c("market_cap")) # Test
