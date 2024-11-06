#!/bin/bash
cd /server

#######
#   APPLY ENVIRONMENT VARIABLES TO THE SERVER.CFG
#######

# Get all environment variables starting with SAMP_
ENV_SAMP_VARS=$(env | grep '^SAMP_')

echo "All Environment variables:"
env
echo -e "\nSAMP Environment variables:"
echo "$ENV_SAMP_VARS"

# Create a temporary copy of server.cfg
cp server.cfg /tmp/server.cfg.tmp

# Loop through each environment variable
while IFS= read -r ENV_VAR; do
    echo -e "\nProcessing variable \"$ENV_VAR\""
    # Temporarily change Internal Field Separator to '=' to split the variable into name and value
    IFS='=' read -r VAR_NAME VAR_VALUE <<< "$ENV_VAR"

    # Remove the SAMP_ prefix and convert the rest to lowercase
    VAR_NAME=$(echo "$VAR_NAME" | sed 's/^SAMP_//g' | tr '[:upper:]' '[:lower:]')

    echo "Checking for \"$VAR_NAME\" in configuration"
    # Check if the variable is already in the server configuration
    if grep -q "^$VAR_NAME" /tmp/server.cfg.tmp; then
        echo "Found \"$VAR_NAME\" key, setting value to $VAR_VALUE"
        # If it is, replace the value
        sed -i "s/^$VAR_NAME.*/$VAR_NAME $VAR_VALUE/g" /tmp/server.cfg.tmp
    else
        echo "Did not find $VAR_NAME in server configuration, adding it with value $VAR_VALUE"
        # If it isn't, add it to the end of the file
        echo "$VAR_NAME $VAR_VALUE" >> /tmp/server.cfg.tmp
    fi
done <<< "$ENV_SAMP_VARS"

echo -e "\nSaving configuration..."
# Write the content of the temporary file back to the server.cfg
cat /tmp/server.cfg.tmp > server.cfg
# Remove the temporary file
rm /tmp/server.cfg.tmp
echo "Configuration saved."

#######
#   RUN THE SERVER
#######

# Either run the Dockerfile CMD or the SAMP server
if [ $# -gt 0 ]; then
    echo -e "\nAlternative launching method: $@"
    sh -c "$@"
else
    echo -e "\nRunning the SAMP server..."
    ./samp03svr
fi

# Save the exit code of whatever we ran
EXIT_CODE=$?

exit $EXIT_CODE

