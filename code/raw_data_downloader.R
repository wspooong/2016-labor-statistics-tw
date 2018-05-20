library(dplyr)
library(rebus)
library(rvest)

main <- read_html("https://www.mol.gov.tw/statistics/2452/2455/")


for (i in 1:16) {
  
  sub_title <-
    main %>% html_nodes(sprintf("#ac-%s+ label", i)) %>% html_text %>% paste(formatC(i, flag = 0, width = 2), ., sep = "-")
  
  dir.create(sub_title, showWarnings = F)
  
  sub_text <-
    main %>% html_nodes(sprintf("#ac-%s~ article a", i)) %>% html_text %>% paste(formatC(1:length(.), flag = 0, width = 2), ., sep = "-")
  sub_link <-
    main %>% html_nodes(sprintf("#ac-%s~ article a", i)) %>% html_attr("href") %>% gsub(".htm" %R% END, ".csv", .)
  
  
  for (x in 1:length(sub_text)) {

    download.file(sub_link[x], paste0(sub_title, "/", sub_text[x], ".csv"))
    
  }
  
}
