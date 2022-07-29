# rgho 3.0.0
This new version of `rgho` now uses the most recent API of the WHO, 
which simplifies considerably the package, and relies on the package 
[ODataQuery.](https://CRAN.R-project.org/package=ODataQuery)

## Breaking changes
 * Objects created with get_gho_* are now of class "gho" and "data.frame"
 * Former lower-level access to the API do not work anymore
 * If a connection error occurs, the function returns an empty list with a 
  message as argument 
 * The proxy settings and the number of retries are now managed by `ODataQuery` 
 package.
 * There is no memoisation anymore
 * `get_gho_codes()` is superseded by `get_gho_values()` to better reflect the 
 new API terminology

# rgho 2.0.2
  * better handles connection fails

# rgho 2.0.1
  * fix errors caused by dplyr 0.8
  * fails gracefully on connection error 

# rgho 2.0.0

  * Changed repository

# rgho 1.0.1

## Bugfixes

  * Fixed bug where displayed waiting time was not used.

## Backend changes

  * Implemented vector methods for `gho` objects.
  * New `rgho.n` option for printing length.
  * Common help file for getter functions.

# rgho 1.0.0

## New features

  * Proxy settings are now handled through an `rgho.http_proxy` option.
  * Renamed functions:
    * `filter_attrs()` => `filter_gho()`.
    * `values_attrs()` => `display_attribute_values()`.
  * Created function `display_attributes()`.
  * Careful reintroduction of unit testing.

# rgho 0.2.3

## Bugfixes

  * Removed test suite until we figure out a way to avoid breaking the build every time the GHO database is updated.
  
# rgho 0.2.2

## Backend changes

  * `get_gho_data()` no longer memoised.

## Bugfixes

  * Filtering tests do not fail when new codes are added.
  * Correctly use proxy settings.

# rgho 0.2.1

## Bugfixes

  * Test do not fail when new codes are added.

## Backend changes

  * `verbose` and `retry` can now be set by `options()`.
  * Memoise results for a limited time (1h by default).
  * Technical details are explained in a vignette.
  * Package switched from XML to json.
  
## Bugfixes

  * Tests do not fail when new codes are added.

# rgho 0.2.0

  * Fix encoding problem with country names.
  * New `COUNTRY` vignette.
  * Tests written.
  * More robust `get_gho()` & `build_url()` functions.
  * Fixed bug where `get_gho()` would not retry a failed request.
  * Try to follow API best practices.
  * New function: `values_attrs()`.

# rgho 0.1.0

  * Fix bugs when handling empty data.
  * Fix problems with `tidyr` update.
  * More robust http get.
  * Optional debug mode.
