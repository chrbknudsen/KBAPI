hent_have_data <- function(){
  url <- "http://www5.kb.dk/images/billed/2010/okt/billeder/subject37894/da/?page="
  data <- httr::GET(paste0(url,1), add_headers(Accept = "application/json")) %>%
    content(type = "text", encoding = "UTF-8") %>%
    fromJSON()
  data <- data$response
  sider <- data$pages$total_pages
  res <- list()
  res[[1]] <- data$docs %>% as.data.frame()
  for(i in 2:sider){
    res[[i]] <- httr::GET(paste0(url,i), add_headers(Accept = "application/json")) %>%
      content(type = "text", encoding = "UTF-8") %>% fromJSON() %>%
      .$response %>%
      .$docs %>%
      as.data.frame()
  }
  bind_rows(res)
}
