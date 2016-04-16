#################################################################################

#Assumes you are running the jar as "Thermos-server.jar"
#Deletes any file called "Thermos.1.7.10<everything in-between>.jar"
#Assumptions based on use has SSH-KEY password stored in keychain or no password required for SSH-KEY

#################################################################################

#This value is recommended not to change, this is for temp storage only.
FILE_NAME="thermos"

#The location of which the downloaded file is kept temporarily
STORAGE_LOCATION="temp"

#This is the amount of servers that will be added, please keep in the same format
#If you have 4 server it looks like:   SERVERS=(1 2 3 4)
#If you have 6 servers it looks like:  SERVERS=(1 2 3 4 5 6)
#If you have 12 servers it looks like: SERVERS=(1 2 3 4 5 6 7 8 9 10 11 12)
SERVERS=(1)

#################################################################################

###The user that is used to connect to the machine
#SERVER_USER_<number>="<user>"

###The IP that is used to connect to the machine
#SERVER_HOST_<number>="<host>"

###The directory that the server is held in after the user folder
###If the server directory was /home/minecraft/server
###The directory would be anything after "minecraft/"
#SERVER_DIR_<number>="<server directory path after username>"

###The URL for the new jar - MUST BE .ZIP
#SERVER_URL_<number>="<Server jar URL>"

#Replace the number going up from 1 for each server
#Your first server will be 1, your second server will be 2

SERVER_USER_1=""
SERVER_HOST_1=""
SERVER_DIR_1=""
SERVER_URL_1=""

#################################################################################
######################### DO NOT EDIT BEYOND THIS POINT #########################
#################################################################################

ABSOLUTE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_OUTPUT="${ABSOLUTE_PATH}/do-not-edit.sh"

sed -i.bak "s/^FILE_NAME=.*/FILE_NAME=""\""${FILE_NAME}"\"""/" ${SCRIPT_OUTPUT}
sed -i.bak "s,^STORAGE_LOCATION=.*,STORAGE_LOCATION=""\""${STORAGE_LOCATION}"\"""," ${SCRIPT_OUTPUT}

for i in "${SERVERS[@]}"
do
MERGE1="SERVER_USER_$i"
MERGE2="SERVER_HOST_$i"
MERGE3="SERVER_DIR_$i"
MERGE4="SERVER_URL_$i"
sed -i.bak "s,^URL=.*,URL=""\""${!MERGE4}"\"""," ${SCRIPT_OUTPUT}
sed -i.bak "s,^SERVER_DIR=.*,SERVER_DIR=""\""${!MERGE3}"\"""," ${SCRIPT_OUTPUT}
ssh ${!MERGE1}@${!MERGE2} 'bash -s' < ${SCRIPT_OUTPUT}
sleep 1
done
