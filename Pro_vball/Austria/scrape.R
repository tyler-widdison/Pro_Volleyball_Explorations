#2019-2020 (ids = 6074-7076)
library(rvest)
ids <- 0:8076
urls <- paste0("http://ovv-web.dataproject.com/MatchStatistics.aspx?mID=",ids, "&ID=76&CID=220&PID=142&type=LegList")

#webscrape function
dfList <- lapply(urls, function(i) {
  webpage <- read_html(i)
  draft_table <- html_nodes(webpage, 'table')
  stats <- rbind(html_table(draft_table)[[7]], html_table(draft_table)[[8]])
  date <- html_nodes(webpage, xpath = "//*[@id='Content_Main_LB_DateTime']") %>% html_text()
  home_team <- html_nodes(webpage, xpath = "//*[@id='Content_Main_LBL_HomeTeam']") %>% html_text()
  guest_team <- html_nodes(webpage, xpath = "//*[@id='Content_Main_LBL_GuestTeam']") %>% html_text()
  score <- html_nodes(webpage, xpath = "//*[@id='Content_Main_LB_SetsPartials']") %>% html_text()
  venue <- html_nodes(webpage, xpath = "//*[@id='Content_Main_RPL_Master']/div[1]/div[1]/div[2]/p[2]") %>% html_text()
  refs <- html_nodes(webpage, xpath = "//*[@id='Content_Main_LB_Referees']") %>% html_text()
  league <- html_nodes(webpage, xpath = "//*[@id='LYR_CompetitionDescription']/h2") %>% html_text()
  home_coach <- html_nodes(webpage, xpath = "//*[@id='Content_Main_ctl16_RP_MatchStats_Coach_Home_0']") %>% html_text()
  guest_coach <- html_nodes(webpage, xpath = "//*[@id='Content_Main_ctl16_RP_MatchStats_Coach_Guest_0']") %>% html_text()
  test <- cbind(stats, date, home_team,home_coach, guest_team,guest_coach, score, veunue, refs, league)
})

df <- do.call(rbind, dfList)
