context("Testing get_historical_rate()")

access_key = Sys.getenv('ACCESS_KEY')

# Exceptional Cases

test_that("Datatype errors", {
  expect_error(get_historical_rate(20180101, access_key = access_key), 'TypeError: date must be a string, for example "2018-01-01"')
  expect_error(get_historical_rate('2018-01-01', symbol = 123, access_key = access_key), 'TypeError: currency symbol must be a string, for example "CAD"')
  expect_error(get_historical_rate('2018-01-01', symbol = "CAD", base_symbol = 123, access_key = access_key), 'TypeError: base_symbol must be a string, for example "USD"')
  expect_error(get_historical_rate('2018-01-01', symbol = "CAD", base_symbol = "USD", access_key = 123), 'TypeError: access_key must be a string format')
})

test_that("Value errors", {
  expect_error(get_historical_rate('01011998', symbol = "CAD", base_symbol = "USD", access_key = access_key), 
               "ValueError: input date is not the correct format. It should be 'YYYY-MM-DD', for example '2018-01-01'")
  expect_error(get_historical_rate('1998-01-01', symbol = "CAD", base_symbol = "USD", access_key = access_key), 
               'ValueError: input date is not in range. Data is avaiable from 1999-01-01 to now!')
  expect_error(get_historical_rate('2100-01-01', symbol = "CAD", base_symbol = "USD", access_key = access_key), 
               'ValueError: input date is not in range. Data is avaiable from 1999-01-01 to now!')
  symbol <- 'AAA'
  expect_error(get_historical_rate('2018-01-01', symbol = symbol, base_symbol = "USD", access_key = access_key), 
               "ValueError: the input symbol is not available, please check the symbols list by loading data symbols")
  base_symbol <- 'AAA'
  expect_error(get_historical_rate('2018-01-01', symbol = "CAD", base_symbol = base_symbol, access_key = access_key), 
               "ValueError: the input base_symbol is not available, please check the symbols list by loading data symbols")
  
})

# normal output cases

test_that("Output errors",{
  rate <- get_historical_rate('2018-01-01', symbol = "CAD", base_symbol = "USD", access_key = access_key)
  expect_equal(object = rate, expected = 1.25551, tolerance = .00001)
  rate <- get_historical_rate('2018-01-01', symbol = "CNY", base_symbol = "CAD", access_key = access_key)
  expect_equal(object = rate, expected = 5.182116, tolerance = .00001)
})

