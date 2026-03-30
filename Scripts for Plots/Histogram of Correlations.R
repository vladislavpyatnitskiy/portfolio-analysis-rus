lapply(c("moexer", "timeSeries", "xts"), require, character.only = T) # Libs 

# Histogram with Portfolio Correlation values
rus.hist.plt.cor <- function(x, method="spearman", main=NULL){ 
  
  p <- NULL # Create an empty variable and get stock price data
  
  redom = list(
    c("AGRO", "RAGR"), c("CIAN", "CNRU"), c("HHRU", "HEAD"), c("FIVE", "X5"),
    c("FIXP", "FIXR"), c("YNDX", "YDEX"))
  
  from = "2007-01-01"
  
  C <- colnames(x[,1 + 3 * seq(ncol(x) %/% 3, from = 0)])[-(ncol(x) %/% 3 + 1)]
  
  for (n in 1:length(C)){
    
    if (any(sapply(redom, function(redom_item) C[n] %in% redom_item))){
      
      f <- which(sapply(redom, function(redom_item) C[n] %in% redom_item))
      
      for (k in 1:length(redom[[f]])){
        
        a = as.data.frame(
          get_candles(redom[[f]][k], from=from, interval='daily')[,c(3,8)]
        )
        
        if (k == 2){ 
          
          message(
            sprintf(
              "%s is downloaded; %s from %s", C[n], which(C == C[n]), length(C)
            )
          )
        }
        
        a <- a[!duplicated(a),] # Remove duplicates
        
        a <- xts(a[, 1], order.by = as.Date(a[, 2]))
        
        if (x[n] == "AGRO") a <- a / 7.01
        
        colnames(a) <- redom[[f]][2]
        
        if (is.null(R)) R <- data.frame(a) else R <- rbind.data.frame(R, a)
      }
    } else {
      
      a = as.data.frame(get_candles(C[n], from=from, interval='daily')[,c(3,8)])
      
      a <- a[apply(a, 1, function(x) all(!is.na(x))),] # Eliminate NAs
      
      message(
        sprintf(
          "%s is downloaded; %s from %s", 
          C[n], which(C == C[n]), length(C)
        )
      )
      
      a <- a[!duplicated(a),] # Remove duplicates
      
      a <- xts(a[, 1], order.by = as.Date(a[, 2]))
      
      colnames(a) <- C[n]
      
      R <- data.frame(a) 
    }
    
    R <- as.timeSeries(R) # Make it time series
    
    if (x[n] == "BELU"){ j <- which(rownames(R) == "2024-08-15")
    
      R[c(1:j),] <- R[c(1:j),]/8 } # Adjustments for Novabev stock
    
    p <- cbind(p, R) 
    R <- NULL  # Reset R for next iteration
  }
  
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
