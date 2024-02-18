#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo 'Please provide an element as an argument.'
# if atomic number is passed
elif [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEM=$1
    ELEM_ID=$($PSQL "select name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from properties inner join elements using(atomic_number) full join types using(type_id) where atomic_number = $ELEM;")
    if [[ -z $ELEM_ID ]]
    then 
    # if argument is not right
    echo "I could not find that element in the database."
    else
    echo -e "$ELEM_ID" | sed 's/|/ | /g' | while read NAME BAR SYMBOL BAR TYPE BAR ATOMIC_M BAR MELTING BAR BOILING
      do
      echo "The element with atomic number $ELEM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_M amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
# if symbol is passed
elif [[ $1 =~ ^[A-Z]$ ]] || [[ $1 =~ ^[A-Z][a-z]$ ]]
  then
    SYMB=$1
    ELEM_SY=$($PSQL "select name, atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius from properties inner join elements using(atomic_number) full join types using(type_id) where symbol = '$SYMB' ;")
    if [[ -z $ELEM_SY ]]
    then 
    # if argument is not right
    echo "I could not find that element in the database"
    else
      echo -e "$ELEM_SY" | sed 's/|/ | /g' | while read NAME BAR ATOMIC_N BAR TYPE BAR ATOMIC_M BAR MELTING BAR BOILING
        do
        echo "The element with atomic number $ATOMIC_N is $NAME ($SYMB). It's a $TYPE, with a mass of $ATOMIC_M amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
        done
    fi
# if name is passed
elif [[ $1 =~ ^[A-Za-z]+$ ]]
  then
    NAM=$1
    ELEM_NA=$($PSQL "select symbol, atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius from properties inner join elements using(atomic_number) full join types using(type_id)  where name = '$NAM' ;")
    if [[ -z $ELEM_NA ]]
    then 
    # if argument is not right
    echo "I could not find that element in the database."
    else
      echo -e "$ELEM_NA" | sed 's/|/ | /g' | while read SYMBOL BAR ATOMIC_N BAR TYPE BAR ATOMIC_M BAR MELTING BAR BOILING
        do
        echo "The element with atomic number $ATOMIC_N is $NAM ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_M amu. $NAM has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
        done
    fi
fi
