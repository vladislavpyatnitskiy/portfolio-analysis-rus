# Stock Data Analysis of Russian Portfolio

[![R](https://img.shields.io/badge/R-4.x-blue.svg)](https://www.r-project.org/)
![GitHub last commit](https://img.shields.io/github/last-commit/vladislavpyatnitskiy/portfolio-analysis-rus.svg)

Welcome to the repository! It is an addition to [Portfolio_Analysis](https://github.com/vladislavpyatnitskiy/Portfolio_Analysis) repository which concentrated on tracking of portfolio consisting of Russian Stocks. As Data Frame Formats are similar ones to original one, all capabilties from original repository are valid to data frames made of Russian stocks.

Добро пожаловать в репозиторий! Это дополнение к репозиторию [Portfolio_Analysis](https://github.com/vladislavpyatnitskiy/Portfolio_Analysis), которое сосредоточено на самостоятельном отслеживании портфеля, состоящего из российских акций. Поскольку форматы фреймов данных аналогичны формату Portfolio_Analysis, все возможности исходного репозитория действительны для фреймов данных, состоящих из российских акции.

| | MARKET/CAP | P/E | P/BV | P/S | P/FCF | EV/EBITDA | DEBT/EBITDA |
|---|---|---|---|---|---|---|---|
| LKOH | 4841 | 4.19 | 0.77 | 0.61 | 4.86 | 2.02 | -0.39 |
| FESH | 192.3 | 5.09 | 1.52 | 1.12 | -10.5 | 3.99 | 0.41 |
| ABRD | 22.4 | 17.5 | 1.67 | 1.59 | -13.1 | 10.7 | 3.01 |
| AKRN | 563.7 | 15.8 | 2.77 | 3.14 | 41.7 | 8.56 | 0.37 |
| GCHE | 189 | 6.91 | 1.69 | 0.83 | -99.4 | 5.7 | 1.91 |
| UPRO | 116.5 | 5.29 | 0.77 | 0.98 | 5.65 | 1.5 | -1.13 |
| OZON | 855.1 | -20 | -12.7 | 2.01 | 12.2 | 187.4 | -15.5 |
| MDMG | 63.2 | 8.08 | 1.83 | 2.29 | 9.71 | 5.88 | -0.98 |
| RASP | 192.4 | 5.55 | 0.95 | 1.03 | 53.4 | 2.68 | -0.49 |
| MGNT | 618.9 | 10.5 | 8.79 | 0.24 | 42 | 4.72 | 0.99 |
| BELU | 85.3 | 10.6 | 5.37 | 0.73 | 73.7 | 5.16 | 0.73 |
| DIOD | 1.35 | 168.6 | 1.44 | 2.46 | -57.4 | 109.6 | -2.83 |
| BRZL | 15 | 7.23 | 0.86 | 4.68 | NA | NA | NA |
| TTLK | 17 | 6.48 | 1.38 | 1.55 | 13 | 3.46 | -1.34 |
| PHOR | 741.4 | 7.1 | 4.97 | 1.68 | 12.2 | 5.23 | 1.2 |
| MAGN | 597.4 | 5.05 | 0.91 | 0.78 | 19 | 2.59 | -0.47 |
| NVTK | 3314 | 7.15 | 1.28 | 2.41 | 21.3 | 3.73 | 0.01 |
| PIKK | 565.3 | 8.95 | 1.63 | 0.96 | NA | 5.12 | 1.07 |
#### Table. 1. Fundamentals of Portfolio Securities from smart-lab.ru
--------------------------------------------------------------------
## Data Visualisation Capabilities
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Monthly%20Portfolio%20Returns.png?raw=true)
#### Fig. 1. Bar Plot of Monthly Portfolio Returns
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Line%20plot%20of%20Portfolio.png?raw=true)
#### Fig. 2. Plot of Portfolio Returns
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Portfolio%20Comparison%20with%20IMOEX.png?raw=true)
#### Fig. 3. Plot of Comparison between Portfolio and IMOEX Returns
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Dividends%20Accumulation.png?raw=true)
#### Fig. 4. Plot of Portfolio Dividends Accumulation
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Scatter%20Plot.png?raw=true)
#### Fig. 5. Scatter Plot for Risk and Return of Portfolio Securities
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Pie%20Plot.png?raw=true)
#### Fig. 6. Pie Plot of Portfolio Securities
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Dividend%20Pie.png?raw=true)
#### Fig. 7. Portfolio Dividend Pie
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Pie%20Plot%20of%20Securities%20Sectors.png?raw=true)
#### Fig. 8. Pie Plot of Portfolio Securities by Sectors
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Pie%20Plot%20of%20Portfolio%20by%20Industries.png?raw=true)
#### Fig. 9. Pie Plot of Portfolio Securities by Industries
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Pie%20Plot%20by%20Market%20Cap.png?raw=true)
#### Fig. 10. Pie Plot of Portfolio Securities by Market Cap Levels

