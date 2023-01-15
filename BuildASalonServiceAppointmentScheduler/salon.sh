#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n\n~~ Salon Appoinment Scheduler ~~\n\n"

MAIN_MENU() {
  PROMPT="\nWelcome to My Salon, how can I help you?\n\n1) cut\n2) color\n3) perm\n4) style\n5) trim"

  if [[ $1 ]]
  then 
    echo -e "\n$1"
  else
    echo -e $PROMPT
  fi
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    1|2|3|4|5)
      RENDER_SERVICE $SERVICE_ID_SELECTED;;
    *) MAIN_MENU "I could not find that service. What would you like today?\n1) cut\n2) color\n3) perm\n4) style\n5) trim"
  esac
}

function QUERY_INPUT() {
  local prompt=$1
  echo -e "\n$prompt"
  read QUERY_INPUT
  echo "$QUERY_INPUT"
}

RENDER_SERVICE() {
  SERVICE_ID_SELECTED=$1
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

  # get customer phone number
  CUSTOMER_PHONE=""
  PHONE_LEN=0
  
  while [[ -z $CUSTOMER_PHONE || $PHONE_LEN < 11 ]]
  do
    # QUERY_INPUT "What's your phone number [###-###-####]?"
    # CUSTOMER_PHONE=$QUERY_INPUT
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    PHONE_LEN=$(echo $CUSTOMER_PHONE | wc -c)
  done
  echo "Your phone is $CUSTOMER_PHONE"

  # get customer name from customer table
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  echo $CUSTOMER_NAME

  if [[ -z $CUSTOMER_NAME ]]
  then
    # record not found
    # QUERY_INPUT "I don't have a record for that phone number, what's your name?"
    # CUSTOMER_NAME=$QUERY_INPUT
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME

    while [[ -z $CUSTOMER_NAME ]]
    do
      # QUERY_INPUT "I don't have a record for that phone number, what's your name?"
      # CUSTOMER_NAME=$QUERY_INPUT
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
    done
  fi

  # save new customer
  SAVE_CUSTOMER=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")

  # get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  
  # set up appointment
  # QUERY_INPUT "What time would you like your cut, $CUSTOMER_NAME?"
  # SERVICE_TIME=$QUERY_INPUT
  echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
  read SERVICE_TIME
  while [[ -z $SERVICE_TIME ]]
  do
    # QUERY_INPUT "What time would you like your cut, $CUSTOMER_NAME?"
    # SERVICE_TIME=$QUERY_INPUT
    echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
    read SERVICE_TIME
  done
  
  # schedule an appointment
  SCHEDULE=$($PSQL "INSERT INTO appointments(time, customer_id, service_id) VALUES('$SERVICE_TIME', $CUSTOMER_ID, '$SERVICE_ID_SELECTED')")
  if [[ $? == 0 ]]; then
    echo -e "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}

MAIN_MENU