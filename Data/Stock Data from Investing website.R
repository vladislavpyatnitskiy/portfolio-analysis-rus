stock.excel <- function(x){ # Download Historical Stock Data from CSV
  
  D <- read.csv(x, header = T, stringsAsFactors = F) # Read CSV
  
  R <- as.character(read.fwf(textConnection(x), widths = c(31, 34),
                             colClasses="character")[2])
  
  R <- read.fwf(textConnection(R), widths=c(4, 8), colClasses="character")[1]
  
  D <- D[,1:2] # Subtract Dates and Adjusted Close Data and reform them
  
  D[,1] <- format(strptime(D[,1], format = "%d/%m/%Y"), "%Y-%m-%d") # Dates
  
  D[,2] <- gsub(",", "", D[,2]) # Reduce "," in stock prices
  
  D <- D[order(D$Date),] # Order from the first to last date
  
  dates <- D[,1] # Assign dates
  
  D <- as.data.frame(D[,-1]) # Reduce dates from main data frame
  
  rownames(D) <- dates # Assign dates as row names
  
  D[,1] <- as.numeric(D[,1]) # Make price data numeric
  
  D <- as.timeSeries(D) # Make data time series
  
  colnames(D)[1] <- R # Assign ticker to column and join them
  
  D # Display
}
stock.excel("~/Desktop/My Russian Portfolio/DIOD Historical Data-3.csv") # Test
