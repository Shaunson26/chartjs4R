test_that("get_non_null_parameters removes p, id and NULL", {

  parameters <-
    list( p = 'p',
          id = 'id',
          param1 = 1,
          param2 = NULL,
          param3 = list(1 , NULL)
    )

  result_test <-
    get_non_null_parameters(parameters)

  result_expected <-
    list(#p = 'p',
         #id = 'id',
         param1 = 1,
         #param2 = NULL,
         param3 = list(1 , NULL)
    )
  expect_identical(result_test, result_expected)
})
