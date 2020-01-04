#!/bin/bash
file=/etc/phonebookDB.txt

if ! [ -f "$file" ]; then
	sudo touch /etc/phonebookDB.txt
	cd /etc
	sudo chmod a+rwx phonebookDB.txt
fi

if [ -z $1 ]; then
	echo "-i to add new record" 
	echo "-v to view all data"
	echo "-s to search for a phone record"
	echo "-e to delete all data"
	echo "-d to delete one contact"
fi
if [[ $1 == "-i" ]] ;then
	echo "Create a new record "
	read -p "Enter First Name: " fname
	read -p "Enter Last  Name: " lname	
	read -p "Enter number of available Phone Nums: " num
	i=1	
	c=""
	while [ $i -le $num ] ;do
	read -p "enter the phone # $i : " data
	c+="$data "
	i=$[ $i + 1 ]	
	done	
	echo $fname $lname $c >> $file
	exit
fi

if [[ $1 == "-s" ]] ;then
	echo "Search For a Record "
	read -p "Enter first or last name or phonenumber as a seach key: " searchkey
	found=$(grep $searchkey $file)
	if [ -z "$found" ]; then
	echo "No Item Found"
	else
	grep $searchkey $file | while read -r line ; do
	i=$[ $i + 1 ]
	echo "$i $line"
	done
	fi
fi

if [[ $1 == "-v" ]] ;then
	echo "Viewing all contacts list.."
	cat $file | while read -r line ; do
	i=$[ $i + 1 ]
	echo "$i $line"
	done
fi

if [[ $1 == "-e" ]] ;then
	echo "Delete all contacts"
	 > $file
fi
if [[ $1 == "-d" ]] ;then
	 echo "Search a Record"
	read -p "Enter First or last Name or phone number of the record you wanna delete : " search
	found=$(grep "$search" $file)
	if  [ -z "$found" ] ;then
	echo "No Item found"
	else 
	grep "$search" $file | while read -r line ; do
	i=$[ $i +1 ]
    	echo "$i $line"
	done
	read -p "Enter number you wanna delete: " deleteNo
	i=0
	grep "$search" $file | while read -r line ; do
	i=$[ $i +1 ]
	if [ $deleteNo -eq $i ] ;then
	echo "`sed  /"$line"/d  $file`" > $file

	fi
	done
	
	fi
fi


