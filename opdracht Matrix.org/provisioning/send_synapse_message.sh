#!/bin/bash

# Take care of sending message to our room

# Load environment variables
source /home/vagrant/synapse/calculated-environment-vars

# Prepare the message
MESSAGE_BOT="$1"

# Send the message
response=$(curl -s -w "\n%{http_code}" -XPOST -H "Authorization: Bearer $ACCESS_TOKEN_bot" -H 'Content-Type: application/json' -d "{\"msgtype\":\"m.text\",\"body\":\"$MESSAGE_BOT\"}" "$SYNAPSE_SERVER/_matrix/client/r0/rooms/${ROOM_ID}/send/m.room.message")

# Extract the HTTP status code from the response
http_status=$(echo "$response" | tail -n1)

if [[ "$http_status" -ne 200 ]]; then
  # Give error message if unsuccessful
  echo "Failed to send the message. HTTP status was $http_status"
  #exit 1
fi