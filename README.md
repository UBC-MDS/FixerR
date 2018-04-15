# FixerR

[![Build Status](https://travis-ci.org/UBC-MDS/FixerR.svg?branch=master)](https://travis-ci.org/UBC-MDS/FixerR)

DSCI 525 Group Project, April 2018

**Collaborators:**

- Guanchen Zhang
- Shun Chi
- Xiaomeng (Sophia) Wang
- Xin (Alex) Guo

## Overview

`FixerR` is an R API wrapper package for the APIs provided by [Fixer](https://fixer.io) for current and historical foreign currency exchange rates.

> Powered by 15+ exchange rate data sources, the Fixer API is capable of delivering real-time exchange rate data for 170 world currencies. The API comes with multiple endpoints, each serving a different use case. Endpoint functionalities include getting the latest exchange rate data for all or a specific set of currencies, converting amounts from one currency to another, retrieving Time-Series data for one or multiple currencies and querying the API for daily fluctuation data.

This R package implements the APIs offered in the [free tier](https://fixer.io/product), including queries for:

- the current exchange rates based on a reference currency
- historical exchange rates on a given date
- historical exchange rates within a given date range (no more than 30 days)

Users can define the target and base currencies and the date range.

## Functions

- `get_current_rate`

This function can get the latest currency exchange rate for two specified currencies.

- `get_historical_rate`

This function can get the historical currency exchange rate on a specified date for two specified currencies.

- `get_period_rate`

This function can get daily historical currency exchange rates for two specified currencies between two dates of your choice, with a maximum time frame of 30 days.

## Installation

To install `FixerR`, follow the steps below:

1. Please check if `devtools` has been installed. If not, open the console and enter `install.packages("devtools")` to install `devtools` from CRAN.
2. Enter the following in the console to install `FixerR`:
```
devtools::install_github("UBC-MDS/FixerR", build_vignettes = TRUE)
```
3. Get an Fixer API Access Key from [here](https://fixer.io/product).
4. You are all set to go!

_Note:_ to build the vignettes, you need to run the following R code to setup your API key on your local machine _before installing the package_. Otherwise, set `build_vignettes = FALSE` or ignore the argument.

```r
Sys.setenv("ACCESS_KEY" = "YOUR_KEY")
```

After the install, run the following to view the vignettes.

```r
library(FixerR)
browseVignettes('FixerR')
```

## Usage

`library(FixerR)`

1. `get_current_rate(symbol, base_symbol, access_key)`
	- Arguments:
		- `symbol`: currency symbol of interest, for example "CAD"
		- `base_symbol`: currency symbol as a reference base 1, for example "USD"
		- `access_key`: access key for the fixer.io api, a string.
	- Return:
		- latest currency exchange rate between these two currencies
	- Example:
		- `get_current_rate('CAD', 'EUR', access_key = your_key)`

2. `get_historical_rate(date, symbol, base_symbol, access_key)`
	- Arguments:
		- `date`: the date of interest, a string in the format 'YYYY-MM-DD'
		- `symbol`: currency symbol of interest, for example "CAD"
		- `base_symbol`: currency symbol as a reference base 1, for example "USD"
		- `access_key`: access key for the fixer.io api, a string.
	- Return:
		- currency exchange rate on the specified date
	- Example:
		- `get_historical_rate('2018-01-01', 'CAD', 'EUR', access_key = your_key)`

3. `get_period_rate(start_date, end_date, symbol, base_symbol, access_key)`
	- Arguments:
		- `start_date`: the start date of interest, a string in the format 'YYYY-MM-DD'
		- `end_date`: the end date of interest, a string in the format 'YYYY-MM-DD'
		- `symbol`: currency symbol of interest, for example "CAD"
		- `base_symbol`: currency symbol as a reference base 1, for example "USD"
		- `access_key`: access key for the fixer.io api, a string.
	- Return:
		- a data frame of the currency exchange rates in the specified period
	- Example:
		- `get_period_rate('2018-01-01', '2018-01-15', 'CAD', 'EUR', access_key = your_key)`

## Contributing

We welcome all suggestions and PRs. Please find the document [here](CONTRIBUTING.md) for more information on how to contribute to this project :sparkles: :sparkles: :sparkles:
