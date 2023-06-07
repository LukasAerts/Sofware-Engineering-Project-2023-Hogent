#!/bin/bash
set +e ## don't shut down on USER ALREADY EXISTS ERROR
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------
# Define the users we will use in script. Form user:pass
USERS=(
    "olivier:olivier"
    "naoufal:naoufal"
    "stein:stein"
    "benny:benny"
    "lukas:lukas"
    "user:user"
    "bot:bot"
    "admin:admin"
)

# The URL of our Synapse server
export SYNAPSE_SERVER="http://theoracle.thematrix.local"
#echo "export SYNAPSE_SERVER=\"$SYNAPSE_SERVER\"" >> ~/.bashrc
echo "SYNAPSE_SERVER=\"$SYNAPSE_SERVER\"" >> /home/vagrant/synapse/calculated-environment-vars

# Room name we will use
export ROOM_NAME="WE ARE HOGENT"
#echo "export ROOM_NAME=\"$ROOM_NAME\"" >> ~/.bashrc
echo "ROOM_NAME=\"$ROOM_NAME\"" >> /home/vagrant/synapse/calculated-environment-vars

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# Code
#------------------------------------------------------------------------------
echo "Now configuring the Matrix users and room"
# Create bot and user accounts
source /home/vagrant/synapse/env/bin/activate
for USER_PAIR in "${USERS[@]}"
do
    # Separate user:pass
    USERNAME=$(echo $USER_PAIR | cut -d':' -f1)
    PASSWORD=$(echo $USER_PAIR | cut -d':' -f2)

    # Convert to lowercase
    USERNAME=${USERNAME,,}
    PASSWORD=${PASSWORD,,}

    # Create user ID in form @XX:thematrix.local
    USER_ID="@${USERNAME}:theoracle.thematrix.local"

    # Save variables permanently
    export "USER_ID_${USERNAME^^}=$USER_ID"
    #echo "export USER_ID_${USERNAME^^}=\"$USER_ID\"" >> ~/.bashrc
    echo "USER_ID_${USERNAME^^}=\"$USER_ID\"" >> /home/vagrant/synapse/calculated-environment-vars

    # Save variables permanently with uppercase names and lowercase contents
    export "USER_${USERNAME^^}"="$USERNAME"
    #echo "export USER_${USERNAME^^}=\"$USERNAME\"" >> ~/.bashrc
    echo "USER_${USERNAME^^}=\"$USERNAME\"" >> /home/vagrant/synapse/calculated-environment-vars

    export "PASSWORD_${USERNAME^^}"="$PASSWORD"
    #echo "export PASSWORD_${USERNAME^^}=\"$PASSWORD\"" >> ~/.bashrc
    echo "PASSWORD_${USERNAME^^}=\"$PASSWORD\"" >> /home/vagrant/synapse/calculated-environment-vars

    if [ "$USERNAME" == "admin" ] || [ "$USERNAME" == "bot" ]; then
        echo "Working on user $USERNAME"
        register_new_matrix_user -u $USERNAME -p $PASSWORD -a -c /home/vagrant/synapse/homeserver.yaml
        echo "$USERNAME is an administrator for the server"

        # Generate and save access token for admin users. Saves them.
        ACCESS_TOKEN=$(curl -s -XPOST -H 'Content-Type: application/json' -d "{\"type\":\"m.login.password\",\"user\":\"$USERNAME\",\"password\":\"$PASSWORD\"}" $SYNAPSE_SERVER/_matrix/client/r0/login | jq -r '.access_token')
        export "ACCESS_TOKEN_$USERNAME=$ACCESS_TOKEN"
        #echo "export ACCESS_TOKEN_$USERNAME=\"$ACCESS_TOKEN\"" >> ~/.bashrc
        echo "ACCESS_TOKEN_$USERNAME=\"$ACCESS_TOKEN\"" >> /home/vagrant/synapse/calculated-environment-vars

    else
        echo "Working on user $USERNAME"
        yes no | register_new_matrix_user -u $USERNAME -p $PASSWORD -c /home/vagrant/synapse/homeserver.yaml # Automatically answer "no" to prompt to make admin
        echo "$USERNAME is a normal user for the server"
    fi


done


