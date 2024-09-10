# Installer httr2, hvis det ikke allerede er installeret
# install.packages("httr2")

# Load httr2 pakken
library(httr2)

# Definer API-endpointet
api_url <- "http://www.kb.dk/cop/syndication/images/luftfo/2011/maj/luftfoto/subject203/"

# Opret en query string med parametrene
query_params <- list(
  bbo = "10.395490670074423,55.22227193719089,10.296785378326376,55.18994697228769",
  zoom = 14,
  lat = 55.20611273543719,
  lng = 10.346138024200382,
  page = 1,
  q_fritekst = "",
  q_stednavn = "",
  q_bygningsnavn = "",
  q_person = "",
  q_adresse = "",
  notBefore = 1920,
  notAfter = 1970,
  category = "subject203",
  itemType = "all",
  thumbnailSize = "",
  format = "xml"
)

# Send GET-anmodningen med parametre som query string
response <- request(api_url) %>%
  req_url_query(!!!query_params) %>%
  req_perform()

response

