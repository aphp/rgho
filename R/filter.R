list_to_filter <- function(x){
  x <- Filter(function(y) !is.null(y), x)
  res <- lapply(seq_along(x), function(i){
    if(names(x[i]) %in% c("REGION", "COUNTRY", "WORLDBANKINCOMEGROUP")){
      return(list(SpatialDimType = names(x[i]),
                  SpatialDim = x[[i]]))
    }
    if (names(x[i]) %in% c("YEAR", "MONTH")){
      return(list(TimeDimType = names(x[i]),
                  TimeDim = x[[i]]))
    }
    if (names(x[i]) %in% c("SEX")){
      return(list(Dim1Type = names(x[i]),
                  Dim1 = x[[i]]))
    } else {
      x[i]
    }
  })
  res <- unlist(res, recursive = FALSE)

  names(res) <- paste0(names(res), ".eq")
  do.call(ODataQuery::and_query, res)
}
