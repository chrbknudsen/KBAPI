#' Get categories
#'
#' FIXME
#'
#' @param live logical value indicating if list of authors should be retrieved live, or from internal data.
#'
#' @return None
#'
#' @examples
#' get_categories()
#'
#' @export

get_categories <- function(){
  base_url <- "https://api.kb.dk/data/text"

  test <- rvest::read_html(base_url)

  res <- test |>
    rvest::html_element("#cat_ssi") %>%
    rvest::html_elements("option") %>%
    rvest::html_attrs() %>%
    unlist()
  unname(res[nchar(res)>0])
}

# den kan nok også med fordel have en "non-live" option
# og så kommer den ud som en named character vector.
# det skal der nok gøres noget ved.

