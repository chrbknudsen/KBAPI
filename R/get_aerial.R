#' Søg luftfotos
#'
#' En kort beskrivelse af hvad funktionen gør.
#'
#' @param lat Beskrivelse af første parameter.
#' @param lon Beskrivelse af anden parameter.
#' @param format formatet output kommer i. vælg mellem kml, rss, atom og mods
#' @return Beskrivelse af returværdien.
#' @examples
#' # Eksempel på brug af funktionen
#' get_aerial(lat = 1, lon = 2)
#' @export


get_aerial <- function(lat=56.007514636317666, lon=12.228840190005485, format = "kml"){
  # tjek input
  api_url <- "http://www.kb.dk/cop/syndication/images/luftfo/2011/maj/luftfoto/subject203/"
  formatted_lat <- sprintf("%.16f", lat)
  formatted_lon <- sprintf("%.16f", lon)
  query_params <- list(
    bbo = "10.395490670074423,55.22227193719089,10.296785378326376,55.18994697228769",
    zoom = 14,
    lat = formatted_lat,
    lng = formatted_lon,
    page = 1,
    q_fritekst = "",
    q_stednavn = "",
    q_bygningsnavn = "",
    q_person = "",
    q_adresse = "",
    notBefore = "1920",
    notAfter = "1970",
    category = "subject203",
    itemType = "all",
    thumbnailSize = "",
    format = format,
    itemsPerPage = 3
  )
  response <- httr2::request(api_url) |>
    httr2::req_url_query(!!!query_params) |>
    httr2::req_perform()
# Her bør der nok være noget tjek af om ting gik godt.
  response
}

