#!/bin/sh

# Ensure the shared directory exists inside the container
if [ ! -d "/shared" ]; then
    mkdir -p /shared
    chmod -R 0777 /shared
fi

# Add user with environment variables if provided
if [ -n "$USERNAME" ] && [ -n "$PASSWORD" ]; then
    adduser -D -H -s /sbin/nologin -G smbgroup $USERNAME
    echo -e "$PASSWORD\n$PASSWORD" | smbpasswd -s -a $USERNAME
fi

# Dynamically configure the Samba share name from the environment variable
if [ -n "$SHARE_NAME" ]; then
    echo "Updating Samba share name to: $SHARE_NAME"
    # Update the share section of smb.conf with the desired share name
    sed -i "s/\[shared\]/\[$SHARE_NAME\]/g" /etc/samba/smb.conf
fi

# Execute the command passed as arguments (CMD from Dockerfile)
exec "$@"
