#' Get a historical currency rate from the specified date
#'
#'
#' @param date the date of interest, a string (character vector) in the format 'YYYY-MM-DD'
#' @param symbol currency symbol of interest, for example "CAD"
#' @param base_symbol currency symbol as a reference base 1, for example "USD"
#' @param access_key access key for the fixer.io api, a string.
#' @return currency rate.
#'
#' @export
#'
#' @examples
#' rate = get_historical_rate('2018-01-01', 'CAD', 'EUR', access_key = your_key)
#'

get_period_rate <- function(start_date, end_date, symbol="CAD", base_symbol="USD", access_key = "191cbf81c6f2962c6bd1488c674daf77"){

  # assure input types:
  if(!is.character(start_date)){
    stop('TypeError: start date must be a string, for example "2018-01-01"')
  }
  if(!is.character(end_date)){
    stop('TypeError: end date must be a string, for example "2018-01-01"')
  }
  if(!is.character(symbol)){
    stop('TypeError: currency symbol must be a string, for example "CAD"')
  }
  if(!is.character(base_symbol)){
    stop('TypeError: base_symbol must be a string, for example "USD"')
  }
  if(!is.character(access_key)){
    stop('TypeError: access_key must be a string format')
  }

  # assure input date is valid
  sd <- try(as.Date(start_date, format= "%Y-%m-%d"))
  if(class(sd) == "try-error" | is.na(sd)){
    stop("ValueError: start date is not the correct format. It should be 'YYYY-MM-DD', for example '2018-01-01'")
  }
  ed <- try(as.Date(end_date, format= "%Y-%m-%d"))
  if(class(ed) == "try-error" | is.na(ed)){
    stop("ValueError: end date is not the correct format. It should be 'YYYY-MM-DD', for example '2018-01-01'")
  }

  # assure start date is before end date
  if (sd > ed) {
    stop('ValueError: the start date must be before the end date.')
  }

  # assure input date is in range
  if ( sd>Sys.Date() | sd<as.Date('1999-01-01', format= "%Y-%m-%d" ))
  {
    stop('ValueError: start date is not in range. Data is avaiable from 1999-01-01 to now!')
  }
  if ( ed>Sys.Date() | ed<as.Date('1999-01-01', format= "%Y-%m-%d" ))
  {
    stop('ValueError: end date is not in range. Data is avaiable from 1999-01-01 to now!')
  }

  # assure the duration is less than 30 days
  duration <- as.numeric(ed-sd) + 1
  if (duration > 30) {
    stop('ValueError: the specified duration must be less than 30 days.')
  }

  # load symbols data from package (included)
  data("symbols")
  # assure symbol is available
  if (!(symbol %in% symbols$symbol)){
    stop(paste0("ValueError: the input symbol is not available, please check the symbols list by loading data symbols"))
  }
  # assure symbol is available
  if (!(base_symbol %in% symbols$symbol)){
    stop(paste0("ValueError: the input base_symbol is not available, please check the symbols list by loading data symbols"))
  }


  base_url = "http://data.fixer.io/api/"

  rate_df <- data.frame()

  for (i in 1:duration-1) {
    # build url
    date <- sd + i
    url <- paste0(base_url, date, '?access_key=', access_key)

    # read data
    r <- httr::GET(url)
    data <- httr::content(r)

    # assure no access errors
    if(!data$success){
      stop(paste0('API call fails. Error ', data$error[[1]], ': ', data$error[[2]], '\n    Message: ', data$error[[3]]))
    }

    rate <- data$rates[symbol][[1]]/data$rates[base_symbol][[1]]

    rate_df <- rbind(rate_df, data.frame(date=date, rate=rate))
  }

  return(rate_df)
}
