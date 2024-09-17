library(xml2) #https://stackoverflow.com/questions/19497652/reading-kml-files-into-r
# https://library.au.dk/fileadmin/www.nobel.bibliotek.au.dk/LibLab/files/r-markdown/1_interacting.html
library(httr2)
library(rvest)
library(jsonlite)
library(XML)
library(tidyverse)

# Henter data
test <- get_aerial(format = "kml")
# det får vi retur som en tibble.
test

# vi laver lige en kopi vi kan arbejde videre på.
xml_data <- test


# funktion til at ekstrahere placemarkdata.
extraher <- function(xml_data){

  navne <- xml_data %>%
    xml_children() %>% xml_name()

  indhold <- xml_data %>%
    xml_children() %>%
    lapply(function(x) x)
  tibble(navn = navne,
         indhold = indhold)
}

# vi ser lige at den virker.
xml_data %>%
  filter(navn == "Placemark") %>%
  mutate(ting = map(indhold, extraher))



startIndex <- xml_data %>% filter(navn == "startIndex") %>%
  pull(indhold) %>% .[[1]] %>%
  xml_text()

itemsPerPage <- xml_data%>% filter(navn == "itemsPerPage") %>%
  pull(indhold) %>% .[[1]] %>%
  xml_text()

totalResults <- xml_data%>% filter(navn == "totalResults") %>%
  pull(indhold) %>% .[[1]] %>%
  xml_text()


link1 <- xml_data %>% filter(navn == "link") %>%
  slice(1) %>%
  pull(indhold) %>% .[[1]] %>% xml_attrs()  %>% as.list() %>% as_tibble()


link2 <- xml_data %>% filter(navn == "link") %>%
  slice(2) %>%
  pull(indhold) %>% .[[1]] %>% xml_attrs()  %>% as.list() %>% as_tibble()




