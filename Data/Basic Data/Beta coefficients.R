lapply(c("moexer", "timeSeries", "xts"), require, character.only = T) # Libs 

rus.beta <- function(x){ # Beta coefficients for Portfolio Stocks
  
  x <- colnames(x[,1+3*seq(ncol(x) %/% 3,from=0)])[-(ncol(x)%/%3+1)] # Tickers
  
  i = "IMOEX" # Moscow Exchange Index
  
  x <- c(x, i) # Add benchmark to list
  
  p <- NULL # Empty variables for security values & Data upload
  
  start_date <- as.Date(Sys.Date() - 365 * 5) # Start Date
  
  for (A in x){ # Download data for all stocks in portfolio
    
    D <- as.data.frame(
      get_candles(
        A, start_date, till = as.Date(Sys.Date()),interval = 'daily'
        )[,c(3,8)]
      )
    
    message(
      sprintf(
        "%s is downloaded (%s / %s)", 
        A, which(x == A), length(x)
      )
    ) # Download message
    
    D <- D[!duplicated(D),] # Remove duplicates
    
    p <- cbind(p, xts(D[, 1], order.by = as.Date(D[, 2]))) }
    
  p <- p[apply(p, 1, function(x) all(!is.na(x))),] # Get rid of NA
  
  colnames(p) <- x # Put the tickers in data set
  
  p <- diff(log(as.timeSeries(p)))[-1,] # Time Series Returns and NA off
  
  B <- apply(p[, -which(names(p) == i)], 2,
             function(col) ((lm((col) ~ p[,i]))$coefficients[2]))
  
  B <- as.data.frame(round(B, 2)) # Round by 2 decimal numbers
  
  colnames(B) <- "Beta" # Column name
  
  return(B) # Display values
}
rus.beta(rus.portfolio.df) # Display
