#!/bin/bash
# global variables
DBNAME="number_guess"
PSQL="psql --username=freecodecamp --dbname=$DBNAME -t --no-align -c"

MAIN_MENU() {
  new_user=0
  username=""
  FOUND=1001
  number_of_guesses=0

  while [[ -z $username || ${#username} -gt 22 ]]
  do
    echo -n "Enter your username: "
    read username
  done

  # generate a random number between 1 and 1000
  secret_number=$(( RANDOM % 1000 + 1 ))

  # check username against the database
  CHECKDBFORUNAME=$($PSQL "SELECT username, games_played, best_game FROM users WHERE username = '$username';")

  if [[ -z $CHECKDBFORUNAME ]]; then
    # new user, let's add
    new_user=1
    echo -e "Welcome, $username! It looks like this is your first time here."
  else
    # welcome message
    echo $CHECKDBFORUNAME | while IFS='|' read username games_played best_game
    do
      echo "Welcome back, ${username}! You have played $games_played games, and your best game took $best_game guesses."
    done
  fi

  # Let's play!
  local prompt_msg="Guess the secret number between 1 and 1000: "
  while [[ $FOUND -ne 0 ]]
  do
    echo -n "$prompt_msg"
    read your_guess
    # check valid numeric input
    if [[ ! $your_guess =~ ^[0-9]+$ ]]; then
      prompt_msg="That is not an integer, guess again: "
    else
      if (( $your_guess > $secret_number )); then
        prompt_msg="It's lower than that, guess again: "
      elif (( $your_guess < $secret_number )); then
        prompt_msg="It's higher than that, guess again: "
      fi    
      FOUND=$(( $secret_number - $your_guess ))
      (( number_of_guesses++ ))
    fi
  done

  # Result
  # if [[ $FOUND -eq 0 ]]
  # then
    echo -e "You guessed it in $number_of_guesses tries. The secret number was $secret_number. Nice job!"

    if [[ $new_user -eq 1 ]]
    then
      ADDUSER=$($PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$username', 1, $number_of_guesses);")
    else
      STATS=$($PSQL "SELECT games_played, best_game FROM users WHERE username='$username';")
      echo $STATS | while IFS='|' read games_played best_game
      do
        if (( $best_game > $number_of_guesses )); then
          best_game=$number_of_guesses
        fi
        UPDATEDB=$($PSQL "UPDATE users SET games_played=$games_played, best_game=$best_game WHERE username='$username';")
      done      
    fi
  # fi
}

MAIN_MENU