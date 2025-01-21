#!/bin/bash

# Define variables
API_URL="https://pokeapi.co/api/v2/pokemon/pikachu"
DATA_FILE="data.json"
ERROR_FILE="errors.txt"

# Make the API request using curl
response=$(curl -s -w "%{http_code}" -o temp.json "$API_URL")
http_code=$(tail -n1 <<< "$response")

# Check the HTTP status code
if [ "$http_code" -eq 200 ]; then
    # Request was successful; save the response
    mv temp.json "$DATA_FILE"
    echo "Data saved to $DATA_FILE"
else
    # Request failed; log the error
    echo "$(date) - Failed to fetch data. HTTP status code: $http_code" >> "$ERROR_FILE"
    rm -f temp.json
    echo "Error logged to $ERROR_FILE"
fi