ROOM_ID=$(curl -s -XPOST -H "Authorization: Bearer $ACCESS_TOKEN_bot" -H 'Content-Type: application/json' -d "{\"preset\":\"public_chat\",\"name\":\"$ROOM_NAME\"}" $SYNAPSE_SERVER/_matrix/client/r0/createRoom | jq -r '.room_id')

# Check if room exists, and if it does not, create it
EXISTING_ROOM=$(curl -s -XGET -H "Authorization: Bearer $ACCESS_TOKEN_bot" $SYNAPSE_SERVER/_synapse/admin/v1/rooms/$ROOM_ID | jq -r '.name')
if [ "$EXISTING_ROOM" == null ]; then
    # Room doesn't exist, so create it
    ROOM_ID=$(curl -s -XPOST -H "Authorization: Bearer $ACCESS_TOKEN_bot" -H 'Content-Type: application/json' -d "{\"preset\":\"public_chat\",\"name\":\"$ROOM_NAME\"}" $SYNAPSE_SERVER/_matrix/client/r0/createRoom | jq -r '.room_id')
    echo "Created room $ROOM_NAME with ID $ROOM_ID"

    # After the ROOM_ID is created, update the variable EXISTING_ROOM again to check if the room exists with the new ID.
    EXISTING_ROOM=$(curl -s -XGET -H "Authorization: Bearer $ACCESS_TOKEN_bot" $SYNAPSE_SERVER/_synapse/admin/v1/rooms/$ROOM_ID | jq -r '.name')
else
    # Room exists, so output message
    echo "Room with ID $ROOM_ID already exists with name $ROOM_NAME. Skipping creation.."
fi

export ROOM_ID
#echo "export ROOM_ID=\"$ROOM_ID\"" >> ~/.bashrc
echo "ROOM_ID=\"$ROOM_ID\"" >> /home/vagrant/synapse/calculated-environment-vars
echo "Room ID:" $ROOM_ID

# Invite users to the room
for USER_PAIR in "${USERS[@]}"
do
    USERNAME=$(echo $USER_PAIR | cut -d':' -f1)
    if [ "$USERNAME" != "bot" ] && [ "$USERNAME" != "admin" ]; then
        echo "Inviting $USERNAME"
        curl -s -XPOST -H "Authorization: Bearer $ACCESS_TOKEN_bot" -H 'Content-Type: application/json' -d "{\"user_id\":\"@$USERNAME:theoracle.thematrix.local\"}"  $SYNAPSE_SERVER/_matrix/client/r0/rooms/$ROOM_ID/invite        
        sleep 5 # Add a delay of 5 seconds
    fi
done

#curl -s -XPOST -H "Authorization: Bearer $ACCESS_TOKEN_bot" -H 'Content-Type: application/json' -d "{\"user_id\":\"$USER_ID_OLIVIER\"}" $SYNAPSE_SERVER/_matrix/client/r0/rooms/$ROOM_ID/invite

# List the users in our room
curl -s -XGET -H "Authorization: Bearer $ACCESS_TOKEN_bot" $SYNAPSE_SERVER/_matrix/client/r0/rooms/$ROOM_ID/members | jq -r '.chunk[].state_key' #by userid
curl -s -XGET -H "Authorization: Bearer $ACCESS_TOKEN_bot" $SYNAPSE_SERVER/_matrix/client/r0/rooms/$ROOM_ID/members | jq -r '.chunk[].content.displayname' #by displayname

# List room name
curl -s -XGET -H "Authorization: Bearer $ACCESS_TOKEN_bot" $SYNAPSE_SERVER/_synapse/admin/v1/rooms/$ROOM_ID | jq '.name'
curl -s -XPOST -H "Authorization: Bearer $ACCESS_TOKEN_bot" -H 'Content-Type: application/json' -d '{"msgtype":"m.text","body":"Hello. This is a message"}' "$SYNAPSE_SERVER/_matrix/client/r0/rooms/${ROOM_ID}/send/m.room.message"

# Export var
MESSAGE_BOT="The server is going down. Mayday Mayday Mayday!"
echo "MESSAGE_BOT=\"$MESSAGE_BOT\"" >> /home/vagrant/synapse/calculated-environment-vars


sudo systemctl daemon-reload

echo "Users and room successfully created and configured!"
