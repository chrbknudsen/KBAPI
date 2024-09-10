#' Get editions
#'
#' FIXME
#'
#' @param live logical value indicating if list of authors should be retrieved live, or from internal data.
#'
#' @return None
#'
#' @examples
#' get_editions()
#'
#' @export


get_editions <- function(){
  jsonlite::read_json("https://api.kb.dk/data/rest/api/editions",
                            simplifyVector = T)
}

