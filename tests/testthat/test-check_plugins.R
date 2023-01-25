test_that("logic works", {
  a_plugin <- list(id = 'this', `function` = 'that')
  expect_error(check_plugins(a_plugin), regexp = 'unnamed list')
  expect_invisible(check_plugins(list(a_plugin)))
})
