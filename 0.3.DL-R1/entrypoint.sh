#!/bin/bash
cd /server

#######
#   APPLY ENVIRONMENT VARIABLES TO THE SERVER.CFG
#######

# Get all environment variables starting with SAMP_
ENV_SAMP_VARS=$(env | grep '^SAMP_')

# Create a temporary copy of server.cfg
cp server.cfg /tmp/server.cfg.tmp

# Loop through each environment variable
while IFS= read -r ENV_VAR; do
    # Temporarily change Internal Field Separator to '=' to split the variable into name and value
    IFS='=' read -r VAR_NAME VAR_VALUE <<< "$ENV_VAR"

    # Remove the SAMP_ prefix and convert the rest to lowercase
    VAR_NAME=$(echo "$VAR_NAME" | sed 's/^SAMP_//g' | tr '[:upper:]' '[:lower:]')

    # Check if the variable is already in the server configuration
    if grep -q "^$VAR_NAME" /tmp/server.cfg.tmp; then
        # If it is, replace the value
        sed -i "s/^$VAR_NAME.*/$VAR_NAME $VAR_VALUE/g" /tmp/server.cfg.tmp
    else
        # If it isn't, add it to the end of the file
        echo "$VAR_NAME $VAR_VALUE" >> /tmp/server.cfg.tmp
    fi
done <<< "$ENV_SAMP_VARS"

# Write the content of the temporary file back to the server.cfg
cat /tmp/server.cfg.tmp > server.cfg
# Remove the temporary file
rm /tmp/server.cfg.tmp

#######
#   RUN THE SERVER
#######

# Either run the Dockerfile CMD or the SAMP server
if [ $# -gt 0 ]; then
    echo -e "\nAlternative launching method: $@"
    sh -c "$@"
else
    ./samp03svr
fi

# Save the exit code of whatever we ran
EXIT_CODE=$?

exit $EXIT_CODE

