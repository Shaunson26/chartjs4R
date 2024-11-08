test_that("how to check this?", {

  res <- cjs_defaults(borderColor = 'pink', font = list(size = 16))

  expect_s3_class(res, 'shiny.tag')
  expect_equal(as.character(res), '<script>updateObjectInPlace(Chart.defaults, {"borderColor":"pink","font":{"size":16}} );</script>')
})
