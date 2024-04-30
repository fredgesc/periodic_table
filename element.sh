if [[ $1 ]]
then
  PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
  ELEMENT_RESULT=$($PSQL "select e.atomic_number, e.symbol, e.name, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius from elements e inner join properties p using(atomic_number) inner join types t using(type_id) where cast(e.atomic_number as varchar(10)) = '$1' or e.symbol = '$1' or e.name = '$1'")
  
  if [[ -z $ELEMENT_RESULT ]]
  then 
    echo "I could not find that element in the database."
  else
    IFS='|' read -r ATOMIC_NUMBER SYMBOL NAME TYPE MASS MPC BPC <<< $ELEMENT_RESULT
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MPC celsius and a boiling point of $BPC celsius."
  fi
else
  echo "Please provide an element as an argument."
fi