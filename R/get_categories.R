#' Categories in text collections
#'
#' returnerer kategorier fra text collections
#'
#' @return A character vector containing current categories
#' @examples
#' # Eksempel på brug af funktionen
#' get_categories()
#' @export
#'
#'

get_categories <- function(){
  base_url <- "https://api.kb.dk/data/text"

  tryCatch({
    # Perform request and handle errors
    response <- httr2::request(base_url) %>%
      httr2::req_perform()

    # Check for valid response from server
    if (httr2::resp_status(response) != 200) {
      message(paste(
        "Request failed with status:", httr2::resp_status(response),
        "\nReturning default categories."
      ))
      return(c("editorial", "work", "volume", "leaf"))
    }

    # Parse HTML body and extract categories
    res <- response |>
      httr2::resp_body_html() |>
      rvest::html_element("#cat_ssi") |>
      rvest::html_elements("option") |>
      rvest::html_attrs() |>
      unlist() |>
      unname()

    # Return non-empty strings
    return(res[nchar(res) > 0])

  }, error = function(e) {
    # Handle general errors
    warning("An error occurred, returning default categories: ", e$message)
    return(c("editorial", "work", "volume", "leaf"))
  })
}
