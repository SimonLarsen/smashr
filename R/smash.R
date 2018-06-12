#' Smash a nested list into a tidy table.
#'
#' @param x List to smash.
#' @param Name Name for column corresponding to each level.
#' @param max.depth Maximum number of recursive levels to flatten.
#' @return A \code{data.table} object.
#'
#' @importFrom data.table data.table
#' @importFrom data.table rbindlist
#' @export
smash <- function(x, col.names=NULL, max.depth=Inf) {
  out <- smash_internal(x, col.names, 1, max.depth)
  colnames(out) <- make.unique(colnames(out))
  return(out)
}

smash_internal <- function(x, col.names, depth, max.depth) {
  if(depth >= max.depth || any(sapply(x, class) != "list")) {
    return(data.table(rbind(x)))
  }

  out <- lapply(x, smash_internal, col.names[-1], depth+1, max.depth)
  row_counts <- sapply(out, nrow)

  out <- rbindlist(out, use.names=TRUE, fill=TRUE)

  if(!is.null(names(x))) {
    out <- data.table(rep(names(x), row_counts), out)

    if(!is.null(col.names)) {
      colnames(out)[1] <- col.names[1]
    } else {
      colnames(out)[1] <- paste0("V", depth)
    }
  }

  return(out)
}
