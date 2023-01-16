#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
###
# Rename the weight column to atomic_mass
###
# RENAME=$($PSQL "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;")

###
# Rename the melting_point column to melting_point_celsius and the boiling_point column to boiling_point_celsius
###
ALTERTABLE=$($PSQL "ALTER TABLE properties ALTER COLUMN boiling_point SET NOT NULL;")
ALTERTABLE=$($PSQL "ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;  ALTER TABLE properties ALTER COLUMN melting_point_celsius TYPE DECIMAL;")
ALTERTABLE=$($PSQL "ALTER TABLE properties ALTER COLUMN melting_point SET NOT NULL;")
ALTERTABLE=$($PSQL "ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;  ALTER TABLE properties ALTER COLUMN melting_point_celsius TYPE DECIMAL;")
echo $?

###
# symbol and name columns in elements table should have the NOT NULL constraint
###
CONSTRANTIT=$($PSQL "ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL; ALTER TABLE elements ALTER COLUMN name SET NOT NULL;")


##
# properties table should have a type_id foreign key column that references the type_id column from the types table. It should be an INT with the NOT NULL constraint
## ALTER TABLE orders ADD CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers (id);
ADDFKEY=$($PSQL "ALTER TABLE properties ADD COLUMN type_id INT REFERENCES types(type_id);")
UPDATEID=$($PSQL "UPDATE properties SET type_id=1 WHERE type='nonmetal'; UPDATE properties SET type_id=2 WHERE type='metal'; UPDATE properties SET type_id=3 WHERE type='metalloid' ")
SETNOTNULL=$($PSQL "ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;")
echo $?


###
# Capitalize the first letter of all the symbol values in the elements table. 
# Be careful to only capitalize the letter and not change any others
###
SYMBOLS=$($PSQL "SELECT INITCAP(symbol), atomic_number FROM elements;")
echo $?
# echo -e "$SYMBOLS"
echo "$SYMBOLS" | while read  SYM BAR A_NUMBER
do
  echo "*$SYM*  *$A_NUMBER*"
  UPDATE=$($PSQL "UPDATE elements SET symbol='$SYM' WHERE atomic_number = '$A_NUMBER'")
  echo $?
done

###
# Remove all the trailing zeros after the decimals from each row of the atomic_mass column. 
# You may need to adjust a data type to DECIMAL for this. The final values they 
# should be are in the atomic_mass.txt file   IFS="|"
###
ALTER_COL=$($PSQL "ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL;")

cat atomic_mass.txt | while read ANUMBER  BAR AMASS
do
  echo *$ANUMBER* *$AMASS*
  UPDATE_ATOMIC_MASS=$($PSQL "UPDATE properties SET atomic_mass=$AMASS WHERE atomic_number=$ANUMBER;")
  echo $?
done

###
# extra bit
###
UPDATE_ATOMIC_MASS=$($PSQL "UPDATE properties SET atomic_mass=1 WHERE atomic_number=1000;")

# Add the element with atomic number 9 to your database. 
# Its name is Fluorine, symbol is F, mass is 18.998, melting point is -220, 
# boiling point is -188.1, and it's a nonmetal
###
ADD_ELEMENT=$($PSQL "INSERT INTO elements VALUES(9,'F','Fluorine')")
ADD_NEW_ELEM=$($PSQL "INSERT INTO properties VALUES(9, 'nonmetal', 18.998, -220,-188.1,1)")


###
# Add the element with atomic number 10 to your database. Its name is Neon, 
# symbol is Ne, mass is 20.18, melting point is -248.6, boiling point is -246.1, 
# and it's a nonmetal
###
ADD_ELEMENT=$($PSQL "INSERT INTO elements VALUES(10,'Ne','Neon')")
ADD_NEW_ELEM=$($PSQL "INSERT INTO properties VALUES(10, 'nonmetal', 20.18, -248.6,-246.1,1)")

###
# delete the non existent element, whose atomic_number is 1000, from the two tables
###
DEL_ELEMENT=$($PSQL "DELETE FROM properties WHERE atomic_number=1000; DELETE FROM elements WHERE atomic_number=1000; ")