# Use Ubuntu as the base image
FROM alpine:latest

# Install Samba
RUN apk add --no-cache samba samba-common-tools

# Create a directory that will be shared
RUN mkdir -p /shared

# Set up the Samba configuration file
RUN mkdir -p /etc/samba && \
    cat <<EOF > /etc/samba/smb.conf
[global]
   security = user
   map to guest = never

[shared]
   path = /shared
   browsable = yes
   writable = yes
   valid users = @smbgroup
   read only = no
EOF

# Set permissions for the shared directory
RUN chmod -R 0777 /shared

# Create a user group for Samba users
RUN addgroup -S smbgroup

# Ensure the directory exists before copying
RUN mkdir -p /usr/local/bin

# Copy the entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN ls -lah /usr/local/bin/docker-entrypoint.sh  # Debugging step

# Expose the necessary port for Samba (port 445 for SMB)
EXPOSE 445

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Start the Samba service in foreground mode
CMD ["smbd", "--foreground", "--no-process-group"]
