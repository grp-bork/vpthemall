#'  Wrap for testing varpart
#'
#' This function wrap perform varpart "manually", calculating dbRDA, anova and Rsquare. It takes a distance matrix and a data.frame containing variables data (metadata) and perform "manual" varpart. It requires vegan v 2.4-5. P-value and adjusted F are not produced for full formulas, i.e. formula without the Condition() function. This is specified in the element paramenter, element = "full". Otherwise, it assumes that the formula contains Condition(), and therefore P-value and adjusted F are produced. A list containing the model and statistics is produced.
#' First, a dbRDA model is built. ANOVA type III (by = "margin") is performed. Statistics and results are collected in a list.
#
#' @param dis distance matrix produced by vegan.
#' @param meta data.frame containing variables to be selected.
#' @param var.formula Character containing the part of the formula with the independent variables, i.e. that comes after "~", e.g. "A + B".
#' @param element String. If element = "full", P-value and F statistic is not produced. Default = "not.full".
#' @param perm.n Integer. Number of permutation to be performed in ANOVA.
#' @keywords varpart variation partition anova test multivariate
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
#' res <- test.varpart.wrap(dis = dis,
#' meta = meta,
#' var.formula = "Substrate + Condition(WatrCont + SubsDens)",
#' element = "unique",
#' perm.n = 999)

test.varpart.wrap <- function(dis, meta, var.formula, element, perm.n){
  # set defaults
  if(missing(element)){element = "not.full"}else{element = element}
  if(missing(perm.n)){perm.n = 999}else{perm.n = perm.n}

  # Make formula ----
  fml.ch <- paste( "dis ~", var.formula)
  fml <- as.formula(fml.ch)

  # Build dbRDA model -----

  m <- dbrda(fml, meta)

  # Perform ANOVA type III
  m.anova <- anova(m, by = "margin", permutations = perm.n)

  if(element == "full"){p.value <- NA
  f.value <- NA}else{
    p.value <- m.anova$`Pr(>F)`[1]
    f.value <-  m.anova$F[1]
  }

  # Get adjusted R squared
  r <- RsquareAdj(m)
  r.squared <- r$r.squared
  adj.r.squared <- r$adj.r.squared

  # Save results in a list
  multi.result <- list(m,
                       m.anova,
                       p.value,
                       f.value,
                       r.squared,
                       adj.r.squared,
                       fml.ch)
  names(multi.result) <- c("model",
                           "model.anova",
                           "p.value",
                           "f.value",
                           "r.squared",
                           "adj.r.squared",
                           "formula")
  return(multi.result)
}
