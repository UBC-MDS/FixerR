context("Testing get_current_rate()")

access_key = "be0ea5ac928a149aec0872afcdb3bca7"

# Exceptional Cases

test_that("Datatype errors", {
  expect_error(get_current_rate(symbol = 123, access_key = access_key), 'TypeError: currency symbol must be a string, for example "CAD"')
  expect_error(get_current_rate(symbol = "CAD", base_symbol = 123, access_key = access_key), 'TypeError: base_symbol must be a string, for example "USD"')
  expect_error(get_current_rate(symbol = "CAD", base_symbol = "USD", access_key = 123), 'TypeError: access_key must be a string format')
})

test_that("Value errors", {

  symbol <- 'AAA'
  expect_error(get_current_rate(symbol = symbol, base_symbol = "USD", access_key = access_key), 
               "ValueError: the input symbol is not available, please check the symbols list by loading data symbols")
  base_symbol <- 'AAA'
  expect_error(get_current_rate(symbol = "CAD", base_symbol = base_symbol, access_key = access_key), 
               "ValueError: the input base_symbol is not available, please check the symbols list by loading data symbols")
  
})
