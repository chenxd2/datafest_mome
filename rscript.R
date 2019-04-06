library(dplyr)
library(ggplot2)


wellness_data <- read.csv("DataFestFiles/data/wellness.csv", stringsAsFactors = FALSE)
rpe_data <- read.csv("DataFestFiles/data/rpe.csv", stringsAsFactors = FALSE)
games_data <- read.csv("DataFestFiles/data/games.csv", stringsAsFactors = FALSE)

#8860

# rpe_sd <- rpe_data %>%
#               filter(!is.na(RPE)) %>%
#               mutate(RPE = RPE-mean(RPE))

rpe_mean <- rpe_data %>%
            select(PlayerID, RPE) %>%
            filter(!is.na(RPE)) %>%
            group_by(PlayerID) %>%
            summarise(mean=mean(RPE))

rpe_sd <- rpe_data %>%
    select(PlayerID, RPE, Duration) %>%
    filter(!is.na(RPE)) %>%
    full_join(rpe_mean) %>%
    mutate(StandardizeRPE=RPE-mean, StandardizeSessionLoad=StandardizeRPE*Duration)
    
  

merged_data <- full_join(wellness_data,rpe_data)

# game_data <- merged_data %>% 
#               filter(SessionType == "Game" & !is.na(BestOutOfMyself)) 
#               #%>% 
#               #mutate(BestOutOfMyself = case_when(BestOutOfMyself=="Absolutely" ~ 3, BestOutOfMyself=="Somewhat" ~ 2, BestOutOfMyself=="Not at all" ~ 1))
# 
# t1<- table(game_data$Fatigue, game_data$BestOutOfMyself)
# table(game_data$Soreness, game_data$BestOutOfMyself)
# table(game_data$Desire, game_data$BestOutOfMyself)
# table(game_data$Irritability, game_data$BestOutOfMyself)
# table(game_data$SleepQuality, game_data$BestOutOfMyself)
# table(game_data$MonitoringScore, game_data$BestOutOfMyself)

