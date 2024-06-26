rus.stock.fun <- function(x){ # How to glue stocks into one data frame from csv
  
  f <- list.files(path = x, pattern = "*.csv", full.names = T) # File Path
  
  df <- NULL # For each file extract name
  
  for (m in 1:length(f)){ R<-as.character(read.fwf(textConnection(f[m]),
                                                   widths = c(43, 47),
                                                   colClasses="character")[2])
    
    R <- read.fwf(textConnection(R), widths=c(4, 8), colClasses="character")[1]
    
    D <- read.csv(f[m], header = T, stringsAsFactors = F) # Read CSV
    
    D <- D[,1:2] # Subtract Dates and Adjusted Close Data and reform them
    
    D[,1] <- format(strptime(D[,1], format = "%d/%m/%Y"), "%Y-%m-%d") # Dates
      
    D[,2] <- gsub(",", "", D[,2]) # Reduce "," in stock prices
    
    D[order(D$Date, decreasing = T),] # Order from the first to last date
    
    colnames(D)[2] <- R # Assign ticker to column and join them
    
    if (is.null(df)){ df <- D } else { df <- merge(df, D, by = "Date") } }
  
  ts <- df[,1] # Put time series as a separate column
  
  df <- as.data.frame(df[,2:(length(f) + 1)]) # Put stocks in a separate column
  
  rownames(df) <- ts # Put time series as row names
  
  for (n in 1:ncol(df)){ df[,n] <- as.numeric(df[,n]) } # Make data numeric
  
  df # Display
}
rus.stock.fun("~/Desktop/My Russian Portfolio/") # Test
