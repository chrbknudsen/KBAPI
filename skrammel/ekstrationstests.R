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





xml_data <- xml_data %>%
  mutate(startIndex = (xml_data %>% filter(navn == "startIndex") %>% pull(indhold) %>% .[[1]] %>% xml_text()),
                    itemsPerPage = (xml_data %>% filter(navn == "itemsPerPage") %>% pull(indhold) %>% .[[1]] %>% xml_text()),
                    totalResults = (xml_data %>% filter(navn == "totalResults") %>% pull(indhold) %>% .[[1]] %>% xml_text())
) %>%
  filter(navn == "Placemark") %>%
  mutate(placemark = map(indhold, function(x) tibble(navn = x %>% xml_children() %>% xml_name(),
                                                     indhold = x %>% xml_children() %>% lapply(function(x) x))))  %>%
  select(-c(navn, indhold))

xml_data <- xml_data %>% mutate(ID = 1:n()) %>% unnest(placemark) %>%

  pivot_wider(names_from = navn, values_from = indhold) %>%
  mutate(across(name:Point,  ~map(.x, html_text))) %>%
  mutate(across(name:Point,  unlist))


xml_data %>%
  mutate(ting = map(ExtendedData, extraher)) %>%
 slice(1) %>%
  pull(ting) %>%
  .[[1]] %>%
  slice(1) %>%
  pull(indhold)



# funktion til at ekstrahere placemarkdata.
extraher <- function(xml_data){

  navne <- xml_data %>%
    xml_child() %>%
    xml_children() %>% xml_name()

  indhold <- xml_data %>%
    xml_children() %>%
    lapply(function(x) x)
  tibble(navn = navne,
         indhold = indhold)
}
