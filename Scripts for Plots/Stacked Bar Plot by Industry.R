lapply(c("ggplot2", "tidyverse", "rvest"), require, character.only = T) # Libs

# Stacked Bar Plot of Portfolio Securities Dividends by Industry
rus.bar.plt.stack.dividend.industry <- function(x, portion = F, c = "Roubles"){ 
  
  d <- x[,3 * seq(ncol(x) %/% 3, from = 1)] # Columns with total sum
  
  # Take column names with prices to put instead total sum column names
  colnames(d) <- colnames(x[,1+3*seq(ncol(x)%/%3,from=0)])[-(ncol(x)%/%3+1)]
  
  d <- d[rowSums(d) > 0,][,colSums(d) > 0] # Only > 0
  
  rwnms <- rownames(d) # Take dates from index column
  
  rwnms <- as.Date(rwnms) # Make it in date format
  
  d <- data.frame(rwnms, d) # Join it with main data set
  
  rownames(d) <- seq(nrow(d)) # Create sequence for index column
  
  D <- NULL # Define variable to contain values
  
  for (n in 2:ncol(d)){ # Convert daily data to monthly
    
    v <- tapply(d[,n], format(as.Date(d[,1]), "%Y-%m"), sum)
    
    rwmns_ds <- rownames(v) # Take dates from index column
    
    v <- data.frame(rwmns_ds, v) # Join with new data set
    
    rownames(v) <- seq(nrow(v)) # Generate sequence for index column
    
    colnames(v)[colnames(v) == 'rwmns_ds'] <- 'Date' # Name column as Date
    
    # If defined empty variable is still empty # Put new dataset there
    if (is.null(D)){ D <- v } else { D <- merge(x = D, y = v, by = "Date") } }
  
  D <- as.data.frame(D) # Convert to data frame format
  
  colnames(D) <- colnames(d) # Give column names
  
  colnames(D)[colnames(D) == colnames(D[1])] <- 'Date' # Rename again
  
  rownames(D) <- D[,1] #
  
  D <- t(D[,-1]) #
  
  y <- NULL # Create list
  
  for (n in 1:length(rownames(D))){ # Get industry info from Morningstar website
    
    k <- read_html(sprintf("https://www.morningstar.com/stocks/misx/%s/quote",
                           rownames(D)[n])) %>% html_nodes('section') %>%
      html_nodes('dd') %>% html_nodes('span') 
    
    p <- NULL # Clean info
    
    for (m in 1:length(k)){ if (isTRUE(k[m] %>% html_attr('class') ==
                                       "mdc-locked-text__mdc mdc-string")){
      
        p <- c(p, k[m] %>% html_text()) } } # Final version
    
    y <- rbind.data.frame(y, p[2]) } # Join
  
  colnames(y) <- "Industry" # 
  rownames(y) <- rownames(D) # Assign tickers
  
  p.dates <- colnames(D) # Assign dates as column dates
  
  l <- NULL # Create time series with industry data
  
  for (n in 1:length(colnames(D))){ s <- as.data.frame(D[,n])
  
    pie.df <- data.frame(y, s) # Join data
    
    colnames(pie.df)[2] <- "Prices" # Assign column names
    
    pie.df <- aggregate(Prices ~ Industry, data=pie.df, sum) # Conditional sum
    
    if (is.null(l)){ l <- pie.df } else { l <- merge(l,pie.df,by="Industry")} }
    
  rownames(l) <- l[,1] # Assign Industry info as row names
  
  l <- l[,-1] # Reduce industry info as it is now in row names
  
  colnames(l) <- p.dates # Assign dates as column names
  
  l <- t(l) # Transpose so dates are now row names
  
  i <- data.frame(rownames(l), l) # Join Dates with time series
  
  colnames(i)[colnames(i) == colnames(i[1])] <- 'Date' # Rename again
  
  C = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d","#5a51dc",
        "#d49f36","#552095","#507f2d","#db37aa","#84b67c","#a06fda","#df462a",
        "#5b83db","#c76c2d","#4f49a3","#82702d","#dd6bbb","#334c22","#d83979",
        "#55baad","#dc4555","#62aad3","#8c3025","#417d61","#862977","#bba672",
        "#403367","#da8a6d","#a79cd4","#71482c","#c689d0","#6b2940","#d593a7",
        "#895c8b","#bd5975") # Colour set for plot
  
  # Convert for better read by ggplot
  i <- i %>% pivot_longer(cols=-Date, names_to="Stock", values_to="Quantity")
  
  if (isTRUE(portion)){ # Plot showing stakes of dividends for each month
    
    ggplot(i, aes(x = Date, y = Quantity, fill = Stock)) + theme_minimal() +
      geom_bar(position = "fill", stat = "identity") + 
      labs(title="Stacked Bar Plot of Portfolio Dividends by Industry",
           x = "Months", y = "Stakes (%)", fill = "Industries") +
      scale_fill_manual(values = C)   
    
  } else { # Generate plot showing amount of dividends for each month
    
    ggplot(i, aes(x = Date, y = Quantity, fill = Stock)) + theme_minimal() +
      geom_bar(position = "stack", stat = "identity") + 
      labs(title="Stacked Bar Plot of Portfolio Dividends by Industry",
           x = "Months", y = sprintf("Amount in %s", c), fill = "Industries") +
      scale_fill_manual(values = C) }
}
rus.bar.plt.stack.dividend.industry(rus.test.df, portion = F) # Test
