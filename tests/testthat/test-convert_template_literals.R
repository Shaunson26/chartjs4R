test_that("convert_template_literals converts template literals", {

  result <- convert_template_literals('${label} : ${y} : ${x} : ${tooltip}')
  expected <- "`${e.dataset.label} : ${e.formattedValue} : ${e.label} : ${e.dataset.tooltip}`"

  expect_identical(result, expected)

  result <- convert_template_literals('label ${label} : y ${y} : x ${x} : tooltip ${tooltip}')
  expected <- "`label ${e.dataset.label} : y ${e.formattedValue} : x ${e.label} : tooltip ${e.dataset.tooltip}`"

  expect_identical(result, expected)
})

test_that("convert_template_literals converts template literals with spaces", {

  result <- convert_template_literals('${ label} : ${y } : ${ x } : ${  tooltip   }')
  expected <- "`${e.dataset.label} : ${e.formattedValue} : ${e.label} : ${e.dataset.tooltip}`"

  expect_identical(result, expected)
})


test_that("convert_template_literals exits without template literals", {


  result <- convert_template_literals('hello')
  expected <- "\"hello\""

  expect_identical(result, expected)

})

test_that("convert_template_literals catches errors", {

  expect_error(convert_template_literals('${label} : ${y} : ${x} : ${tooltip'),
               regexp = 'There seems to be missing')

  expect_error(convert_template_literals('$'),
               regexp = 'There seems to be missing')

  expect_error(convert_template_literals('{'),
               regexp = 'There seems to be missing')

  expect_error(convert_template_literals('}'),
               regexp = 'There seems to be missing')


})


