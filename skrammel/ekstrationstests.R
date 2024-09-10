library(xml2)
library(jsonlite)
library(tidyverse)
test <- get_aerial(format = "kml")
noget <- test %>%
  resp_body_xml()
# %>%
#   toJSON(pretty = TRUE, auto_unbox = TRUE) %>%
#   jsonlite::fromJSON()
# noget$kml$Document
noget %>% class()
noget$Document$Placemark


extract_all_nodes <- function(node) {
  # Find alle børn af noden
  children <- xml_children(node)

  # Hvis noden har børn, anvend funktionen rekursivt på hvert barn
  if (length(children) > 0) {
    # For hver child node, rekursivt udtræk data
    return(map(children, extract_all_nodes))
  } else {
    # Hvis noden ikke har børn, returner nodens navn og værdi
    return(set_names(xml_text(node), xml_name(node)))
  }
}

# Funktion til at flade listen og håndtere noder med flere lag
flatten_xml_data <- function(xml_list) {
  # Hvis det er en liste med lister, flad dem ud
  if (is.list(xml_list) && !is.null(names(xml_list))) {
    return(map(xml_list, flatten_xml_data))
  } else if (is.list(xml_list)) {
    return(unlist(xml_list))
  } else {
    return(xml_list)
  }
}

extracted_data <- extract_all_nodes(noget)

# Flad dataene ud og konverter til tibble
flattened_data <- map_dfr(extracted_data, flatten_xml_data)

# Konverter det fladede data til en tibble
kml_tibble <- as_tibble(flattened_data)
kml_tibble %>%
  select(-text,
         -startIndex,
         -Query)
