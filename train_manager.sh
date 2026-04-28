#!/bin/bash

FILE="trains.txt"

# Create file if not exists
touch $FILE

while true
do
    echo "-----------------------------------"
    echo " Train Record Management System"
    echo "-----------------------------------"
    echo "1. Add Train Record"
    echo "2. View All Records"
    echo "3. Search Train"
    echo "4. Update Train"
    echo "5. Delete Train"
    echo "6. Exit"
    echo "-----------------------------------"

    read -p "Enter your choice: " choice

    case $choice in

    1)
        read -p "Enter Train Number: " tno
        read -p "Enter Train Name: " tname

        if grep -q "^$tno," $FILE; then
            echo "Train already exists!"
        else
            echo "$tno,$tname" >> $FILE
            echo "Record added successfully."
        fi
        ;;

    2)
        echo "------ Train Records ------"
        if [ -s $FILE ]; then
            cat $FILE
        else
            echo "No records found."
        fi
        ;;

    3)
        read -p "Enter Train Number to search: " tno
        if grep -q "^$tno," $FILE; then
            grep "^$tno," $FILE
        else
            echo "Train not found."
        fi
        ;;

    4)
        read -p "Enter Train Number to update: " tno

        if grep -q "^$tno," $FILE; then
            read -p "Enter new Train Name: " newname
            sed -i "s/^$tno,.*/$tno,$newname/" $FILE
            echo "Record updated successfully."
        else
            echo "Train not found."
        fi
        ;;

    5)
        read -p "Enter Train Number to delete: " tno

        if grep -q "^$tno," $FILE; then
            sed -i "/^$tno,/d" $FILE
            echo "Record deleted successfully."
        else
            echo "Train not found."
        fi
        ;;

    6)
        echo "Exiting..."
        exit 0
        ;;

    *)
        echo "Invalid choice! Try again."
        ;;

    esac

done
