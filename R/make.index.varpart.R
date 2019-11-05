#' Make index for unique and shared explained variations in the variation partition
#'
#' This function takes a variable (var) and the vector of variables (var.vec), which must contain the variable given (var). The function returns index.to.test data.frame containing the formulas for calculating unique and shared on a dbRDA model.
#' @param var variable to be tested.
#' @param var.vec vector of variables which contain variable var.
#' @keywords index.to.test variables unique shared formula.
#' @export
#' @examples
#' # Load library
#' library(vegan)
#' data(mite)
#' data(mite.env)
#' abu <- mite
#' meta <- mite.env
#' var.vec <- colnames(mite.env)
#' index.to.test <- NULL
#' for (var in var.vec){
#'   index.to.test <- rbind(index.to.test,
#'                             make.index.varpart(var, var.vec))
#' }

make.index.varpart <- function(var, var.vec){

  # Get other variables in the vector
  all.others <- var.vec[var.vec != var]

  #get formulas for X1 | X2 and X1  (a and ab) - unique
  var.formula.controlled <- paste0(var,
                 " + ",
                 "Condition(",
                 paste(all.others, collapse = " + "),
                 ")")
  # Get formula for the variable itself - shared
  var.formula <- var

  # Add controlled to data.frame
  index.var.controlled <- data.frame(var = var,
                          element = "unique",
                          var.formula = var.formula.controlled,
                          stringsAsFactors = F)

  # Add variable to data.frame
  index.var <- data.frame(var = var,
                          element = "shared",
                          var.formula = var.formula,
                          stringsAsFactors = F)

  # combine into index.to.test
  index.to.test <- rbind(index.var.controlled,
                         index.var)
  return(index.to.test)
}
