#!/usr/bin/bash

#====================================================================================================
# script name: setup_environment.sh
# description: sets up the logs, configs and scripts directories with sample files. 
# author: Kabera Clapton
# last changed: Oct. 9 2026
# usage: ./setup_environment.sh
#====================================================================================================


#----------------------------------------------------------------------------------------------------
# The program uses three arrays one to store all the directories that need to be created 'directories'
# another to store files that will be created in each directory 'files', one to store the dummy 
# contents that will go in each file 'content' and lastly one to store the permissions for each file
# 'permissions'.
#
# For each array, the directory at index 0 of the directory array, will have the file at index 0 of the
# files array, contain the contents at index 0 of the contents array and have the file permssions at 
# index 0 of the permissions array. This is so that if the directory already exists, the corresponding
# files and permission commands are not executed but this should only be for the directory that exists
# already and not for all the others.
#-----------------------------------------------------------------------------------------------------

directories=("logs" "configs" "scripts")

files=("system.log" "app.conf" "backup.sh")

content=(
"192.168.1.50 - - [18/Mar/2024:10:15:32 +0000] \"GET /api/v1/products HTTP/1.1\" 200 1234 \"https://example.com/\"Mozilla/5.0 (Windows NT 10.0; Win64; x64)\""
"[app]\napp_name = MyWebAPI\nenvironment = production\ndebug_mode = false\nversion = 1.2.0"
"#!/usr/bin/bash\n\n# This file executes a backup cron job for the amalitech core app\n"
)

permissions=(644 444 755)

# counter to tell which index we are at in the three arrays.
# increments regardless of the situation.
i=0

# iterate over the directories array
for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        # if array exists then print the error message and go to the next dir
        echo "Directory already exists: $dir"
    else
        # create the directory if it doesn't exist and corresponding 
        # files assigning permissions to each file
        mkdir "$dir"
        echo -e "${content[i]}" > "$dir/${files[i]}"
        chmod "${permissions[i]}" "$dir/${files[i]}"
    fi
    ((i++))
done

echo -e "\n--------------------\nDirectory Structure\n--------------------\n"

# print the directory structure as a tree
tree -phDC
