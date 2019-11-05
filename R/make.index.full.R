#' Make index of full formula
#'
#' This function takes a vector of variables and returns an index.to.test data.frame containing the full var.formula. var.formula is the part of the formula with the independent variables, i.e. that comes after "~", e.g. "A + B".
#' @param var.vec vector of variables to include in the index.to.test data.frame
#' @keywords index.to.test variables formula full.
#' @export
#' @examples
#' # Load library
#' library(vegan)
#' data(mite)
#' data(mite.env)
#' abu <- mite
#' meta <- mite.env
#' var.vec <- colnames(mite.env)
#' index.to.test <- make.index.full(var.vec)

make.index.full <- function(var.vec){
    # Get variables
    var.formula <- paste(var.vec, collapse = " + ")
    # Add main index.to.test data
    index.to.test <- data.frame(var = "full",
                                element = "full",
                                var.formula = var.formula,
                                stringsAsFactors = F)
    return(index.to.test)
}
