#' Get authors
#'
#' Retrieves a list of available authors in Text Collections
#'
#' @param live logical value indicating if list of authors should be retrieved live, or from internal data.
#'
#' @return None
#'
#' @examples
#' get_authors()
#'
#' @export

get_authors <- function(){
        test <- jsonlite::read_json("https://api.kb.dk/data/rest/api/text?q=cat_ssi:author+AND+type_ssi:work&wt=json&start=0&rows=75&defType=edismax",
                            simplifyVector = T)
        test$response$docs$inverted_name_title_ssi
}

# det er ikke givet at det er den format der skal bruges til at søge.
# Så her er nogle alternativer
# test$response$docs[[2]]$work_title_tesim
# test$response$docs[[2]]$sort_title_ssi
# test$response$docs[[2]]$inverted_name_title_ssi



# Nedenstående skal placeres i et internt datasæt, og hentes som alternativ
# til at trække data fra apien. (for det tager tid!)
fall_back <- c("Palladius, Peder"                 ,
"Paludan-Müller, Frederik",
"Ploug, Carl",
"Møller, Poul Martin",
"Richardt, Christian",
"Saxo",
"Schack, Hans Egede",
"Schandorph, Sophus",
"Sibbern, Frederik Christian",
"Skjoldborg, Johan",
 "Skram, Erik",
 "Michaëlis, Sophus",
 "Staffeldt, Schack",
 "Steffens, Henrich",
 "Sthen, Hans Christensen",
 "Stub, Ambrosius",
 "Stuckenberg, Viggo",
 "Thomissøn, Hans",
 "Topsøe, Vilhelm",
 "Wessel, Johan Herman",
 "Wied, Gustav",
 "Winther, Christian",
 "Worm, Jacob",
 "Aakjær, Jeppe",
 "Aarestrup, Emil",
 "Ravnkilde, Adda",
 "Arrebo, Anders",
 "Bagger, Carl",
 "Baggesen, Jens",
 "Bang, Herman",
 "Bergsøe, Vilhelm",
 "Blicher, Steen Steensen",
 "Bødtcher, Ludvig",
 "Bording, Anders",
 "Brahe, Tycho",
 "Brandes, Georg",
 "Brorson, Hans Adolph",
 "Chievitz, Poul",
 "Claussen, Sophus",
 "Dalgas, Ernesto",
 "Drachmann, Holger",
 "Brandes, Edvard",
 "Ewald, Johannes",
 "Falster, Christian",
 "Fibiger, Mathilde",
 "Heiberg, Johanne Luise",
 "Gjellerup, Karl",
 "Goldschmidt, M. A.",
 "Grundtvig, N. F. S.",
 "Gyllembourg, Thomasine",
 "Hauch, Carsten",
 "Andersen, Hans Christian",
 "Helie, Paulus",
 "Hertz, Henrik",
 "Hjortø, Knud",
 "Holberg, Ludvig",
 "Hostrup, Jens Christian",
 "Rode, Helge",
 "Ingemann, B. S.",
 "Knudsen, Jakob",
 "Jacobsen, Jørgen-Frantz",
 "Heiberg, Johan Ludvig",
 "Jacobsen, J. P.",
 "Juel-Hansen, Erna",
 "Kidde, Harald Henrik Sager",
 "Kierkegaard, Søren",
 "Kingo, Thomas",
 "Kaalund, Hans Vilhelm",
 "Larsen, Thøger",
 "Larsen, Karl",
 "Leonora Christina",
 "Lyschander, Claus Christoffersen",
 "Nansen, Peter",
 "Oehlenschläger, Adam",
 "Heiberg, Peter Andreas")
