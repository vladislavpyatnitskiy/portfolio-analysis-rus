lapply(c("ggplot2", "tidyverse", "rvest"), require, character.only = T) # Libs

rus.bar.plt.stack.sector <- function(x,portion=F){ #Stacked Bar plot by Sectors
  
  f.df <- x[,3 * seq(ncol(x) %/% 3, from = 1)] # Columns with total sum
  
  # Take column names with prices to put instead total sum column names
  colnames(f.df) <- colnames(x[,1+3*seq(ncol(x)%/%3,from=0)])[-(ncol(x)%/%3+1)]
  
  colnames(f.df) <- paste(colnames(f.df), "ME", sep = ".") 
  
  rwnms <- rownames(f.df) # Take dates from index column
  
  rwnms <- as.Date(rwnms) # Make it in date format
  
  f.df <- data.frame(rwnms, f.df) # Join it with main data set
  
  rownames(f.df) <- seq(nrow(f.df)) # Create sequence for index column
  
  p.df <- NULL # Define variable to contain values
  
  for (n in 2:ncol(f.df)){ # Convert daily data to monthly
    
    v <- tapply(f.df[,n], format(as.Date(f.df[,1]), "%Y-%m"), median)
    
    rwmns_ds <- rownames(v) # Take dates from index column
    
    v <- data.frame(rwmns_ds, v) # Join with new data set
    
    rownames(v) <- seq(nrow(v)) # Generate sequence for index column
    
    colnames(v)[colnames(v) == 'rwmns_ds'] <- 'Date' # Name column as Date
    
    # If defined empty variable is still empty # Put new dataset there
    if (is.null(p.df)){ p.df<-v } else { p.df <- merge(x=p.df,y=v,by="Date")} }
  
  p.df <- as.data.frame(p.df) # Convert to data frame format
  
  colnames(p.df) <- colnames(f.df) # Give column names
  
  colnames(p.df)[colnames(p.df) == colnames(p.df[1])] <- 'Date' # Rename again
  
  rownames(p.df) <- p.df[,1] #
  
  p.df <- t(p.df[,-1]) #
  
  y <- NULL # Create list
  
  for (n in 1:length(rownames(p.df))){ s <- rownames(p.df)[n]
    
    if (s == "OZON.ME"){ y <- rbind(y, "Consumer Cyclical") } # For OZON
    
    else if (s == "MDMG.ME"){ y <- rbind(y, "Healthcare") } else {  # MDMG
      
      p<-read_html(sprintf("https://uk.finance.yahoo.com/quote/%s/profile",s))
      
      Y <- p %>% html_nodes('div') %>% .[[1]] -> tab
      
      h <- tab %>% html_nodes('p') %>% html_nodes('span') %>% html_text()
      
      y <- rbind(y, h[grep("Sector", h) + 1]) } } # Add to list
    
  colnames(y) <- "Sector" # 
  rownames(y) <- rownames(p.df) # Assign tickers
  
  p.dates <- colnames(p.df) # Assign dates as column dates
  
  l <- NULL # Create time series with sector data
  
  for (n in 1:length(colnames(p.df))){ s <- as.data.frame(p.df[,n])
    
    pie.df <- data.frame(y, s) # Join data
    
    colnames(pie.df)[2] <- "Prices" # Assign column names
    
    pie.df <- aggregate(Prices ~ Sector, data=pie.df, sum) # Conditional sum
    
    if (is.null(l)){ l <- pie.df } else { l <- merge(l,pie.df,by="Sector") } }
    
  rownames(l) <- l[,1] # Assign Sector info as row names
  
  l <- l[,-1] # Reduce sector info as it is now in row names
  
  colnames(l) <- p.dates # Assign dates as column names
  
  l <- t(l) # Transpose so dates are now row names
  
  i <- data.frame(rownames(l), l) # Join Dates with time series
  
  colnames(i)[colnames(i) == colnames(i[1])] <- 'Date' # Rename again
  
  i <- i %>% pivot_longer(cols=-Date,names_to="Stock",values_to="Quantity")
  
  C = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d","#5a51dc",
        "#d49f36","#552095","#507f2d","#db37aa") # Colour set for plot
  
  if (isTRUE(portion)){ # Plot showing stakes of securities for each month
    
    ggplot(i, aes(x = Date, y = Quantity, fill = Stock)) + theme_minimal() +
      geom_bar(position = "fill", stat = "identity") +
      labs(title = "Stacked Bar Plot of Portfolio Securities by Sectors",
           x = "Months", y = "Stakes (%)", fill = "Securities") +
      scale_fill_manual(values=C) 
    
  } else { # Generate plot showing amount of securities for each month
    
    ggplot(i, aes(x = Date, y = Quantity, fill = Stock)) + theme_minimal() +
      geom_bar(position = "stack", stat = "identity") + 
      labs(title = "Stacked Bar Plot of Portfolio Securities by Sectors",
           x = "Months", y = "Amount in Roubles", fill = "Securities") +
      scale_fill_manual(values=C) }
}
rus.bar.plt.stack.sector(rus.portfolio.df, portion = F) # Test
