#' Get genres
#'
#' FIXME
#'
#' @param live logical value indicating if list of authors should be retrieved live, or from internal data.
#'
#' @return None
#'
#' @examples
#' get_genres()
#'
#' @export



get_genres <- function(){
  base_url <- "https://api.kb.dk/data/text"

  test <- rvest::read_html(base_url)

  res <- test |>
    rvest::html_element("#genre_ssi") |>
    rvest::html_elements("option") |>
    rvest::html_attrs() |>
    unlist()
  unname(res[nchar(res)>0])
}
