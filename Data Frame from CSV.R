rus.stock.fun <- function(x){ # How to glue stocks into one data frame from csv
  
  f <- list.files(path = x, pattern = "*.csv", full.names = T) # File Path
  
  df <- NULL
  
  for (m in 1:length(f)){ # For each file extract name
  
    R <- as.character(read.fwf(textConnection(f[m]), widths = c(43, 47),
                               colClasses = "character")[2])
    
    R <- read.fwf(textConnection(R), widths=c(4, 8),
                  colClasses = "character")[1]
    
    D <- read.csv(f[m], header = T, stringsAsFactors = F) # Read CSV
    
    D <- D[,1:2] # Take only columns of Data and Adjusted close
    
    for (n in 1:nrow(D)){ # Reform data format
      
      Y <- as.character(read.fwf(textConnection(D[n,1]),
                                 widths=c(nchar(D[n,1]) - 4,
                                          nchar(D[n,1]) - 0),
                                 colClasses = "character")[2]) # Year
      
      M <- as.character(read.fwf(textConnection(D[n,1]),
                                 widths=c(nchar(D[n,1]) - 7,
                                          nchar(D[n,1]) - 8),
                                 colClasses = "character")[2]) # Month
      
      d <- as.character(read.fwf(textConnection(D[n,1]),
                                 widths=c(nchar(D[n,1]) - 8,
                                          nchar(D[n,1]) - 10),
                                 colClasses = "character")[1]) # Day
      
      if (isTRUE(grepl(",", D[n,2]))){ D[n,2] <- gsub(",", "", D[n,2]) }
      
      D[n,1] <- paste(Y, M, d, sep = "-") } # Concatenate dates
    
    D[order(D$Date, decreasing = T),] # Order from the first to last date
    
    colnames(D)[2] <- R # Assign ticker to column and join them
    
    if (is.null(df)){ df <- D } else { df <- merge(df, D, by = "Date") } }
  
  ts <- df[,1] # Put time series as a separate column
  
  df <- as.data.frame(df[,2:(length(f) + 1)]) # Put stocks in a separate column
  
  rownames(df) <- ts # Put time series as row names
  
  for (n in 1:ncol(df)){ df[,n] <- as.numeric(df[,n]) } # Make data numeric
  
  df # Display
}
rus.df <- rus.stock.fun("~/Desktop/My Russian Portfolio/") # Test
