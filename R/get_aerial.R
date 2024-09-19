#' Søg luftfotos
#'
#' En kort beskrivelse af hvad funktionen gør.
#'
#' @param lat Latitude
#' @param lon Longitude
#' @param format Outputformat. Either kml, rss, atom or mods
#' @return A tibble containing SVARET!
#' @examples
#' # Eksempel på brug af funktionen
#' get_aerial(lat = 1, lon = 2)
#' @export


get_aerial <- function(lat=56.007514636317666,
                       lon=12.228840190005485,
                       format = "kml"){
  # tjek input
  if(!is.numeric(lat)){
    rlang::abort("lat must be numeric", class = "invalid_input")
  }
  if(!is.numeric(lon)){
    rlang::abort("lon must be numeric", class = "invalid_input")
  }
  if(!(format %in% c("kml", "rss", "atom", "mods"))){
    rlang::abort("format must be one of 'kml', 'rss', 'atom' or 'mods'",
                 class = "invalid_input")
  }
  # warnings når lat/lon er uden for range: -90-90 for lat og -180-180 for long
  # Og der er en mere snæver grænse på de luftfotos vi har.
  # Det må også være muligt at angive en bounding box på en mere fix måde.
  # rlang::warn()
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
    itemsPerPage = 10
  )
  response <- httr2::request(api_url) |>
    httr2::req_url_query(!!!query_params) |>
    httr2::req_perform()
# Her bør der nok være noget tjek af om ting gik godt.
  response <- response %>%
    httr2::resp_body_xml()
  tibble::tibble(navn =response %>%
           xml2::xml_child(1) %>%
           xml2::xml_children() %>%
           xml2::xml_name(),
         indhold = response %>%
           xml2::xml_child() %>%
           xml2::xml_children() %>%
           lapply(function(x) x))

  }

