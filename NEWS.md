# rgho rc

  * `verbose` and `retry` can now be set by `options()`.
  * Memoise results for a limited time (1h by default).
  * Request details explained in new vignette.
  * Now relies on json instead of XML.

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
