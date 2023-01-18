test_that("relist_parameter_vector works", {

  f <-
    function(a = 1,
             b.a = 1,
             b.b = 1,
             b.c.a = 1,
             b.c.b = 1){

      parameters <- as.list(environment())
      relist_parameter_vector(parameters)
    }

  result <- f()
  expected <- list(a = 1, b = list(a = 1, b = 1, c = list(a = 1, b = 1)))

  expect_identical(result, expected)


})
