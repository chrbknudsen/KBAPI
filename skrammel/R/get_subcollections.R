#' Get subcollections
#'
#' FIXME
#'
#' @param live logical value indicating if list of authors should be retrieved live, or from internal data.
#'
#' @return None
#'
#' @examples
#' get_subcollections()
#'
#' @export

get_subcollections <- function(){
test <- jsonlite::read_json("https://api.kb.dk/data/rest/api/text?q=&rows=0&facet=on&facetfield=subcollection_ssi",
                            simplifyVector = F)
test <- test$facet_counts$facet_fields$subcollection_ssi
test <- test[seq(1, length(test), 2)]
  unlist(test)


# Med mindre ovenstående fejler - ellers returner:
#   c("adl", "gv",  "tfs", "sks")
}
