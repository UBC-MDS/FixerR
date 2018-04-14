context("Testing get_period_rate()")

access_key = "191cbf81c6f2962c6bd1488c674daf77"

# Exceptional Cases

test_that("Datatype errors", {
  expect_error(get_period_rate(20180101, '2018-01-03', access_key = access_key),
               'TypeError: start date must be a string, for example "2018-01-01"')
  expect_error(get_period_rate('2018-01-01', 20180103, access_key = access_key),
               'TypeError: end date must be a string, for example "2018-01-01"')
  expect_error(get_period_rate('2018-01-01', '2018-01-03', symbol = 123, access_key = access_key),
               'TypeError: currency symbol must be a string, for example "CAD"')
  expect_error(get_period_rate('2018-01-01', '2018-01-03', symbol = "CAD", base_symbol = 123, access_key = access_key),
               'TypeError: base_symbol must be a string, for example "USD"')
  expect_error(get_period_rate('2018-01-01', '2018-01-03', access_key = 123),
               'TypeError: access_key must be a string format')
})

test_that("Value errors", {
  expect_error(get_period_rate('01011998', '1998-01-03', symbol = "CAD", base_symbol = "USD", access_key = access_key),
               "ValueError: start date is not the correct format. It should be 'YYYY-MM-DD', for example '2018-01-01'")
  expect_error(get_period_rate('1998-01-01', '01031998', symbol = "CAD", base_symbol = "USD", access_key = access_key),
               "ValueError: end date is not the correct format. It should be 'YYYY-MM-DD', for example '2018-01-01'")
  expect_error(get_period_rate('2018-01-03', '2018-01-01', symbol = "CAD", base_symbol = "USD", access_key = access_key),
               'ValueError: the start date must be before the end date.')
  expect_error(get_period_rate('1998-12-31', '1999-01-01', symbol = "CAD", base_symbol = "USD", access_key = access_key),
               'ValueError: start date is not in range. Data is avaiable from 1999-01-01 to now!')
  expect_error(get_period_rate('2100-01-01', '2100-01-03', symbol = "CAD", base_symbol = "USD", access_key = access_key),
               'ValueError: start date is not in range. Data is avaiable from 1999-01-01 to now!')
  expect_error(get_period_rate('2018-01-01', '2100-01-03', symbol = "CAD", base_symbol = "USD", access_key = access_key),
               'ValueError: end date is not in range. Data is avaiable from 1999-01-01 to now!')
  expect_error(get_period_rate('2018-01-01', '2018-02-01', symbol = "CAD", base_symbol = "USD", access_key = access_key),
               'ValueError: the specified duration must be less than 30 days.')
  expect_error(get_period_rate('2018-01-01', '2018-01-03', symbol = 'AAA', base_symbol = "USD", access_key = access_key),
               "ValueError: the input symbol is not available, please check the symbols list by loading data symbols")
  expect_error(get_period_rate('2018-01-01', '2018-01-03', symbol = "CAD", base_symbol = 'AAA', access_key = access_key),
               "ValueError: the input base_symbol is not available, please check the symbols list by loading data symbols")

})


# normal output cases

rate_CAD_USD <- data.frame(date=as.Date(c('2018-01-01', '2018-01-02', '2018-01-03')),
                           rate=c(1.25551, 1.25046, 1.25471))
rate_CNY_CAD <- data.frame(date=as.Date(c('2018-01-01', '2018-01-02', '2018-01-03')),
                           rate=c(5.182116, 5.190813, 5.181268))

test_that("Output errors",{
  rate <- get_period_rate('2018-01-01', '2018-01-03', symbol = "CAD", base_symbol = "USD", access_key = access_key)
  expect_equal(object = rate, expected = rate_CAD_USD, tolerance = .00001)
  rate <- get_period_rate('2018-01-01', '2018-01-03', symbol = "CNY", base_symbol = "CAD", access_key = access_key)
  expect_equal(object = rate, expected = rate_CNY_CAD, tolerance = .00001)
})

