FROM debian:stable-slim

# Create the server folder
RUN mkdir -p /server
# Work in the server folder
WORKDIR /server

# Install glibc compatibility layer
RUN dpkg --add-architecture i386 && \
	apt-get clean && \
 	apt-get update && \
 	apt-get upgrade -y && \
 	apt-get install libstdc++6:i386 -y

# Create required directories
RUN mkdir -p filterscripts gamemodes npcmodes npcmodes/recordings plugins scriptfiles

# Copy the binaries and required files to the container
COPY server/ /server/
COPY entrypoint.sh /entrypoint.sh

# Give execution rights on binaries
RUN chmod +x announce samp03svr samp-npc


# Redirect the server log to stdout to display the output in the docker logs
RUN ln -sf /dev/stdout /server/server_log.txt

# Expose the default port
EXPOSE 7777/udp

# Use the start script as entrypoint
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]