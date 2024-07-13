library("rvest") # Library

rus.pie.plt.sector <- function(x){ # Generate Pie Plot of Portfolio by Sectors
  
  tickers <- colnames(x[,1+3*seq(ncol(x)%/%3,from=0)])[-(ncol(x)%/%3+1)]
  
  pct <- as.data.frame(x[,3 * seq(ncol(x) %/% 3, from = 1)]) / x[,ncol(x)]
  
  colnames(pct) <- tickers # Assign tickers
  
  pct <- t(round(pct[nrow(pct),] * 100)) # Transform last period into percents
  
  C = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d","#5a51dc",
        "#d49f36","#552095","#507f2d","#db37aa","#84b67c","#a06fda","#df462a",
        "#5b83db","#c76c2d","#4f49a3","#82702d","#dd6bbb","#334c22","#d83979",
        "#55baad","#dc4555","#62aad3","#8c3025","#417d61","#862977","#bba672",
        "#403367","#da8a6d","#a79cd4","#71482c","#c689d0","#6b2940","#d593a7",
        "#895c8b","#bd5975") # Add colour range
  
  colnames(pct) <- "Portion" # Assign column name
  
  l <- NULL # Create list
  
  for (m in 1:length(tickers)){ s <- tolower(tickers[m])
  
    f <- read_html(sprintf("https://www.morningstar.com/stocks/misx/%s/quote",
                           s)) %>% html_nodes('section') %>%
      html_nodes('dd') %>% html_nodes('span') 
    
    L <- NULL 
    
    for (n in 1:length(f)){ if (isTRUE(f[n] %>% html_attr('class') ==
                                       "mdc-locked-text__mdc mdc-string")){
      
        L <- c(L, f[n] %>% html_text()) } } # Final version
    
    l <- rbind(l, L[1]) } # Join
  
  colnames(l) <- "Sector" # Assign column name
  rownames(l) <- tickers # Assign tickers
  
  pie.df <- data.frame(l, pct) # Form data frame
  
  pie.df <- aggregate(Portion ~ Sector, data=pie.df, sum) # Conditional sum
  
  pie(pie.df[,2], labels = c(sprintf("%s %s%%", pie.df[,1], pie.df[,2])), col=C,
      main = "Portfolio by Sectors", radius = 1) # Pie Chart
}
rus.pie.plt.sector(rus.portfolio.df) # Test