| Market Level | Amount |
|---|---|
| Micro-Cap | <= 1 billion Roubles |
| Small-Cap | from 1 to 10 billion Roubles |
| Mid-Cap | from 10 to 100 billion Roubles | 
| Large-Cap | from 100 to 1,000 billion (1 trillion) Roubles |
| Mega-Cap | => 1 trillion Roubles |

--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Stacked%20Bar%20Plot.png?raw=true)
#### Fig. 11. Stacked Bar Plot of Portfolio Securitites
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Stacked%20Bar%20Plot%20by%20Sector%20(Roubles).png?raw=true)
#### Fig. 12. Stacked Bar Plot of Portfolio by Sectors
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Stacked%20Bar%20Plot%20of%20Dividends.png?raw=true)
#### Fig. 13. Stacked Bar Plot of Portfolio Dividends
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Stacked%20Bar%20Plot%20Sector%20Dividends.png?raw=true)
#### Fig. 14. Stacked Bar Plot of Portfolio Dividends by Sector
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Heatmap%20of%20Portfolio%20Securities.png?raw=true)
#### Fig. 15. Correlation Heatmap
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Correlation%20Bar%20Plot%20of%20Russian%20Portfolio.png?raw=true)
#### Fig. 16. Bar Plot of Median Correlation Values
```
[1] "Consider to sell one of these Assets: MGNT, RASP, NVTK"
[2] "Check these Assets: OZON, FESH, MDMG, LKOH"            
[3] "OK to keep Assets: PIKK, TTLK, ABRD, UPRO, GCHE"       
[4] "Good Assets: BRZL, AKRN, MAGN, QIWI, PHOR"             
[5] "Great Assets: DIOD, BELU"        
```
#### Table. 2. Securities by Median Correlation Values
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Boxplot.png?raw=true)
#### Fig. 17. Box Plot of Portfolio Securities
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Histogram%20of%20Correlations.png?raw=true)
#### Fig. 18. Histogram of Portfolio Correlation Values
--------------------------------------------------------------------
![](https://github.com/vladislavpyatnitskiy/rus-stock-data-analysis/blob/main/Plots/Portfolio%20Histogram.png?raw=true)
#### Fig. 19. Histogram of Portfolio Returns
--------------------------------------------------------------------

## Data Analysis Capabilities
```
   Ticker Start Date   End Date Number
1    YDEX 2022-01-31 2024-02-05      1
2    NVTK 2022-02-07 2025-09-04      3
3    PHOR 2022-02-07 2025-09-04      1
4    LKOH 2022-02-07 2025-09-04      1
5    PIKK 2022-02-10 2025-09-04      6
6    MAGN 2022-02-18 2025-09-04     80
7    QIWI 2022-02-18 2025-09-04      9
8    MGNT 2022-02-18 2025-09-04      1
9    AKRN 2022-06-17 2025-09-04      1
10   OZON 2022-06-30 2025-09-04      7
11   GCHE 2022-06-30 2025-09-04      2
12   ABRD 2022-06-30 2025-09-04     30
13   BELU 2022-06-30 2024-08-15      2
14   DIOD 2022-07-05 2025-09-04    800
15   MDMG 2022-07-11 2025-09-04     12
16   UPRO 2022-07-11 2025-09-04   3000
17   TTLK 2022-07-25 2025-09-04  10000
18   BRZL 2022-07-26 2025-09-04      5
19   RASP 2022-07-27 2025-09-04     10
20   FESH 2022-08-01 2025-09-04    100
21   UPRO 2022-10-04 2025-09-04   1000
22   QIWI 2022-10-05 2025-09-04      7
23   RASP 2022-10-05 2025-09-04     10
24   YDEX 2022-12-14 2024-02-05      1
25   MAGN 2023-05-19 2025-09-04     80
26   MGNT 2023-05-19 2025-09-04      1
27   LKOH 2023-05-19 2025-09-04      1
28   NVTK 2023-06-20 2025-09-04      2
29   PIKK 2024-02-05 2025-09-04      4
30   NVTK 2024-02-05 2025-09-04      2
31   NVTK 2024-02-05 2025-09-04      3
32   MAGN 2024-04-10 2025-09-04     10
33   MAGN 2024-04-11 2025-09-04     10
34   BISV 2024-05-28 2025-09-04    100
35   BISV 2024-06-24 2025-09-04    100
36   BISV 2024-07-12 2025-09-04    100
37   BISV 2024-07-29 2025-09-04    200
38   BELU 2024-08-23 2025-09-04     14
39   BISV 2024-09-12 2025-09-04    100
40   BISV 2024-10-14 2025-09-04    100
41   BISV 2024-11-01 2025-09-04    100
42   MAGN 2024-12-27 2025-09-04     30
```
#### Table. 3. Portfolio Positions
--------------------------------------------------------------------
```
[[1]]
[1] "Time: 23:44:58"

[[2]]
   Ticker     Price Return Number         PnL Portion   Value
1    AKRN 15068.000   0.41      1   61.526541    8.90 15068.0
2    RASP   259.050   0.27     20   13.951032    3.06  5181.0
3    LKOH  6421.000   0.03      2    3.851445    7.59 12842.0
4    PIKK   731.100  -0.25     10  -18.323308    4.32  7311.0
5    MDMG   821.100  -0.47     12  -46.528725    5.82  9853.2
6    OZON  3293.000  -1.17      7 -272.889507   13.62 23051.0
7    FESH    60.880  -1.35    100  -83.312722    3.60  6088.0
8    UPRO     1.773  -1.61   4000 -116.049600    4.19  7092.0
9    PHOR  5119.000  -2.03      1 -106.068899    3.02  5119.0
10   TTLK     0.751  -2.21  10000 -169.721900    4.44  7510.0
11   NVTK   922.000  -2.99     10 -284.174827    5.45  9220.0
12   MGNT  4930.500  -3.11      2 -316.520900    5.82  9861.0
13   GCHE  4301.000  -3.24      2 -288.037205    5.08  8602.0
14   BRZL  1907.000  -3.49      5 -344.805202    5.63  9535.0
15   BELU   685.000  -4.06      2  -57.975818    0.81  1370.0
16   MAGN    43.675  -4.42    180 -363.547082    4.64  7861.5
17   DIOD    12.000  -4.46    800 -448.147376    5.67  9600.0
18  BISVP     9.890  -4.72    500 -244.966415    2.92  4945.0
19   ABRD   203.600  -5.57     30 -360.283385    3.61  6108.0
20   QIWI   192.400  -8.38     16 -281.565073    1.82  3078.4

[[3]]
[1] "Portfolio Value: 169296.1 Roubles" "Total PnL: -3723.59 Roubles"      
[3] "Return: -2.15 %"                   "IMOEX: -2.32 %"                  
```
#### Table. 4. Portfolio Tracking Info
--------------------------------------------------------------------
```
[[1]]
  Тикер Доходность (%)  Купить до День Закрытия Реестра Выплата До       Цена
1  PHOR            2.3 19.09.2024            22.09.2024 04.10.2024 5119.00000
2  GCHE            3.3 26.09.2024            29.09.2024 11.10.2024 4301.00000
3  MAGN            5.7 16.10.2024            17.10.2024 31.10.2024   43.67500

[[2]]
  Тикер   Название Стоимость дивидендов Число Акций Общая Стоимость После Налога
1  PHOR ФосАгро ао       117.0000000000           1          117.00     101.7900
2  GCHE ЧеркизГ-ао       142.1100000000           2          284.22     247.2714
3  MAGN        ММК         2.4940000000         180          448.92     390.5604

[[3]]
[1] "Общая Стоимость Дивидендов До Налога: 850.14 рублей"

[[4]]
[1] "Общая Стоимость Дивидендов После Налога: 739.6218 рублей"
```
#### Table. 5. Info about Future Dividend Payments
--------------------------------------------------------------------
```
         Date Ticker  Dividend Number  Total After Tax Cumulative Total
1  2022-05-03   NVTK  43.77000      3 131.31   118.179          118.179
2  2022-07-06   ABRD   3.44000     30 103.20    92.880          211.059
3  2022-09-29   PHOR 780.00000      1 780.00   702.000          913.059
4  2022-10-05   NVTK  45.00000      3 135.00   121.500         1034.559
5  2022-10-11   BELU 150.00000      2 300.00   270.000         1304.559
6  2022-11-03   MDMG   8.55000     12 102.60    92.340         1396.899
7  2022-12-08   GCHE 148.05000      2 296.10   266.490         1663.389
8  2022-12-15   PHOR 318.00000      1 318.00   286.200         1949.589
9  2022-12-19   LKOH 793.00000      1 793.00   713.700         2663.289
10 2023-01-19   BELU  75.00000      2 150.00   135.000         2798.289
11 2023-03-31   PHOR 465.00000      1 465.00   418.500         3216.789
12 2023-04-14   TTLK   0.05085  10000 508.50   457.650         3674.439
13 2023-04-24   BELU 400.00000      2 800.00   720.000         4394.439
14 2023-04-28   NVTK  60.58000      3 181.74   163.566         4558.005
15 2023-06-01   LKOH 438.00000      2 876.00   788.400         5346.405
16 2023-07-05   DIOD   0.80000    800 640.00   576.000         5922.405
17 2023-07-07   PHOR 264.00000      1 264.00   237.600         6160.005
18 2023-07-13   ABRD   6.33000     30 189.90   170.910         6330.915
19 2023-09-28   GCHE 118.43000      2 236.86   213.174         6544.089
20 2023-09-28   BELU 320.00000      2 640.00   576.000         7120.089
21 2023-10-09   NVTK  34.50000      5 172.50   155.250         7275.339
22 2023-12-14   LKOH 447.00000      2 894.00   804.600         8079.939
23 2023-12-22   PHOR 291.00000      1 291.00   261.900         8341.839
24 2023-12-26   BELU 135.00000      2 270.00   243.000         8584.839
25 2024-01-10   MGNT 412.13000      2 824.26   741.834         9326.673
26 2024-03-25   NVTK  44.09000     10 440.90   396.810         9723.483
27 2024-04-04   GCHE 205.38000      2 410.76   369.684        10093.167
28 2024-05-06   LKOH 498.00000      2 996.00   896.400        10989.567
29 2024-05-10   BELU 225.00000      2 450.00   405.000        11394.567
30 2024-05-16   AKRN 427.00000      1 427.00   384.300        11778.867
31 2024-05-24   TTLK   0.04887  10000 488.70   439.830        12218.697
32 2024-06-07   MAGN   2.75200    180 495.36   445.824        12664.521
```
#### Table. 6. Dividend Cash Flow History of the Russian Stocks' Portfolio
--------------------------------------------------------------------
```
Call:
lm(formula = r, data = d)

Residuals:
      Min        1Q    Median        3Q       Max 
-0.241178 -0.006582  0.000760  0.007857  0.176118 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)   
(Intercept)  0.0007495  0.0009252   0.810  0.41828   
Cocoa        0.1409243  0.0508018   2.774  0.00575 **
Cotton       0.0611305  0.0392163   1.559  0.11968   
Gold         0.1705198  0.1092781   1.560  0.11930   
Rice        -0.0933555  0.0643799  -1.450  0.14767   
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.02048 on 496 degrees of freedom
Multiple R-squared:  0.02873,	Adjusted R-squared:  0.0209 
F-statistic: 3.668 on 4 and 496 DF,  p-value: 0.005891
```
#### Table. 7. Regression of Commodity Factors
