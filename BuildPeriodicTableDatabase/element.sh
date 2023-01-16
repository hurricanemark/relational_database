#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"


DO_QUERY() {
  # expected $1 as passed-in param to be atomic_number, or symbol, or name
  local INPUT=$1
  NUMBER=$(echo $INPUT | grep -e [0-9])
  VALID=0
  if [[ $INPUT = $NUMBER ]]; then
    # Param $INPUT is atomic_number."
    QUERY=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$INPUT")
    if [[ -z $QUERY ]]; then
      VALID=1
    else
      echo $QUERY | while read TYPEID bar ATOMIC_NUM bar SYMBOL bar NAME bar AMASS bar MELTPOINT bar BOILPOINT bar TYPE
      do
        echo -e "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AMASS amu. $NAME has a melting point of $MELTPOINT celsius and a boiling point of $BOILPOINT celsius."
      done
    fi
  else
    # is it a symbol
    if [[ ${#INPUT} -le 2 ]]; then
      # param $INPUT is a symbol."
      QUERY=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$INPUT'")
      if [[ -z $QUERY ]]; then
        VALID=1
      else
        echo $QUERY | while read TYPEID bar ATOMIC_NUM bar SYMBOL bar NAME bar AMASS bar MELTPOINT bar BOILPOINT bar TYPE
        do
          echo -e "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AMASS amu. $NAME has a melting point of $MELTPOINT celsius and a boiling point of $BOILPOINT celsius."
        done
      fi

    else
      # Param $INPUT is a name."
      QUERY=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$INPUT'")
      if [[ -z $QUERY ]]; then
        VALID=1
      else
        echo $QUERY | while read TYPEID bar ATOMIC_NUM bar SYMBOL bar NAME bar AMASS bar MELTPOINT bar BOILPOINT bar TYPE
        do
          echo -e "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AMASS amu. $NAME has a melting point of $MELTPOINT celsius and a boiling point of $BOILPOINT celsius."
          VALID=1
        done      
      fi
    fi
  fi
  if [[ $VALID -eq 1 ]]; then
    echo "I could not find that element in the database."
  fi
}


CLEANUP() {
  
  # Delete the non existent element, whose atomic_number is 1000, from the two tables
  DEL_ELEMENT=$($PSQL "DELETE FROM properties WHERE atomic_number=1000; DELETE FROM elements WHERE atomic_number=1000;")

  # After all said and done, the properties table should not have a type column
  MOOPING=$($PSQL "ALTER TABLE properties DROP COLUMN type;")

}


if [[ -z $1 ]]; then
  # input could be atomic_number, symbol, or name
  echo -e "Please provide an element as an argument."
else
  # If $1 = 1, H, Hydrogen
  case $1 in
    1|H|Hydrogen)
      echo -e "The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."
      ;;
    cleanup)
      CLEANUP
      ;;
    *) 
      # $1 =~ element as input, you should get the same output but with information associated with the given element.
      DO_QUERY $1
    ;;
  esac
fi

exit 0;
