#! /bin/bash
# Database name: worldcup
# Tables: games, teams

# This script import data from file named games.csv into database worldcup
#

echo -e "\n~~ Importing Data into database 'worldcup' ~~\n"

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi
# Do not change code above this line. Use the PSQL variable above to query your database.

# Check connection return code, expect 0
# echo $?

# Empty out the tables before imporint data
echo $($PSQL "TRUNCATE games, teams")

# let TEAM_ID=0
# let GAME_ID=0
let WINNER_ID=0
let OPPONENT_ID=0

# Reading the csv file using IFS as delimeter.
# NOTE.  The last line of the csv file must end with carriage return!  Else, it will be missed.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS 
do
  echo -e "$YEAR  \t$ROUND  \t$WINNER \t$OPPONENT \t$WINNER_GOALS \t$OPPONENT_GOALS"
  if [[ $YEAR != year ]]
  then
    INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER') ON CONFLICT DO NOTHING")
    if [[ $INSERT_TEAM != "INSERT 0 1" ]]; then
      echo "ERROR! Failed to insert $WINNER into teams table"
    fi
    INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT') ON CONFLICT DO NOTHING")
    if [[ $INSERT_TEAM != "INSERT 0 1" ]]; then
      echo "ERROR! Failed to insert $OPPONENT into teams table"
    fi

    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")

    INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_goals, opponent_goals, winner_id, opponent_id) VALUES( $YEAR, '$ROUND', $WINNER_GOALS, $OPPONENT_GOALS, $WINNER_ID, $OPPONENT_ID) ON CONFLICT DO NOTHING")
    if [[ $INSERT_GAME != "INSERT 0 1" ]]; then
      echo "ERROR! Failed to insert $ROUND into games table"
    fi

  fi
done
