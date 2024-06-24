df_positions <- new.portfolio.function("MDMG", "2022-07-11", "2024-03-29", 12)

df_positions <- new.portfolio.function("OZON", "2022-06-30", "2024-03-29", 7,
                                       df_positions)

df_positions <- new.portfolio.function("LKOH", c("2022-02-07", "2023-05-19"),
                                       c("2023-05-18", "2024-03-29"), c(1, 1),
                                       df_positions)

df_positions <- new.portfolio.function("RASP", c("2022-05-10", "2022-07-27"),
                                       c("2022-07-26", "2024-03-29"), c(10, 10),
                                       df_positions)

df_positions <- new.portfolio.function("FESH", "2022-08-01", "2024-03-29", 100,
                                       df_positions)

df_positions <- new.portfolio.function("PIKK", c("2022-02-10", "2024-02-05"),
                                       c("2024-02-04", "2024-03-29"), c(6, 4),
                                       df_positions)

df_positions <- new.portfolio.function("ABRD", "2022-06-30", "2024-03-29", 30,
                                       df_positions)

df_positions <- new.portfolio.function("AKRN", "2022-06-17", "2024-03-29", 1,
                                       df_positions)

df_positions <- new.portfolio.function("GCHE", "2022-06-30", "2024-03-29", 2,
                                       df_positions)

df_positions <- new.portfolio.function("UPRO", c("2022-07-11", "2022-10-04"),
                                       c("2022-10-03", "2024-03-29"),
                                       c(3000, 1000), df_positions)

df_positions <- new.portfolio.function("MGNT", c("2022-02-18", "2023-05-19"),
                                       c("2023-05-18", "2024-03-29"), c(1, 1),
                                       df_positions)

df_positions <- new.portfolio.function("BELU", "2022-06-30", "2024-03-29", 2,
                                       df_positions)

df_positions <- new.portfolio.function("DIOD", "2022-07-05", "2024-03-29", 800,
                                       df_positions)

df_positions <- new.portfolio.function("BRZL", "2022-07-26", "2024-03-29", 5,
                                       df_positions)

df_positions <- new.portfolio.function("TTLK", "2022-07-25", "2024-03-29",
                                       10000, df_positions)

df_positions <- new.portfolio.function("QIWI", c("2022-02-18", "2023-05-10"),
                                       c("2023-05-09", "2024-03-29"), c(9, 7),
                                       df_positions)

df_positions <- new.portfolio.function("PHOR", "2022-02-07", "2024-03-29", 1,
                                       df_positions)

df_positions <- new.portfolio.function("MAGN",
                                       c("2022-02-18", "2023-05-19",
                                         "2024-04-10", "2024-04-11"),
                                       c("2023-05-18", "2024-05-18",
                                         "2024-04-09", "2024-04-10"),
                                       c(80, 80, 10, 10), df_positions)

df_positions <- new.portfolio.function("NVTK",
                                       c("2022-02-07", "2023-06-20",
                                         "2024-02-05"),
                                       c("2023-06-19", "2024-02-04",
                                         "2024-03-29"), c(3, 2, 5),
                                       df_positions)

df_positions <- new.portfolio.function("BISVP", "2024-05-28", "2024-06-29",
                                       100, df_positions)
