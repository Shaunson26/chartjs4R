test_that("get_non_null_parameters removes p, id, NULL and missing", {

  f <-
    function(p = 'p',
             id = 'id',
             param1 = 1,
             param2 = NULL,
             param3 = list(1 , NULL),
             param4){
      parameters <- as.list(environment())
      get_non_null_parameters(parameters)
    }

  result_test <- f()

  result_expected <-
    list(#p = 'p',
      #id = 'id',
      param1 = 1,
      #param2 = NULL,
      param3 = list(1 , NULL)
    )

  expect_identical(result_test, result_expected)
})


