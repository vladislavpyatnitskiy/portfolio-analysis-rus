lapply(c("xts", "timeSeries", "moexer"), require, character.only = T) # lib

rus.portfolio.builder <- function(x){ # Portfolio Data Frame for Russian Stocks
  
  s <- unique(x[,1]) # Get all position changes for each stock 
  
  L <- NULL #
  
  for (n in 1:length(s)){ l <- x[x$Ticker == s[n],] # Values for each ticker
  
    L <- c(L, list(s[n], l[,2], l[,3], cumsum(l[,4]))) } # Data for each ticker
  
  v <- length(L) / 4 
  
  O <- NULL
  
  for (n in 1:v){ N <- n * 4
  
    f <- list(L[[N-2]], L[[N-1]], L[[N]])
    
    if (is.null(O)){ O <- list(f) } else { O[[n]] <- f }
  }
  names(O) <- L[seq(length(L) - 1, from = 0, by = 4) + 1]
  
  redom = list(
    c("AGRO", "RAGR"), c("CIAN", "CNRU"), c("HHRU", "HEAD"), c("FIVE", "X5"),
    c("FIXP", "FIXR"), c("YNDX", "YDEX")
    ) # Redomiciliated stocks
  
  from = "2007-01-01"
  
  J <- NULL
  R <- NULL
  
  for (n in 1:length(names(O))){ # Downloaded all stock data
    
    if (any(sapply(redom, function(redom_item) names(O)[n] %in% redom_item))){
      
      f = which(sapply(redom,function(redom_item) names(O)[n] %in% redom_item))
      
      for (k in 1:length(redom[[f]])){
        
        a = as.data.frame(
          get_candles(redom[[f]][k], from=from, interval='daily')[,c(3,8)]
        )
        
        if (k == 2){ # When both for redomiciliated tickers are downloaded
          
          message(
            sprintf(
              "%s is downloaded; %s from %s", 
              names(O)[n], which(names(O) == names(O)[n]), length(names(O))
            )
          )
        }
        
        a <- a[!duplicated(a),] # Remove duplicates
        
        a <- xts(a[, 1], order.by = as.Date(a[, 2]))
        
        if (x[n] == "AGRO") a <- a / 7.01
        
        colnames(a) <- redom[[f]][2]
        
        if (is.null(R)) R <- data.frame(a) else R <- rbind.data.frame(R, a)
      }
    } else { # Download stocks for ordinary stocks
      
      a = as.data.frame(get_candles(names(O)[n], 
                                    from=from, interval='daily')[,c(3,8)])
      
      message(
        sprintf(
          "%s is downloaded; %s from %s", 
          names(O)[n], which(names(O) == names(O)[n]), length(names(O))
        )
      )
      
      a <- a[!duplicated(a),] # Remove duplicates
      
      a <- xts(a[, 1], order.by = as.Date(a[, 2]))
      
      colnames(a) <- names(O)[n]
      
      R <- data.frame(a) 
    }
    
    R <- as.timeSeries(R) # Make it time series
    
    if (names(O)[n] == "BELU"){ j <- which(rownames(R) == "2024-08-15")
    
      R[c(1:j),] <- R[c(1:j),] / 8 } # Adjustments for Novabev stock
    
    if (is.null(J)) J <- list(R) else J[[n]] <- R 
    R <- NULL  # Reset R for next iteration
  }
  
  df <- NULL # Variable to contain values
  
  message("Stock data is fully downloaded, now create portfolio data frame")
  
  for (m in 1:length(O)){ # For each asset
    
    v <- names(O)[m] # Ticker
    s <- O[[m]][[1]] # Start date
    e <- O[[m]][[2]] # End date
    q <- O[[m]][[3]] # Asset number
    l <- length(s) # Length of Dates and Numbers
    
    ts <- NULL # Create variable to contain data of single asset
    
    for (n in seq(l)){ # Extend time series and add asset number
      
      ts <- rbind(
        ts, 
        data.frame(
          Date=seq.Date(
            from=as.Date(s[[n]]), to = as.Date(e[[n]]), by="day"
            ),
          Number = q[[n]]
        )
      )
    }
    
    p <- as.timeSeries(J[[m]]) # time series 
    
    rownames(p) <- rownames(J[[m]]) # Assign dates
    
    colnames(p) <- v # Assign tickers
    
    # Subset dates from data set and transform them into a date format
    dates_fr_yh <- as.Date(rownames(as.timeSeries(J[[m]])))
    
    # Merge asset values with its dates
    ds_from_yahoo <- data.frame(dates_fr_yh, as.timeSeries(p))
    
    # Change column name to Date
    colnames(ds_from_yahoo)[colnames(ds_from_yahoo) == 'dates_fr_yh'] <- 'Date'
    
    # Create index numbers for data set and join as row names
    rownames(ds_from_yahoo) <- seq(nrow(ds_from_yahoo))
    
    # merge actual ownership period with
    f.df <- merge(x = ds_from_yahoo, y = ts, by = c("Date"))
    
    f.df$total_sum <- f.df[,2] * f.df$Number # Total sum of asset
    
    # Add Ticker to Number
    colnames(f.df)[colnames(f.df) == 'Number'] <- sprintf("%s Number", v)
    
    # Add Ticker to Total
    colnames(f.df)[colnames(f.df) == 'total_sum'] <- sprintf("%s Total", v)
    
    # If it is first column, define it to new name or merge with previous
    if (is.null(df)) df=f.df else df <- merge(x=df, y=f.df, by="Date", all=T) }
  
  df[is.na(df)] <- 0 # Substitute NA with Zero values
  
  df <- df[!duplicated(df[, 1]), ]
  
  rownames(df) <- df$Date # Put Dates in index
  
  df <- df[,-1] # Subset Time Series from data set 
  
  # Total amount of investments
  df$Total <- rowSums(df[,c(seq(ncol(df) / 3) * 3)], na.rm = T)
  
  df <- as.timeSeries(df) # Make it time series
  
  return(df) # Display values
}
rus.portfolio.builder(df_positions2)
