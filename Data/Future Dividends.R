library(rvest) # Library

rus.future.divs <- function(x){ # Fututre Dividends of Portfolio Securities
  
  s <- x[[1]] # Get tickers from the nested list with portfolio info
  
  q <- x[[4]] # Get number of stocks for each company in portfolio
  
  f <- read_html("https://smart-lab.ru/dividends/") %>% html_nodes('table') %>%
    .[[1]] %>% html_nodes('tr') # Get HTML from Smart-Lab.ru
  
  L <- NULL # Show only approved dividends 
  
  for (n in 1:length(f)){ if (isTRUE(f[n] %>% html_attr('class') ==
                                     "dividend_approved")){
    
      L <- c(L, f[n] %>% html_nodes('td') %>% html_text()) } }
  
  D <- data.frame(L[seq(from = 2, to = length(L), by = 11)],
                  L[seq(from = 1, to = length(L), by = 11)],
                  format(as.numeric(gsub(",",".",L[seq(from=4, to=length(L),
                                                       by=11)])),scientific=F),
                  as.numeric(gsub(",", ".",
                                  strsplit(L[seq(from=5, to=length(L), by=11)],
                                           split="%"))),
                  L[seq(from = 7, to = length(L), by = 11)],
                  L[seq(from = 8, to = length(L), by = 11)],
                  L[seq(from = 9, to = length(L), by = 11)],
                  format(as.numeric(gsub(",",".",L[seq(from=10, to=length(L),
                                                       by=11)])),scientific=F))
  
  colnames(D) <- c("Тикер","Название","Стоимость дивидендов","Доходность (%)",
                   "Купить до", "День Закрытия Реестра", "Выплата До", "Цена")
  
  d <- c(s, D[,1]) # Tickers that are both in portfolio and dividends history
  
  a <- d[which(duplicated(d))] # Show only duplicates
  
  A <- NULL # Subtract Dividends of Portfolio Stocks from History
  Q <- NULL # Get number of each stock up to date
  
  for (n in 1:length(a)){ h <- a[n][[1]] # Ticker
    
    A <- rbind.data.frame(A, D[D$Тикер == h,]) # row with info for each stock
  
    m <- q[which(s == h)][[1]][length(q[which(s == h)][[1]])] # Stock Number
  
    Q <- rbind.data.frame(Q, m) } # Data frame with numbers for each stock
  
  rownames(A) <- seq(nrow(A)) # Change row names
  
  M <- data.frame(A[,1:3], Q) # Data Frame with Total Dividends
  
  M$`Общая Стоимость` <- as.numeric(M[,3]) * as.numeric(M[,4]) # Sum
  
  M$`После Налога` <- M[,5] * .87 # Dividends after tax
  
  colnames(M)[3:4] <- c("Стоимость дивидендов", "Число Акций") # Fix Columns
  
  list(A[,-c(2,3)], M, # Message with Total Sum of Dividends before & after tax
       sprintf("Общая Стоимость Дивидендов До Налога: %s рублей", sum(M[,5])),
       sprintf("Общая Стоимость Дивидендов После Налога: %s рублей",sum(M[,6]))) 
}
rus.future.divs(pos.df.new) # Test
