
# output: plot ---------------------------------------------------------------

test_that(
  desc = "grouped_ggcorrmat plots work",
  code = {
    skip_on_cran()
    skip_if_not_installed("ggcorrplot")

    # with grouping.var missing ---------------------------------------------

    expect_error(grouped_ggcorrmat(iris))

    # with cor.vars specified -----------------------------------------------

    # creating a smaller dataframe
    set.seed(123)
    movies_filtered <-
      movies_long %>%
      dplyr::filter(mpaa != "NC-17") %>%
      dplyr::sample_frac(tbl = ., size = 0.25)

    # when arguments are entered as bare expressions
    set.seed(123)
    expect_true(inherits(
      suppressWarnings(grouped_ggcorrmat(
        data = movies_filtered,
        grouping.var = mpaa,
        cor.vars = length:votes,
        type = "p"
      )),
      what = "gg"
    ))

    # when arguments are entered as character
    set.seed(123)
    expect_true(inherits(
      suppressWarnings(grouped_ggcorrmat(
        data = movies_filtered,
        grouping.var = "mpaa",
        cor.vars = c("length":"votes"),
        cor.vars.names = c("w", "x", "y", "z"),
        type = "np"
      )),
      what = "gg"
    ))

    # without cor.vars specified -------------------------------------------

    # when arguments are entered as bare expressions
    set.seed(123)
    expect_true(inherits(
      suppressWarnings(grouped_ggcorrmat(
        data = movies_filtered,
        grouping.var = mpaa,
        type = "p"
      )),
      what = "gg"
    ))

    # when arguments are entered as bare expressions
    set.seed(123)
    expect_true(inherits(
      suppressWarnings(grouped_ggcorrmat(
        data = movies_filtered,
        grouping.var = "mpaa",
        type = "r"
      )),
      what = "gg"
    ))
  }
)

# output: stats ---------------------------------------------------------------

test_that(
  desc = "grouped_ggcorrmat stats work",
  code = {
    skip_on_cran()
    skip_if_not_installed("ggcorrplot")

    # without cor.vars specified --------------------------------------------

    # tidy dataframe
    set.seed(123)
    df1 <-
      grouped_ggcorrmat(
        data = ggplot2::msleep,
        grouping.var = vore,
        output = "r",
        k = 3
      )

    # testing dataframe
    expect_equal(dim(df1), c(60L, 12L))
  }
)
