#' Get sub collections
#'
#' returns sub collections from text collections
#'
#' @return A character vector containing current list of sub collections
#' @examples
#' # Eksempel på brug af funktionen
#' get_subcollections()
#' @export
#'
#'

get_subcollections <- function(){
  base_url <- "https://api.kb.dk/data/rest/api/text?q=&rows=0&facet=on&facetfield=subcollection_ssi"

  tryCatch({
    # Perform request and handle errors
    response <- httr2::request(base_url) %>%
      httr2::req_perform()

    # Check for valid response from server
    if (httr2::resp_status(response) != 200) {
      message(paste(
        "Request failed with status:", httr2::resp_status(response),
        "\nReturning default subcollctions."
      ))
      return(c("adl", "lh", "gv", "sks", "tfs", "letters","jura"))
    }

    # Parse JSON and extract sub_collections
    res <- response |>
      httr2::resp_body_json()
    res <- res$facet_counts$facet_fields$subcollection_ssi
    # remove number of objects
    res <- res[seq(1, length(res), 2)] |> unlist()
    return(res)

  }, error = function(e) {
    # Handle general errors
    warning("An error occurred, returning default sub collections: ", e$message)
    return(c("adl", "lh", "gv", "sks", "tfs", "letters","jura"))
  })
}


