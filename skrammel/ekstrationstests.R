library(xml2) #https://stackoverflow.com/questions/19497652/reading-kml-files-into-r
# https://library.au.dk/fileadmin/www.nobel.bibliotek.au.dk/LibLab/files/r-markdown/1_interacting.html
library(httr2)
library(rvest)
library(jsonlite)
library(XML)
library(tidyverse)
test <- get_aerial(format = "kml")
xml_data <- test %>%
  resp_body_xml()
write_xml(xml_data, "data.xml")

# her trækker vi navne ud. og får en tibble med en enkelt node i hver række.
xml_data <- tibble(navn =xml_data %>%
                          xml_child(1) %>%
                          xml_children() %>%
                          xml_name(),
                   indhold = xml_data %>%
                             xml_child() %>%
                             xml_children() %>%
                             lapply(function(x) x))

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


xml_data <- xml_data %>%
  filter(navn == "Placemark")


xml_data %>%
  mutate(id = map_chr(indhold, ~ xml_attr(.x, "id")))

xml_data %>%
  mutate(id = map_chr(indhold, ~ xml_attr(.x, "id"))) %>%
  mutate(children = map(indhold, ~xml_children(.x))) %>%
  mutate(extended = map(children, ~xml_children(.x))) %>%
  slice(1) %>%
  pull(extended) %>% .[[1]]
%>%  xml_attr("ns:value")

  mutate(mere = map(extended, ~ tibble(name = xml_attr(.x, "name"),
                                       value = xml_attr(.x, "value"))))






  rowwise() %>%
  mutate(extended = map(children, ~xml_child(5)))

data.frame()


mutate(obj_nodeset = list(fyn_xml %>%
                            xml_find_all(paste0('//*[@id="', obj, '"]')))) %>%
  mutate(Extended_data_node = list(fyn_xml %>%
                                     xml_find_all(paste0('//*[@id="', obj, '"]')) %>%
                                     xml_child(5)))


xml_data %>%
  mutate(id = map_chr(indhold, ~ xml_attr(.x, "id"))) %>%
  mutate(
    # Udtræk child-noderne for hver Placemark
    children = map(indhold, ~ xml_children(.x)),

    # Konverter hver sæt af child-noder til en tibble
    children_tibble = map(children, ~ tibble(
      child_name = xml_name(.x),
      child_value = xml_text(.x)
    ))
  ) %>%
  slice(1) %>% pull(children_tibble)




slice(1) %>%
  pull(indhold) %>%
  .[[1]] %>%
  xml_child() %>%
  xml_attrs()








  xml_data %>%
    filter(navn == "Placemark")   %>%
    mutate(
      name = map_chr(indhold, ~ xml_text(xml_find_first(.x, ".//name"))),
      coordinates = map_chr(indhold, ~ xml_text(xml_find_first(.x, ".//coordinates")))
    )

xml_data %>%
  slice(1) %>%
  pull(indhold) %>%
  .[[1]] %>% xml_children()  %>% as.character()
xml_attrs()


%>% xml_children %>% .[[1]] %>%
  xml_attrs() %>% as.list()


%>% lapply(function(x) x) %>% .[[1]] %>%
  #.[[2]] %>%
  xml_attrs() %>% as.list() %>% as_tibble()




xml_children() %>%
    xml_child()  %>%
  as.character()




xml_data %>%
  xml_child(1) %>%
  xml_find_all()


list(xml_data %>%
       xml_find_all(paste0('//*[@id="', obj, '"]')))

xml_root(xml_data)

xml_child(xml_data, 1) %>%
  xml_child(8) %>%
  xml_child(5) %>%
  xml_children()

xml_data %>%
  xml_child(1) %>%
  xml_children() %>%
  xml_name()




xml_data %>%
  xml_find_all('//*[@id]') %>%
  xml_attr("id")


  xml_child() %>%
  xml_children() %>%
  xml_name()


noder <- test %>%
  resp_body_xml() %>%
  xml_child() %>%
  xml_find_all(".//d1:Placemark")



noder[[1]]


tibble(
  name = xml_name(noder),  # Få navnet på noden
  content = xml_text(noder),  # Få tekstindholdet
  attributes = map(noder, xml_attrs) )



xml2::xml_ns(test)
noget <- test %>%
  resp_body_xml()
# %>%
#   toJSON(pretty = TRUE, auto_unbox = TRUE) %>%
#   jsonlite::fromJSON()
# noget$kml$Document
noget %>% names()

test <- xml_children(noget)

XML::xmlToList(test)




test %>% xml_children()
xml_children <- xml_children(test)

tibble(
  node_name = xml_name(xml_children),
  attributes = map(xml_children, ~ as.list(xml_attrs(.x))),
  contents = map(xml_children, ~ xml_contents(.x))
  )  %>%
  XML::xmlToList()
  slice(10) %>%
  unnest(attributes) %>%
  slice(1) %>%
  pull(contents)  %>% .[[1]] %>% xml_name()
