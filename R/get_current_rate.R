#' Get the currency rate for two specified currencies
#'
#'
#' @param symbol currency symbol of interest, for example "CAD"
#' @param base_symbol currency symbol as a reference base 1, for example "USD"
#' @param access_key access key for the fixer.io api, a string.
#' @return current exchange rate between these two currencies
#'
#' @export
#'
#' @examples
#' rate = get_current_rate('CAD', 'EUR', access_key = your_key)
#'

get_current_rate <- function(symbol="CAD", base_symbol="USD", access_key = "be0ea5ac928a149aec0872afcdb3bca7"){

  # assure input types:

  if(!is.character(symbol)){
    stop('TypeError: currency symbol must be a string, for example "CAD"')
  }
  if(!is.character(base_symbol)){
    stop('TypeError: base_symbol must be a string, for example "USD"')
  }
  if(!is.character(access_key)){
    stop('TypeError: access_key must be a string format')
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
  time <- 'latest'
  url <- paste0(base_url,time,'?access_key=', access_key)

  # read data
  r <- httr::GET(url)
  data <- httr::content(r)

  # assure no access errors
  if(!data$success){
    stop(paste0('API call fails. Error ', data$error[[1]], ': ', data$error[[2]], '\n    Message: ', data$error[[3]]))
  }

  return(data$rates[symbol][[1]]/data$rates[base_symbol][[1]])
}
