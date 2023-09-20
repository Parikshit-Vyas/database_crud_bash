#                             Online Bash Shell.
#                 Code, Compile, Run and Debug Bash script online.
# Write your code in this editor and press "Run" button to execute it.

#                             Online Bash Shell.
#                 Code, Compile, Run and Debug Bash script online.
# Write your code in this editor and press "Run" button to execute it.

timeout=10000

function log()
{
#	TODO Write activities to log files along with timestamp, pass argument as a string
datetime=`date +"%Y-%m-%d %T"`
echo "$1 : logged at : $datetime" >> log.txt
    
}

function menu_header(){
	# TODO Just to print welcome menu presntation
		
	echo ----------------------
	echo Database project
	echo Author : Parikshit Vyas
	echo ----------------------
	echo 1. Add an entry
	echo 2. Search/Edit entry
	echo x. Exit 
	echo Note : Script timeout is set
	echo Choose your option : 
    echo " "	
    echo " "	
	
	read option
}


function edit_operation()
{
	# TODO Provide an option to change fields of an entry
	# 1. Ask user about the field to edit
	# 2. As per user selection, prompt a message to enter respected value
	# 3. Verify the user entry to field for matching. Eg mob number only 10 digits to enter
    # 4. Prompt error in case any mismatch of entered data and fields
    
    # validate_entry 
    echo "Do you want to edit this field ?(y/n)"
    echo " "
    read yn
    
    case $yn in
        y)
            echo "Enter the changed value :"
            read edited
            sed -i "s|$2|$edited|g" database.csv
            log "Edit entry : $2 to $edited"
            ;;
        *)
            ;;
            
    esac
    
    
}

function search_operation()
{
	# TODO Ask user for a value to search
	# 1. Value can be from any field of an entry.
	# 2. One by one iterate through each line of database file and search for the entry
	# 3. If available display all fiels for that entry
	# 4. Prompt error incase not available
	echo "Searching for $1 ..."
	echo " "
	
    awk '/'$1'/' database.csv
    
	
}

function search_and_edit()
{
	# TODO UI for editing and searching 
	# 1. Show realtime changes while editing
	# 2. Call above functions respectively
	echo "Search / Edit by :"
	echo ""
	echo "1. Name : "
    echo "2. Email : "
    echo "3. Mobile : "
    echo "x. Exit : "
    echo " \n"
    echo "Please enter field to search : "
    
    
    
    read option2
    
    case $option2 in 
        1)
            echo "Please enter name :"
            read search_name
            search_operation $search_name
            edit_operation $option2 $search_name
            ;;
        2)
            echo "Please enter email :"
            read search_email
            search_operation $search_email
            edit_operation $option2 $search_email
            ;;
        3)
            echo "Please enter mobile :"
            read search_mobile
            search_operation $search_mobile
            edit_operation $option2 $search_mobile
            ;;
            
        x)
            ;;
        *)
            ;;
    esac
}


function validate_entry()
{
	# TODO Inputs entered by user must be verified and validated as per fields
	# 1. Names should have only alphabets
	# 2. Emails must have a @ symbols and ending with .<domain> Eg: user@mail.com
	# 3. Mobile/Tel numbers must have 10 digits .
	# 4. Place must have only alphabets
	case $1 in
	    1)
	        if [[ $2 =~ ^[a-zA-Z]+$ ]]; then
                echo "Name valdiated"
            else
                echo "Reenter name"
                add_entry
            fi
            ;;
        2)
	        if [[ $2 =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$ ]]; then
                echo "Email valdiated"
            else
                echo "Reenter email"
                add_entry
            fi
            ;;
        3)
	        if [[ $2 =~ ^[0-9]{10}$ ]]; then
                echo "Mobile no valdiated"
            else
                echo "Reenter mobile no"
                add_entry
            fi
            ;;
        *)
            echo "Default option"
            ;;
    esac    
    
}

function add_entry()
{
	# TODO adding a new entry to database
	# 1. Validates the entries
	# 2. Add to database
	echo "Add new entry scene"
	echo ""
	echo "1.Name \t\t : $1"
	echo "2.Email \t\t : $2"
	echo "3.Mobile \t\t : $3"
	echo "4.Message \t\t : $4"
	echo "x.Exit to add entry into database"
	
	echo "Please choose field to be added"
	read option1
	case $option1 in 
	    1)
	        echo "Add name"
	        read add_name
	        validate_entry $option1 $add_name
	        add_entry $add_name
	        ;;
	    2)
	        echo "Add email"
	        read add_email
	        validate_entry $option1 $add_email
	        add_entry $add_name $add_email
	        ;;
	    3)
	        echo "Add mobile"
	        read add_mobile
	        validate_entry $option1 $add_mobile
	        add_entry $add_name $add_email $add_mobile
	        ;;
	    4)  
	        
	        echo "Add message"
	        read add_message
	        add_entry $add_name $add_email $add_mobile $add_message
	        ;;
	    x)  
	        echo "$add_name,$add_email,$add_mobile,$add_message" >> database.csv
	        
	        echo "Added to database.csv"
	        log " Add entry : $add_name,$add_email,$add_mobile,$add_message"
	        ;; 
	    *)
	        echo "No option matching"
	        add_entry $add_name $add_email $add_mobile $add_message
	        ;;
	        
	 esac
	
}

if ! test -f database.csv; then
    echo "Creating database file"
    touch database.csv
    echo "name,email,mobile,message" >> database.csv
fi

if ! test -f log.txt; then
    echo "Creating log file"
    touch log.txt
fi

while [ 1 ]
do
	# TODO call the appropriate functions in order
	menu_header
	case $option in 
	    1)
	        add_entry
	        ;;
	    2)
	        search_and_edit
	        ;;
	    x)
	        echo "You are exiting"  
	        break
	        ;;
	    *)  
	        echo "No option matches"
	        ;;
	 esac
done

