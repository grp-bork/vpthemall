#' Select minimal model
#'
#' This function takes a distance matrix and a matrix containing variables data (metadata) and perform ordistep variable selection. It requires vegan and stringr.
#' @param dis distance matrix produced by vegan.
#' @param meta data.frame containing variables to be selected by ordistep.
#' @param direction direction to be used in ordistep. Default = "both".
#' @keywords select model
#' @export
#' @examples
#' # Load library
#' library(vegan)
#' data(mite)
#' data(mite.env)
#' abu <- mite
#' meta <- mite.env
#' abu.std <- decostand(abu, "hellinger")
#' dis <- vegdist(abu.std)
#' #Select minimal model
#' selected.model <- select.minimal.model(dis, meta)

select.minimal.model <- function(dis, meta, direction){
  require(vegan)
  require(stringr)

  #set defaults
  if(missing(direction)){direction = "both"}else{direction = direction}

  # isolate var.vec
  var.vec <- colnames(meta)
  # Build null model
  m0 <- dbrda( dis ~ 1, meta)

  # Build full model
  var.formula <- paste(var.vec, collapse = " + ")
  m1.formula <- formula(paste( "dis ~ ", var.formula, sep =""))
  m1 <- dbrda(m1.formula, meta)

  #Perform selection
  sel.m <- ordistep(m0, scope = formula(m1), direction = direction, trace = T)

  # Save outputs
  sel.m.variables <- as.character(formula(sel.m))[3]
  sel.m.variables <- str_split(sel.m.variables, " \\+ ")[[1]]

  selected.model <- list(sel.m, sel.m.variables)
  names(selected.model) <- c("sel.m", "sel.m.variables")
  return(selected.model)
}


