lapply(c("ggplot2", "tidyverse", "rvest"), require, character.only = T) # Libs

rus.bar.plt.stack.sector <- function(x, portion = F, c = "$US"){  
  
  d <- x[,3 * seq(ncol(x) %/% 3, from = 1)] # Columns with total sum
  
  # Take column names with prices to put instead total sum column names
  colnames(d) <- colnames(x[,1+3*seq(ncol(x)%/%3,from=0)])[-(ncol(x)%/%3+1)]
  
  rwnms <- rownames(d) # Take dates from index column
  
  rwnms <- as.Date(rwnms) # Make it in date format
  
  d <- data.frame(rwnms, d) # Join it with main data set
  
  rownames(d) <- seq(nrow(d)) # Create sequence for index column
  
  D <- NULL # Define variable to contain values
  
  for (n in 2:ncol(d)){ # Convert daily data to monthly
    
    v <- tapply(d[,n], format(as.Date(d[,1]), "%Y-%m"), median)
    
    rwmns_ds <- rownames(v) # Take dates from index column
    
    v <- data.frame(rwmns_ds, v) # Join with new data set
    
    rownames(v) <- seq(nrow(v)) # Generate sequence for index column
    
    colnames(v)[colnames(v) == 'rwmns_ds'] <- 'Date' # Name column as Date
    
    # If defined empty variable is still empty # Put new dataset there
    if (is.null(D)){ D <- v } else { D <- merge(x = D, y = v, by = "Date") } }
  
  D <- as.data.frame(D) # Convert to data frame format
  
  colnames(D) <- colnames(d) # Give column names
  
  colnames(D)[1] <- 'Date' # Rename again
  
  rownames(D) <- D[,1] #
  
  D <- t(D[,-1]) #
  
  y <- NULL # Create list
  
  for (m in 1:nrow(D)){ s <- tolower(rownames(D)[m])
  
    f <- read_html(sprintf("https://www.morningstar.com/stocks/misx/%s/quote",
                           s)) %>% html_nodes('section') %>%
      html_nodes('dd') %>% html_nodes('span') 
    
    L <- NULL 
    
    for (n in 1:length(f)){ if (isTRUE(f[n] %>% html_attr('class') ==
                                       "mdc-locked-text__mdc mdc-string")){
      
      L <- c(L, f[n] %>% html_text()) } } # Final version
    
    y <- rbind(y, L[1]) } # Join
    
  colnames(y) <- "Sector" # 
  rownames(y) <- rownames(D) # Assign tickers
  
  p.dates <- colnames(D) # Assign dates as column dates
  
  l <- NULL # Create time series with sector data
  
  for (n in 1:length(colnames(D))){ #s <- as.data.frame(D[,n])
  
    pie.df <- data.frame(y, as.data.frame(D[,n])) # Join data
    
    colnames(pie.df)[2] <- "Prices" # Assign column names
    
    B <- aggregate(Prices ~ Sector, data = B, sum) # Conditional sum
    
    if (is.null(l)){ l <- B } else { l <- merge(l, B, by = "Sector") } }
  
  rownames(l) <- l[,1] # Assign Sector info as row names
  
  l <- l[,-1] # Reduce sector info as it is now in row names
  
  colnames(l) <- p.dates # Assign dates as column names
  
  l <- t(l) # Transpose so dates are now row names
  
  i <- data.frame(rownames(l), l) # Join Dates with time series
  
  colnames(i)[colnames(i) == colnames(i[1])] <- 'Date' # Rename again
  
  i <- i %>% pivot_longer(cols=-Date, names_to="Stock", values_to="Quantity")
  
  C = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d","#5a51dc",
        "#d49f36","#552095","#507f2d","#db37aa") # Colour set for plot
  
  if (isTRUE(portion)){ # Plot showing stakes of securities for each month
    
    ggplot(i, aes(x = Date, y = Quantity, fill = Stock)) + theme_minimal() +
      geom_bar(position = "fill", stat = "identity") +
      labs(title = "Stacked Bar Plot of Portfolio Securities by Sectors",
           x = "Months", y = "Stakes (%)", fill = "Securities") +
      scale_fill_manual(values = C) 
    
  } else { # Generate plot showing amount of securities for each month
    
    ggplot(i, aes(x = Date, y = Quantity, fill = Stock)) + theme_minimal() +
      geom_bar(position = "stack", stat = "identity") + 
      labs(title = "Stacked Bar Plot of Portfolio Securities by Sectors",
           x = "Months", y = sprintf("Amount in %s", c), fill = "Securities") +
      scale_fill_manual(values = C) }
}
rus.bar.plt.stack.sector(rus.portfolio.df, portion = F, c = "Roubles") # Test
