import requests
from bs4 import BeautifulSoup
import pandas as pd

player = []
match_date = []
match_teams = []

for page in range(0,4000):
    try:
        url = 'http://www.volleyservice.ru/index.php?option=com_volleyplayers&task=statistic&act=stat_game&game_id={}'.format(page)
        res = requests.get(url)
        soup = BeautifulSoup(res.text, 'html.parser')  
        teams = soup.find('td', {'class': 'game_info'}).find_all('div')[0].text
        date = soup.find('td', {'class': 'game_info'}).find_all('div')[3].text
        for ply in soup.find_all('tr', {'class':'player0'}):
            playe = ply.text.split('\n')
            player.append(playe)
            match_date.append(date)
            match_teams.append(teams)
        for ply in soup.find_all('tr', {'class':'player1'}):
            playe = ply.text.split('\n')
            player.append(playe)
            match_date.append(date)
            match_teams.append(teams)
    except:
        print(url)

player_df = pd.DataFrame(player)
team = {'match_date':match_date, 'match_teams':match_teams}
team_df = pd.DataFrame(team)
df = pd.concat([player_df, team_df], axis = 1)
df.to_csv('russian_men.csv')
