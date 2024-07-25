lapply(c("rvest", "timeSeries"), require, character.only=T) # Libraries

rus.dividend.df.builder <- function(x){ # Portfolio Dividend Data Frame
  
  y <- NULL # Data Frame with Tickers, Dates and Dividend Amount
  
  p <- seq("2023", from = "2014", by = 1) # Dates
  
  for (m in 1:length(p)){ # Get data for each year
    
    f <- read_html(sprintf("%s%s", "https://smart-lab.ru/dividends/index?year=",
                           p[m])) %>% html_nodes('table') %>% .[[1]] %>%
      html_nodes('tr') # Table
    
    a <- NULL # Show only Approved Dividends
    
    for (n in 1:length(f)){ if (isTRUE(f[n] %>% html_attr('class') ==
                                       "dividend_approved")){
      
        a <- c(a, f[n] %>% html_nodes('td') %>% html_text()) } }
    
    for (n in 0:(length(a) / 11)){ # Data Frame with Ticker, Date and Dividend
      
      y <- rbind.data.frame(y, cbind(a[(2 + n * 11)], a[7 + n * 11],
                                     as.numeric(gsub(",", ".", a[4+n*11])))) } 
  }
  colnames(y) <- c("Ticker", "Date", "Div Amount in Roubles") # Column Names
  
  y <- y[apply(y, 1, function(x) all(!is.na(x))),] # Get rid of NA
  
  y[,2] <- format(strptime(y[,2], format="%d.%m.%Y"),"%Y-%m-%d") # Dates format
  
  df <- NULL # Variable to contain values
  
  for (j in seq(x[[1]])){ # For each asset
    
    v <- x[[1]][[j]] # Ticker
    s <- x[[2]][[j]] # Start date
    e <- x[[3]][[j]] # End date
    q <- x[[4]][[j]] # Asset number
    l <- length(s) # Length of Dates and Numbers
    
    ts <- NULL # Create variable to contain data of single asset
    
    for (n in seq(l)){ if (isTRUE(s[[n]] != s[l])){ # For all rows but last
      
        ts <- rbind(ts, data.frame(Date = seq.Date(from=as.Date(s[[n]]),
                                                   to = as.Date(s[[n+1]]) - 1,
                                                   by = "day"), Number=q[[n]]))
      } else { # For last observations
      
        ts <- rbind(ts, data.frame(Date=seq.Date(from=as.Date(s[[n]]),
                                                 to = as.Date(e[[n]]),
                                                 by="day"), Number=q[[n]])) } }
    
    if (isTRUE(nrow(y[y == v,][,-1]) == 0) ||
        isTRUE(as.Date(y[y==v,][,2][length(y[y==v,][,2])]) < as.Date(s[[l]]))){ 
      
      m <- data.frame(Date=seq.Date(from=as.Date(s[[1]]),
                                    to=as.Date(e[[length(s)]]), by="day"),v=0)
      
      } else { m <- y[y == v,][,-1] } # Subtract dividend column 
    
    colnames(m)[2] <- v # Assign ticker as column name
    
    m[,1] <- as.Date(m[,1]) # Assign dividend dates as dates
    ts[,1] <- as.Date(ts[,1]) # Assign time series as dates
    
    d <- merge(m, ts, by = "Date")[1:2] # Merge dividend data with time series
    
    d[,2] <- as.numeric(d[,2]) # Make dividend data numeric
    
    for (n in 1:nrow(d)){ while (isFALSE(d[n,1] == d[nrow(d),1])){
      
        if (isTRUE(d[n,1] == d[n + 1,1])){ d[n,2] <- d[n,2] +  d[n + 1,2]
      
          d <- d[-(n + 1),] } # Sum Dividends that are paid at the same date
      
        break } } # Finish when all rows are examined
    
    if (isTRUE(d[nrow(d) - 1, 1] == d[nrow(d), 1])){ # Reduce duplicates
      
      d[nrow(d) - 1,2] <- d[nrow(d) - 1,2] +  d[nrow(d),2] 
      
      d <- d[-nrow(d),] } # Reduce last row 
    
    D <- merge(d, ts, by = "Date", all = T) #
    
    D[is.na(D)] <- 0 # Substitute NA with Zero values
    
    for (n in 2:3){ D[,n] <- as.numeric(D[,n]) } # Make column values numeric
    
    D$b <- D[,2] * D[,3] # Column with Total values
    
    colnames(D)[3] <- sprintf("%s Number", v) # Column with asset number
    colnames(D)[4] <- sprintf("%s Total", v) # Column with total value
    
    if (is.null(df)){ df = D } else { df <- merge(x=df,y=D,by="Date",all=T) } }
  
  df[is.na(df)] <- 0 # Substitute NA with Zero values
  
  rownames(df) <- df[,1] # Put Dates in index
  
  df <- df[,-1] # Subset Time Series from data set 
  
  df$Total <- rowSums(df[,c(seq(ncol(df) / 3) * 3)], na.rm = T)
  
  as.timeSeries(df) # Display
}
rus.dividend.df.builder(pos.df.new) # Test
