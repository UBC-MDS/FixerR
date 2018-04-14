#' Get a historical currency rate from the specified date
#'
#' @param date the date of interest, a string in the format 'YYYY-MM-DD'
#' @param symbol currency symbol of interest, for example "CAD"
#' @param base_symbol currency symbol as a reference base 1, for example "USD"
#' @param access_key access key for the fixer.io api, a string.
#' @return currency rate
#'
#' @export
#'
#' @examples
#' get_historical_rate('2018-01-01', 'CAD', 'EUR', access_key = your_key)


get_historical_rate <- function(date, symbol="CAD", base_symbol="USD", access_key = "be0ea5ac928a149aec0872afcdb3bca7"){

  # assure input types:
  if(!is.character(date)){
    stop('TypeError: date must be a string, for example "2018-01-01"')
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
  d <- try( as.Date( date, format= "%Y-%m-%d" ) )
  if( class(d) == "try-error" | is.na(d) ){
    stop("ValueError: input date is not the correct format. It should be 'YYYY-MM-DD', for example '2018-01-01'")
  }

  # assure input date is in range
  if ( d>Sys.Date() | d<as.Date('1999-01-01', format= "%Y-%m-%d" ))
  {
    stop('ValueError: input date is not in range. Data is avaiable from 1999-01-01 to now!')
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


  # build url
  base_url = "http://data.fixer.io/api/"
  url <- paste0(base_url, date, '?access_key=', access_key)

  # read data
  r <- httr::GET(url)
  data <- httr::content(r)

  # assure no access errors
  if(!data$success){
    stop(paste0('API call fails. Error ', data$error[[1]], ': ', data$error[[2]], '\n    Message: ', data$error[[3]]))
  }

  return(data$rates[symbol][[1]]/data$rates[base_symbol][[1]])
}
