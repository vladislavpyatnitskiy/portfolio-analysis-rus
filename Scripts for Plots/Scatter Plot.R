lapply(c("quantmod", "ggplot2", "ggrepel"), require, character.only = T) # Libs

rus.scatter.plt <- function(x){ # Scatter plot of portfolio's securities
  
  d <- NULL # Empty variable to contain values
  
  for (n in 1:ncol(x)){ s <- x[,n] # For each security in data frame
  
    j <- diff(log(s))[-1] # Clean data to reduce NA and calculate return
  
    d <- rbind.data.frame(d, cbind(sd(j)*1000, (exp(sum(j))-1)*100)) } # Join
  
  # Plot
  ggplot(d, mapping = aes(x = d[,1], y = d[,2])) + geom_point() +
    geom_text_repel(aes(label = colnames(x))) + theme_minimal() +
    theme(plot.title = element_text(hjust = .5)) +
    scale_y_continuous(trans='log10') +
    labs(title = "Performance of Portfolio Securities",
         x = "Risk (Standard Deviation)", y = "Return (%)")
}
rus.scatter.plt(rus.df1) # Test
