library("timeSeries") # Library

# Function to make data frame for positions and add new ones

df_positions_builder <- function(ticker, s, e, q, df = NULL){
  
  if (is.null(df)){ df <- data.frame(ticker, as.Date(s), as.Date(e), q)
  
    colnames(df) <- c("Ticker", "Start Date", "End Date", "Number")
  
  } else { D <- data.frame(ticker, as.Date(s), as.Date(e), q)
    
    colnames(D) <- c("Ticker", "Start Date", "End Date", "Number")
    
    df <- rbind.data.frame(df, D) } # Put in Data Frame
  
  df <- df[order(as.Date(df[,2], format="%Y/%m/%d")),] # Order by Start Dates
  
  rownames(df) <- seq(nrow(df)) # Row names by numbers 
  
  df # Display
}
df_positions_builder("MDMG", "2022-07-11", "2024-03-29", 12) # Test
