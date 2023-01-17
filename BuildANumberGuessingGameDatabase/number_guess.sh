#!/bin/bash
# Randomly Generate number between 1 and 1000

# echo -e "\n~~ Welcome to The Guessing Game  moohaha! ~~\n"

# global variables
DBNAME="number_guess"
PSQL="psql --username=freecodecamp --dbname=$DBNAME -t --no-align -c"
YOUR_GUESS=0
NEW_USER=0

READ_YOUR_GUESS() {
  read -p "$1 " val
  # check valid numeric input
  if [[ ! $val =~ ^[0-9]+$ ]]; then
    READ_YOUR_GUESS "That is not an integer, guess again:"
  else
    YOUR_GUESS=$val
  fi
}

# Guess the secret number between 1 and 1000:
PLAY_GAME() {
  local FOUND=1001
  local TIMES=1

  # global variable:
  YOUR_GUESS=0

  # generate a random number between 1 and 1000
  SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))

  # Prompt the user input
  READ_YOUR_GUESS "Guess the secret number between 1 and 1000:"

  # Repeat until FOUND==0  
  while [[ $FOUND -ne 0 ]]
  do
    if [[ $YOUR_GUESS -gt $SECRET_NUMBER ]]; then
      READ_YOUR_GUESS "It's lower than that, guess again:"
    elif [[ $YOUR_GUESS -lt $SECRET_NUMBER ]]; then
      READ_YOUR_GUESS "It's higher than that, guess again:"
    fi    
    FOUND=$(( $SECRET_NUMBER - $YOUR_GUESS ))
    (( TIMES++ ))
  done


  # Wrapping up result
  if [[ $FOUND -eq 0 ]]; then
    echo -e "\nYou guessed it in $TIMES tries. The secret number was $SECRET_NUMBER. Nice job!"

    if [[ $NEW_USER -eq 1 ]]; then
      ADDUSER=$($PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME', 1, $TIMES);")
    else
      # update database 
      USERID=$1
      STATS=$($PSQL "SELECT username, games_played, best_game FROM users WHERE user_id=$USERID;")
      echo $STATS | while IFS='|' read UNAME PLAYCOUNT BESTSCORE
      do
        (( PLAYCOUNT++ ))
        if (( $BESTSCORE > $TIMES )); then
          BESTSCORE=$TIMES
        fi
        UPDATEDB=$($PSQL "UPDATE users SET games_played=$PLAYCOUNT, best_game=$TIMES WHERE user_id=$USERID;")
      done
    fi
  fi
  exit 0;
}

MAIN_MENU() {
  if [[ $1 ]]; then
    read -p "$1" USERNAME
  else
    read -p "Enter your username: " USERNAME
  fi
  
  if [[ -z $USERNAME || ${#USERNAME} -gt 22 ]]; then
    MAIN_MENU "Enter your username: "
  else
    CHECKDBFORUNAME=$($PSQL "SELECT username, games_played, best_game FROM users WHERE username = '$USERNAME'")
    if [[ -z $CHECKDBFORUNAME ]]; then
      # new user, let's add
      NEW_USER=1
      echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
      # Let's play!
      PLAY_GAME $USERID
    else
      # welcome message
      echo $CHECKDBFORUNAME | while IFS='|' read UNAME GAMEPLAYED BESTGAME
      do
        echo -e "\nWelcome back, $UNAME! You have played $GAMEPLAYED games, and your best game took $BESTGAME guesses."
      done
      
      USERID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")

      # Let's go!
      PLAY_GAME $USERID
    fi
  fi
}

MAIN_MENU "Enter your username: "
