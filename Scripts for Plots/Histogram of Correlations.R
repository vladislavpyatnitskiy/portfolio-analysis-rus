lapply(c("moexer", "timeSeries", "xts"), require, character.only = T) # Libs 

# Histogram with Portfolio Correlation values
rus.hist.plt.cor <- function(x, method="spearman", main=NULL){ 
  
  p <- NULL # Create an empty variable and get stock price data
  
  C <- colnames(x[,1 + 3 * seq(ncol(x) %/% 3, from = 0)])[-(ncol(x) %/% 3 + 1)]
  
  for (a in C){ 
    
    D = as.data.frame(get_candles(a,"2007-01-01",interval='daily')[,c(3,8)])
    
    D <- D[!duplicated(D),] # Remove duplicates
    
    D <- xts(D[,1], order.by = as.Date(D[,2])) # Move dates to row names
    
    D <- D[apply(D, 1, function(x) all(!is.na(x))),] # Get rid of NA
    
    colnames(D) <- a # Put the tickers in data set
    
    D <- as.timeSeries(D) # Make it time series
    
    if (a == "BELU"){ f <- which(rownames(D) == "2024-08-15")
    
      D[c(1:f),] <- D[c(1:f),] / 8 } # Adjustments for Novabev stock
    
    message(
      sprintf(
        "%s is downloaded (%s/%s)", 
        a, which(C == a), length(C)
      )
    )
    
    p <- cbind(p, D) }
  
  p <- p[apply(p, 1, function(x) all(!is.na(x))),] # Eliminate NAs
  
  colnames(p) <- C # Column names
  
  # Calculate correlation matrix
  cor_matrix <- cor(as.matrix(diff(log(as.timeSeries(p)))[-1,]), method=method)
  
  # Extract unique pairs and their correlations
  cor_pairs <- which(upper.tri(cor_matrix, diag = TRUE), arr.ind = TRUE)
  
  # Put them into one data frame
  unique_pairs <- data.frame(
    Variable1 = rownames(cor_matrix)[cor_pairs[, 1]],
    Variable2 = rownames(cor_matrix)[cor_pairs[, 2]],
    Correlation = cor_matrix[cor_pairs]
  )
  # Filter out pairs with correlation equal to 1
  filtered_pairs <- unique_pairs[unique_pairs$Correlation != 1, ]
  
  rownames(filtered_pairs) <- seq(nrow(filtered_pairs)) # Row numbers
  
  colnames(filtered_pairs) <- c("Security 1", "Security 2", "Correlation")
  
  s <- filtered_pairs[,3]
  
  s.min <- min(s) # Minimum value
  s.max <- max(s) # Maximum value
  
  # Parameters
  hist(
    s,
    main = ifelse(is.null(main), "Portfolio Correlations Histogram", main),
    freq = F,
    breaks = 100,
    ylab = "Frequency",
    xlab = " Unique Correlation Values",
    las = 1,
    xlim = c(s.min, s.max),
    col = "navy",
    border = "white"
  )
  
  R <- seq(round(s.min, 2), round(s.max, 2), by = .0001)
  
  lines(
    R, 
    dnorm(R, mean(s), sd(s)), col = "red", lwd = 2
  )
  
  grid(nx = NULL, ny = NULL, lty = 3, col = "grey") # Horizontal lines
  
  abline(h = 0) # Add vertical line at x = 0
  
  box() # Define plot borders
}
rus.hist.plt.cor(rus.portfolio.df) # Test
