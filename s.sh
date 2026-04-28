#!/bin/bash

FILE="students.txt"

# Create file if it doesn't exist
touch $FILE

while true
do
    echo "-----------------------------------"
    echo " Student Record Management System"
    echo "-----------------------------------"
    echo "1. Add Record"
    echo "2. View All Records"
    echo "3. Search Record"
    echo "4. Update Record"
    echo "5. Delete Record"
    echo "6. Exit"
    echo "-----------------------------------"
    read -p "Enter your choice: " choice

    case $choice in

    1)
        read -p "Enter Roll Number: " roll
        read -p "Enter Name: " name

        if grep -q "^$roll," $FILE; then
            echo "Record already exists!"
        else
            echo "$roll,$name" >> $FILE
            echo "Record added successfully."
        fi
        ;;

    2)
        echo "------ Student Records ------"
        if [ -s $FILE ]; then
            cat $FILE
        else
            echo "No records found."
        fi
        ;;

    3)
        read -p "Enter Roll Number to search: " roll
        if grep -q "^$roll," $FILE; then
            grep "^$roll," $FILE
        else
            echo "Record not found."
        fi
        ;;

    4)
        read -p "Enter Roll Number to update: " roll

        if grep -q "^$roll," $FILE; then
            read -p "Enter new name: " newname
            sed -i "s/^$roll,.*/$roll,$newname/" $FILE
            echo "Record updated successfully."
        else
            echo "Record not found."
        fi
        ;;

    5)
        read -p "Enter Roll Number to delete: " roll

        if grep -q "^$roll," $FILE; then
            sed -i "/^$roll,/d" $FILE
            echo "Record deleted successfully."
        else
            echo "Record not found."
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
