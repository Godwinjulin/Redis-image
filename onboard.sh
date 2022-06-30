# Shell scripting.
# This script will read a csv file that contains 20 new linux users.
# This script will create each user on the server and add to an existing group called 'Developers'.
# This script will first check for the existance of the user on the system, before it will attempt to create.
# The user that is being created also must also have a defualt home folder 
# Each user should have a .ssh folder within its HOME folder. if it does not exist, then it will be created.
# For each user's SSH configuration, we will create an authorized_keys files and add the below public key

#!/bin/bash 
userfile=$(cat names.csv)
PASSWORD=password

   if [ $(id -u) -eq 0]; then

# Reading the csv file 
       for user in $userfile;
       do
           echo $user
        if id "$user" &>/dev/null
        then
          echo "user Exist"
        else

# This will create a new user 
       useradd -m -d /home/$user -s /bin/bash -g developers $user
       echo "New user Created"   
       echo

# This will create a ssh folder in the user home folder
       su - -c "mkdir ~/.ssh" $user
       echo ".ssh directory created for new user"
       echo


# We need to set the user permission for the ssh dir
      su - -c "chmod 700 ~/.ssh" $user
      echo "user permission for .ssh directory set"
      echo

# This will create an authorized-key file 
      su - -c "touch ~/.ssh/authorized_key" $user
      echo "Authorized Key File Created"
      echo

# We need to set permission for the key file 
      su - -c "chmod 600 ~/.ssh/authorized_keys" $user
      echo "user permission for the Authorized Key File set"
      echo

# We need to create and set public key for the users in the server 
     cp -R "/root/onboard/id_rsa.pub" "/home/$user/.ssh/authorized_keys"
     echo "Copied the Public key to New User Account on the server"
     echo
     echo
     
     echo "USER CREATED"

# Generate a password.
sudo echo -e "$PASSWORD\n$PASSWORD" | sudo passwd "$user"
sudo passwd -x 5 $user
             fi
        done
    else
    echo "Only Admin Can Onboard A User"
    fi    

